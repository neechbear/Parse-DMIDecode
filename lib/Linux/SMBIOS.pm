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

sub new {
	ref(my $class = shift) && croak 'Class name required';
	croak 'Odd number of elements passed when even was expected' if @_ % 2;
	my $self = { @_ };

	my @commands = qw(dmidecode biosdecode x86info);
	my $validkeys = join('|',@commands);
	cluck('Unrecognised parameters passed: '.
		join(', ',grep(!/^$validkeys$/,keys %{$self})))
		if (grep(!/^$validkeys$/,keys %{$self}) && $^W);

	for my $command (@commands) {
		croak "Command $command '$self->{$command}'; file not found"
			if defined $self->{$command} && !-f $self->{$command};
	}

	if (!defined $self->{dmidecode}) {
		require File::Which;
		for my $command (@commands) {
			$self->{$command} = File::Which::which($command)
				if !defined $self->{$command};
		}
	}

	bless($self,$class);
	DUMP($class,$self);
	return $self;
}


sub probe {
	my $self = shift;
	unless (ref $self && UNIVERSAL::isa($self, __PACKAGE__)) {
		unshift @_, $self unless $self eq __PACKAGE__;
		$self = new __PACKAGE__;
	}

	my $type = 'dmidecode';
	my ($cmd) = $self->{$type} =~ /^([\/\.\_\-a-zA-Z0-9 >]+)$/;
	TRACE($cmd);

	my $fh;
	open($fh,'-|',$cmd) || croak "Unable to open file handle for command '$cmd': $!";
	while (local $_ = <$fh>) {
		$self->{raw}->{$type} .= $_;
	}
	close($fh) || carp "Unable to close file handle for command '$cmd': $!";

	return $self->parse($self->{raw}->{$type},$type);
}


sub parse {
	my $self = shift;
	unless (ref $self && UNIVERSAL::isa($self, __PACKAGE__)) {
		unshift @_, $self unless $self eq __PACKAGE__;
		$self = new __PACKAGE__;
	}

	my $type = $_[1] || 'dmidecode';
	$self->{parsed}->{$type} = $self->_parse($_[0],$type);

	DUMP('$self',$self);
	return $self->{parsed}->{$type}->{structures};
}



#
# Private methods
#

sub _parse {
	my ($self,$str,$type) = @_;
	my %data;
	my %strct;

	for (split(/\n/,$str)) {
		next if /^\s*$/;

		# dmidecode headers
		if (/^# dmidecode ([\d\.]+)\s*$/) {
			$data{dmidecode} = $1;
		} elsif (/^(\d+) structures occupying (\d+) bytes?\.\s*$/) {
			$data{structures} = $1;
			$data{bytes} = $2;
		} elsif (/^SMBIOS ([\d\.]+) present\.?\s*$/) {
			$data{smbios} = $1;
		} elsif (/^Table at ([0-9A-Fx]+)\.?\s*$/) {
			$data{location} = $1;

		# data
		} elsif (/^Handle ([0-9A-Fx]+)(?:, DMI type (\d+), (\d+) bytes?\.?)?\s*$/) {
			if (keys %strct) {
				_parse_raw(\%strct);
				$data{type}->{$strct{dmitype}} = {%strct};
				%strct = ();
			}
			$strct{handle} = $1;
			$strct{dmitype} = $2 if defined $2;
			$strct{bytes} = $3 if defined $3;
		} elsif (defined $strct{handle} &&
				/^\s*DMI type (\d+), (\d+) bytes?\.?\s*$/) {
			$strct{dmitype} = $1 if defined $1;
			$strct{bytes} = $2 if defined $2;
		} else {
			$strct{raw} = [] unless defined $strct{raw};
			push @{$strct{raw}}, $_;
		}
	}

	if (keys %strct) {
		_parse_raw(\%strct);
		$data{type}->{$strct{dmitype}} = {%strct};
	}

#	carp sprintf("Only parsed %d structures when %d were expected",
#			scalar(keys(%{$data{type}})), $data{structures})
#		if scalar(keys(%{$data{type}})) != $data{structures};

	return \%data;
}


sub _parse_raw {
	my $ref = shift;

	my $name_indent = 0;
	my $key_indent  = 0;
	my $name = '';
	my $key = '';

	my @errors;
	my %strct;

	for (my $l = 0; $l < @{$ref->{raw}}; $l++) {
		local $_ = $ref->{raw}->[$l];
		my ($indent) = $_ =~ /^(\s+)/;
		$indent = '' unless defined $indent;
		$indent = length($indent);

		$name_indent = $indent if $l == 0;
		if ($l == 1) {
			if ($indent > $name_indent) { $key_indent = $indent; }
			else { push @errors, "Parse error: key_indent ($indent) <= name_indent ($name_indent)"; }
		}

		# data
		if (/^\s{$name_indent}(\S+.*?)\s*$/) {
			$name = $1;
			$strct{$name} = {};
			$key = '';
		} elsif ($name && /^\s{$key_indent}(\S.*?)(?::|: (\S+.*?))?\s*$/) {
			$key = $1;
			$strct{$name}->{$key}->[0] = $2;
			$strct{$name}->{$key}->[1] = [] unless defined $strct{$name}->{$key}->[1];
		} elsif ($name && $key && $indent > $key_indent && /^\s*(\S+.*?)\s*$/) {
			push @{$strct{$name}->{$key}->[1]}, $1;

		# unknown
		} else { push @errors, "Parse error: $_"; }
	}

	delete $ref->{raw};
	$ref->{data} = \%strct;
	carp $_ for @errors;
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

=head2 parse

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


__DATA__

static const u8 opt_type_bios[]={ 0, 13, 255 };
static const u8 opt_type_system[]={ 1, 12, 15, 23, 32, 255 };
static const u8 opt_type_baseboard[]={ 2, 10, 255 };
static const u8 opt_type_chassis[]={ 3, 255 };
static const u8 opt_type_processor[]={ 4, 255 };
static const u8 opt_type_memory[]={ 5, 6, 16, 17, 255 };
static const u8 opt_type_cache[]={ 7, 255 };
static const u8 opt_type_connector[]={ 8, 255 };
static const u8 opt_type_slot[]={ 9, 255 };

static const struct type_keyword opt_type_keyword[]={
	{ "bios", opt_type_bios },
	{ "system", opt_type_system },
	{ "baseboard", opt_type_baseboard },
	{ "chassis", opt_type_chassis },
	{ "processor", opt_type_processor },
	{ "memory", opt_type_memory },
	{ "cache", opt_type_cache },
	{ "connector", opt_type_connector },
	{ "slot", opt_type_slot },
};

static const struct string_keyword opt_string_keyword[]={
	{ "bios-vendor", 0, 0x04, NULL, NULL },
	{ "bios-version", 0, 0x05, NULL, NULL },
	{ "bios-release-date", 0, 0x08, NULL, NULL },
	{ "system-manufacturer", 1, 0x04, NULL, NULL },
	{ "system-product-name", 1, 0x05, NULL, NULL },
	{ "system-version", 1, 0x06, NULL, NULL },
	{ "system-serial-number", 1, 0x07, NULL, NULL },
	{ "system-uuid", 1, 0x08, NULL, dmi_system_uuid },
	{ "baseboard-manufacturer", 2, 0x04, NULL, NULL },
	{ "baseboard-product-name", 2, 0x05, NULL, NULL },
	{ "baseboard-version", 2, 0x06, NULL, NULL },
	{ "baseboard-serial-number", 2, 0x07, NULL, NULL },
	{ "baseboard-asset-tag", 2, 0x08, NULL, NULL },
	{ "chassis-manufacturer", 3, 0x04, NULL, NULL },
	{ "chassis-type", 3, 0x05, dmi_chassis_type, NULL },
	{ "chassis-version", 3, 0x06, NULL, NULL },
	{ "chassis-serial-number", 3, 0x07, NULL, NULL },
	{ "chassis-asset-tag", 3, 0x08, NULL, NULL },
	{ "processor-family", 4, 0x06, dmi_processor_family, NULL },
	{ "processor-manufacturer", 4, 0x07, NULL, NULL },
	{ "processor-version", 4, 0x10, NULL, NULL },
	{ "processor-frequency", 4, 0x16, NULL, dmi_processor_frequency },
};

__END__



