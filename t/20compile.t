# $Id$

chdir('t') if -d 't';
use lib qw(./lib ../lib);
use Test::More tests => 2;

use_ok('Linux::SMBIOS');
require_ok('Linux::SMBIOS');

1;

