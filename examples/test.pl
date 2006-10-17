#!/usr/bin/perl -w

BEGIN { chdir '../' if -d '../examples/'; }

use strict;
use lib qw(./lib);
use Parse::DMIDecode;
use Parse::DMIDecode::Constants qw(@TYPES);

my $decoder = new Parse::DMIDecode;
$decoder->probe;
#$decoder->parse(`cat t/dmidecode_example4.txt`);

for my $handle ($decoder->get_handles( group => 'memory' )) {
	printf(">> Found handle at %s (%s):\n%s\n",
			$handle->address,
			$TYPES[$handle->dmitype],
			$handle->raw
		);
}




