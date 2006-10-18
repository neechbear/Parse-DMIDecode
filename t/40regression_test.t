# $Id: 30tie.t 567 2006-06-01 18:38:57Z nicolaw $

chdir('t') if -d 't';

use strict;
use Test::More;
use lib qw(./lib ../lib);
use Parse::DMIDecode qw();

my @files = glob('testdata/*');
plan tests => (scalar(@files)*13) + 1;

my $dmi;
ok($dmi = new Parse::DMIDecode,'new');

for my $file (@files) {
	ok($dmi->parse(slurp($file)),$file);
	for my $dmitype (qw(0 1 2 3)) {
		my @handles;
		ok(
			@handles = $dmi->get_handles( dmitype => $dmitype ),
			"\$dmi->get_handles( dmitype => $dmitype )"
		);
		ok($handles[0]->dmitype == $dmitype,'$handle->dmitype');
		ok($handles[0]->bytes =~ /^\d+$/,'$handle->bytes');
	}
}

sub slurp {
	my $file = shift;
	my $data = '';
	if (open(FH,'<',$file)) {
		local $/ = undef;
		$data = <FH>;
		close(FH);
	}
	return $data;
}

1;

