############################################################
#
#   $Id$
#   Linux::SMBIOS - Interface to SMBIOS under Linux using dmidecode
#
#   Copyright 2006 Nicola Worthington
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
############################################################

package Linux::SMBIOS;
# vim:ts=4:sw=4:tw=78

use strict;
use Carp qw(croak cluck confess carp);
use vars qw($VERSION $DEBUG);

$VERSION = '0.01' || sprintf('%d', q$Revision$ =~ /(\d+)/g);
$DEBUG ||= $ENV{DEBUG} ? 1 : 0;


#
# Methods
#

# Create a new object
sub new {
	ref(my $class = shift) && croak 'Class name required';
	croak 'Odd number of elements passed when even was expected' if @_ % 2;
	my $self = { @_ };

	my $validkeys = join('|',qw(rrdtool cf default_dstype default_dst));
	cluck('Unrecognised parameters passed: '.
		join(', ',grep(!/^$validkeys$/,keys %{$self})))
		if (grep(!/^$validkeys$/,keys %{$self}) && $^W);

	$self->{rrdtool} = _find_binary(exists $self->{rrdtool} ?
						$self->{rrdtool} : 'rrdtool');

	$self->{default_dstype} ||= $self->{default_dst};

	#$self->{cf} ||= [ qw(AVERAGE MIN MAX LAST) ];
	# By default, now only create RRAs for AVERAGE and MAX, like
	# mrtg v2.13.2. This is to save disk space and processing time
	# during updates etc.
	$self->{cf} ||= [ qw(AVERAGE MAX) ]; 
	$self->{cf} = [ $self->{cf} ] if !ref($self->{cf});

	bless($self,$class);
	DUMP($class,$self);
	return $self;
}


# Create a new RRD file
sub create {
	my $self = shift;
	unless (ref $self && UNIVERSAL::isa($self, __PACKAGE__)) {
		unshift @_, $self unless $self eq __PACKAGE__;
		$self = new __PACKAGE__;
	}

	# Grab or guess the filename
	my $rrdfile = (@_ % 2 && !_valid_scheme($_[0]))
				|| (!(@_ % 2) && _valid_scheme($_[1]))
					? shift : _guess_filename();
	croak "RRD file '$rrdfile' already exists" if -f $rrdfile;
	TRACE("Using filename: $rrdfile");

	# We've been given a scheme specifier
	# Until v1.32 'year' was the default. As of v1.33 'mrtg'
	# is the new default scheme.
	#my $scheme = 'year';
	my $scheme = 'mrtg';
	if (@_ % 2 && _valid_scheme($_[0])) {
		$scheme = _valid_scheme($_[0]);
		shift @_;
	}
	TRACE("Using scheme: $scheme");

	croak 'Odd number of elements passed when even was expected' if @_ % 2;
	my %ds = @_;
	DUMP('%ds',\%ds);

	my $rrdDef = _rrd_def($scheme);
	my @def = ('-b', time - _seconds_in($scheme,120));
	push @def, '-s', ($rrdDef->{step} || 300);

	# Add data sources
	for my $ds (sort keys %ds) {
		$ds =~ s/[^a-zA-Z0-9_-]//g;
		push @def, sprintf('DS:%s:%s:%s:%s:%s',
						substr($ds,0,19),
						uc($ds{$ds}),
						($rrdDef->{heartbeat} || 600),
						'U','U'
					);
	}

	# Add RRA definitions
	my %cf;
	for my $cf (@{$self->{cf}}) {
		$cf{$cf} = $rrdDef->{rra};
	}
	for my $cf (sort keys %cf) {
		for my $rra (@{$cf{$cf}}) {
			push @def, sprintf('RRA:%s:%s:%s:%s',
					$cf, 0.5, $rra->{step}, $rra->{rows}
				);
		}
	}

	DUMP('@def',\@def);

	# Pass to RRDs for execution
	my @rtn = RRDs::create($rrdfile, @def);
	my $error = RRDs::error();
	croak($error) if $error;
	DUMP('RRDs::info',RRDs::info($rrdfile));
	return wantarray ? @rtn : \@rtn;
}






sub _safe_exec {
	croak('Pardon?!') if ref $_[0];
	my $cmd = shift;
	if ($cmd =~ /^([\/\.\_\-a-zA-Z0-9 >]+)$/) {
		$cmd = $1;
		TRACE($cmd);
		system($cmd);
		if ($? == -1) {
			croak "Failed to execute command '$cmd': $!\n";
		} elsif ($? & 127) {
			croak(sprintf("While executing command '%s', child died ".
				"with signal %d, %s coredump\n", $cmd,
				($? & 127),  ($? & 128) ? 'with' : 'without'));
		}
		my $exit_value = $? >> 8;
		croak "Error caught from '$cmd'" if $exit_value != 0;
		return $exit_value;
	} else {
		croak "Unexpected potentially unsafe command will not be executed: $cmd";
	}
}


sub _find_binary {
	croak('Pardon?!') if ref $_[0];
	my $binary = shift || 'rrdtool';
	return $binary if -f $binary && -x $binary;

	my @paths = File::Spec->path();
	my $rrds_path = dirname($INC{'RRDs.pm'});
	push @paths, $rrds_path;
	push @paths, File::Spec->catdir($rrds_path,
				File::Spec->updir(),File::Spec->updir(),'bin');

	for my $path (@paths) {
		my $filename = File::Spec->catfile($path,$binary);
		return $filename if -f $filename && -x $filename;
	}

	my $path = File::Spec->catdir(File::Spec->rootdir(),'usr','local');
	if (opendir(DH,$path)) {
		my @dirs = sort { $b cmp $a } grep(/^rrdtool/,readdir(DH));
		closedir(DH) || carp "Unable to close file handle: $!";
		for my $dir (@dirs) {
			my $filename = File::Spec->catfile($path,$dir,'bin',$binary);
			return $filename if -f $filename && -x $filename;
		}
	}
}


sub TRACE {
	return unless $DEBUG;
	carp(shift());
}


sub DUMP {
	return unless $DEBUG;
	eval {
		require Data::Dumper;
		$Data::Dumper::Indent = 2;
		$Data::Dumper::Terse = 1;
		carp(shift().': '.Data::Dumper::Dumper(shift()));
	}
}

1;


=pod

=head1 NAME

Linux::SMBIOS - Interface to SMBIOS under Linux using dmidecode

=head1 SYNOPSIS

 use strict;
 use Linux::SMBIOS ();
 
 # Create an interface object
 my $smbios = new Linux::SMBIOS;

=head1 DESCRIPTION

=head1 METHODS

=head2 new

=head2 probe

=head1 SEE ALSO

examples/*.pl,
L<http://www.nongnu.org/dmidecode/>,
L<http://linux.dell.com/libsmbios/>,
L<http://sourceforge.net/projects/x86info/>,
L<http://www.dmtf.org/standards/smbios>

=head1 VERSION

$Id$

=head1 AUTHOR

Nicola Worthington <nicolaw@cpan.org>

L<http://perlgirl.org.uk>

If you like this software, why not show your appreciation by sending the
author something nice from her
L<Amazon wishlist|http://www.amazon.co.uk/gp/registry/1VZXC59ESWYK0?sort=priority>? 
( http://www.amazon.co.uk/gp/registry/1VZXC59ESWYK0?sort=priority )

=head1 COPYRIGHT

Copyright 2006 Nicola Worthington.

This software is licensed under The Apache Software License, Version 2.0.

L<http://www.apache.org/licenses/LICENSE-2.0>

=cut


__END__



