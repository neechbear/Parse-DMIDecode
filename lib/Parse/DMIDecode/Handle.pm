############################################################
#
#   $Id$
#   Parse::DMIDecode::Handle - Handle object
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

package Parse::DMIDecode::Handle;
# vim:ts=4:sw=4:tw=78

use strict;
use Parse::DMIDecode::Constants qw(@TYPES %GROUPS);
use Carp qw(croak cluck confess carp);
use vars qw($VERSION $DEBUG);

$VERSION = '0.00' || sprintf('%d', q$Revision$ =~ /(\d+)/g);
$DEBUG ||= $ENV{DEBUG} ? 1 : 0;


#
# Methods
#

sub new {
	ref(my $class = shift) && croak 'Class name required';
	my $self = {};

	if (@_ && defined $_[0]) {
		for (split(/\n/,$_[0])) {
			if (/^Handle ([0-9A-Fx]+)(?:, DMI type (\d+), (\d+) bytes?\.?)?\s*$/) {
				$self->{handle} = $1;
				$self->{dmitype} = $2 if defined $2;
				$self->{bytes} = $3 if defined $3;
			} elsif (defined $self->{handle} &&
					/^\s*DMI type (\d+), (\d+) bytes?\.?\s*$/) {
				$self->{dmitype} = $1 if defined $1;
				$self->{bytes} = $2 if defined $2;
			} else {
				$self->{raw} = [] unless defined $self->{raw};
				push @{$self->{raw}}, $_;
			}
		}
		_parse($self);
		$self->{raw} = $_[0];
	}

	bless($self,$class);
	DUMP($class,$self);
	return $self;
}


sub _parse {
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
			else { push @errors, "Parser warning: key_indent ($indent) <= name_indent ($name_indent): $_"; }
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
		} else { push @errors, "Parser warning: $_"; }
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

Parse::DMIDecode::Handle - 

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 METHODS

=head2 new

=head1 SEE ALSO

L<Parse::DMIDecode>

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




