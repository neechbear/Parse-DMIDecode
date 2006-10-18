############################################################
#
#   $Id$
#   Parse::DMIDecode - Interface to SMBIOS under Linux using dmidecode
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

package Parse::DMIDecode;
# vim:ts=4:sw=4:tw=78

use strict;
use Scalar::Util qw(refaddr);
use Parse::DMIDecode::Handle;
use Parse::DMIDecode::Constants qw(@TYPES %GROUPS);
use Carp qw(croak cluck confess carp);
use vars qw($VERSION $DEBUG);

$VERSION = '0.01' || sprintf('%d', q$Revision$ =~ /(\d+)/g);
$DEBUG ||= $ENV{DEBUG} ? 1 : 0;

my $objstore = {};


#
# Methods
#

sub new {
	ref(my $class = shift) && croak 'Class name required';
	croak 'Odd number of elements passed when even was expected' if @_ % 2;

	my $self = bless \(my $dummy), $class;
	$objstore->{refaddr($self)} = {};
	my $stor = $objstore->{refaddr($self)};

	$stor->{commands} = [qw(dmidecode)];
	my $validkeys = join('|',@{$stor->{commands}});
	my @invalidkeys = grep(!/^$validkeys$/,grep($_ ne 'commands',keys %{$stor}));
	cluck('Unrecognised parameters passed: '.join(', ',@invalidkeys))
		if @invalidkeys && $^W;

	for my $command (@{$stor->{commands}}) {
		croak "Command $command '$stor->{$command}'; file not found"
			if defined $stor->{$command} && !-f $stor->{$command};
	}

	DUMP('$self',$self);
	DUMP('$stor',$stor);
	return $self;
}


sub probe {
	my $self = shift;
	croak 'Not called as a method by parent object'
		unless ref $self && UNIVERSAL::isa($self, __PACKAGE__);

	my $stor = $objstore->{refaddr($self)};
	eval {
		if (!defined $stor->{dmidecode}) {
			require File::Which;
			for my $command (@{$stor->{commands}}) {
				$stor->{$command} = File::Which::which($command)
					if !defined $stor->{$command};
			}
		}
	};
	croak $@ if $@;

	my ($cmd) = $stor->{dmidecode} =~ /^([\/\.\_\-a-zA-Z0-9 >]+)$/;
	TRACE($cmd);

	my $fh;
	delete @ENV{qw(IFS CDPATH ENV BASH_ENV PATH)};
	open($fh,'-|',$cmd) || croak "Unable to open file handle for command '$cmd': $!";
	while (local $_ = <$fh>) {
		$stor->{raw} .= $_;
	}
	close($fh) || carp "Unable to close file handle for command '$cmd': $!";

	return $self->parse($stor->{raw});
}


sub parse {
	my $self = shift;
	croak 'Not called as a method by parent object'
		unless ref $self && UNIVERSAL::isa($self, __PACKAGE__);

	my $stor = $objstore->{refaddr($self)};
	$stor->{parsed} = $self->_parse(join('',@_));
	return $stor->{parsed}->{structures};
}


sub get_handles {
	my $self = shift;
	croak 'Not called as a method by parent object'
		unless ref $self && UNIVERSAL::isa($self, __PACKAGE__);

	croak 'Odd number of elements passed when even was expected' if @_ % 2;
	my %param = @_;
	my $stor = $objstore->{refaddr($self)};
	my @handles;

	for my $handle (@{$stor->{parsed}->{handles}}) {
		if ((defined $param{address} && $handle->address eq $param{address}) ||
			(defined $param{dmitype} && $handle->dmitype == $param{dmitype}) ||
			(defined $param{group} && defined $GROUPS{$param{group}} &&
			 grep($_ == $handle->dmitype,@{$GROUPS{$param{group}}}))
			) {
			push @handles, $handle;
		}
	}

	return @handles;
}


sub handle_addresses {
	my $self = shift;
	croak 'Not called as a method by parent object'
		unless ref $self && UNIVERSAL::isa($self, __PACKAGE__);

	my $stor = $objstore->{refaddr($self)};
	return map { $_->handle } @{$stor->{parsed}->{handles}};
}


sub keyword {
	my $self = shift;
	croak 'Not called as a method by parent object'
		unless ref $self && UNIVERSAL::isa($self, __PACKAGE__);

	my $stor = $objstore->{refaddr($self)};
	return unless defined $stor->{parsed}->{handles};

#	my $type = '';
#	my $keyword = shift || '';
#	($type,$keyword) = $keyword =~ /^\s*(\S+?)\-(\S+)\s*$/;
#	croak 'Missing or invalid keyword where keyword was expected'
#		unless defined $keyword && $keyword &&
#		defined $type && defined $GROUPS{$type};
#
#	my $dmitypes = '('. join('|',@{$GROUPS{$type}}) .')';
#	TRACE("$type -> $keyword -> $dmitypes");
#
#	my @rtn;
#	my $hdat = $stor->{parsed}->{handles};
#
#	for my $handle (grep(/\*$dmitypes$/,keys %{$hdat})) {
#		TRACE(" > $handle");
#		for my $name (keys %{$hdat->{$handle}->{data}}) {
#			TRACE(" > $handle > $name");
#			for my $key (keys %{$hdat->{$handle}->{data}->{$name}}) {
#				TRACE(" > $handle > $name > $key"); 
#				(my $comp_key = lc($key)) =~ s/\s+/-/g;
#				if ($comp_key eq $keyword) {
#					TRACE(" > $handle > $name > $key > $comp_key > *MATCH*");
#					if (wantarray && @{$hdat->{$handle}->{data}->{$name}->{$key}->[1]} >= 1) {
#						TRACE("[1]");
#						push @rtn, $hdat->{$handle}->{data}->{$name}->{$key}->[1];
#					} else {
#						TRACE("[0]");
#						push @rtn, $hdat->{$handle}->{data}->{$name}->{$key}->[0];
#					}
#				}
#			}
#		}
#	}
#
#	DUMP('@rtn',\@rtn);
#
#	if (@rtn == 1) {
#		return wantarray ? ref($rtn[0]) eq 'ARRAY' ? @{$rtn[0]} : ($rtn[0]) : $rtn[0];
#	} elsif (@rtn > 1 && $^W) {
#		carp "Multiple (". scalar(@rtn) .") matches found; unable to return a specific value";
#	}
#	return;
}



#
# Private methods
#

sub _parse {
	my ($self,$str) = @_;
	my %data = (handles => []);

	my @lines = split(/\n/,$str);
	my $i = 0;
	for (; $i < @lines; $i++) {
		local $_ = $lines[$i];
		if (/^Handle [0-9A-Fx]+/) {
			last;
		} elsif (/^# dmidecode ([\d\.]+)\s*$/) {
			$data{dmidecode} = $1;
		} elsif (/^(\d+) structures occupying (\d+) bytes?\.\s*$/) {
			$data{structures} = $1;
			$data{bytes} = $2;
		} elsif (/^SMBIOS ([\d\.]+) present\.?\s*$/) {
			$data{smbios} = $1;
		} elsif (/^Table at ([0-9A-Fx]+)\.?\s*$/) {
			$data{location} = $1;
		}
	}

	my $handle = '';
	for (; $i < @lines; $i++) {
		if ($lines[$i] =~ /^Handle [0-9A-Fx]+/) {
			push @{$data{handles}}, Parse::DMIDecode::Handle->new($handle) if $handle;
			$handle = "$lines[$i]\n";
		} else {
			$handle .= "$lines[$i]\n";
		}
	}
	push @{$data{handles}}, Parse::DMIDecode::Handle->new($handle);

	carp sprintf("Only parsed %d structures when %d were expected",
			@{$data{handles}}, $data{structures}
		) if @{$data{handles}} != $data{structures};

	return \%data;
}


sub DESTROY {
	my $self = shift;
	delete $objstore->{refaddr($self)};
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

Parse::DMIDecode - Interface to SMBIOS under Linux using dmidecode

=head1 SYNOPSIS

 use strict;
 use Parse::DMIDecode ();
 
 my $dmi = new Parse::DMIDecode;
 $dmi->probe;
 
 printf("System: %s, %s",
         $dmi->keyword("system-manufacturer"),
         $dmi->keyword("system-product-name"),
     );

=head1 DESCRIPTION

This module provides an OO interface to SMBIOS information through
the I<dmidecode> command which is known to work under a number of
Linux, BSD and BeOS variants.

=head1 METHODS

=head2 new

 my $dmi = Parse::DMIDecode->new(dmidecode => "/usr/sbin/dmidecode");

=head2 probe

 $dmi->probe;

=head2 parse

 my $raw = qx(sudo /usr/sbin/dmidecode);
 $dmi->prase($raw);

=head2 keyword

 my $serial_number = $dmi->keyword("system-serial-number");

=head2 keywords

 my @keywords = $dmi->keywords;
 my @bios_keywords = $dmi->keywords("bios");
 
 for my $keyword (@bios_keywords) {
     printf("%s => %s\n",
             $keyword,
             $dmi->keyword($keyword)
         );
 }

=head2 handle_addresses

 my @addresses = $dmi->handle_addresses;

=head1 SEE ALSO

examples/*.pl,
L<http://www.nongnu.org/dmidecode/>,
L<http://linux.dell.com/libsmbios/>,
L<http://sourceforge.net/projects/x86info/>,
L<http://www.dmtf.org/standards/smbios>,
L<biosdecode(8)>, L<dmidecode(8)>, L<vpddecode(8)>

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



