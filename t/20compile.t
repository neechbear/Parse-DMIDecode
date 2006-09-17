# $Id$

chdir('t') if -d 't';
use lib qw(./lib ../lib);
use Test::More tests => 2;

use_ok('Parse::DMIDecode');
require_ok('Parse::DMIDecode');

1;

