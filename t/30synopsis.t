# $Id: 30tie.t 567 2006-06-01 18:38:57Z nicolaw $

chdir('t') if -d 't';

use strict;
use Test::More tests => 12;
use lib qw(./lib ../lib);
use Parse::DMIDecode qw();

my $data;

my $dmi;
ok($dmi = new Parse::DMIDecode,'new');

ok($dmi->parse(slurp('dmidecode_example1.txt')),'parse dmidecode_example1.txt');
ok($dmi->keyword('bios-vendor') eq 'Dell Inc.','keyword bios-vendor');
ok($dmi->keyword('system-product-name') eq 'OptiPlex GX620','keyword system-product-name');

ok($dmi->parse(slurp('dmidecode_example2.txt')),'parse dmidecode_example2.txt');
ok($dmi->keyword('bios-version') eq 'ASUS A7N266-VM ACPI BIOS Rev 1005','keyword bios-version');
ok($dmi->keyword('processor-version') eq 'AMD Athlon(TM) XP Processor','keyword processor-version');

ok($dmi->parse(slurp('dmidecode_example3.txt')),'parse dmidecode_example3.txt');
ok($dmi->keyword('system-serial-number') eq 'L3M4102','keyword system-serial-number');
ok($dmi->keyword('system-manufacturer') eq 'LENOVO','keyword system-serial-manufacturer');

ok($dmi->parse(slurp('dmidecode_example4.txt')),'parse dmidecode_example4.txt');

ok($dmi->parse(slurp('dmidecode_example5.txt')),'parse dmidecode_example5.txt');

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

