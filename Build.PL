# vim:ts=4:sw=4:tw=78
# $Id$

use strict;
use Module::Build;
use vars qw($build);

my $module = 'Parse::DMIDecode';
$build = Module::Build->new(
		module_name        => $module,
		license            => 'open_source',
		create_makefile_pl => 'passthrough',
		create_readme      => 1,
		create_packlist    => 1,
		sign               => 0,

		requires => {
			'Carp'         => 0, # 1.04
			#'Scalar::Util' => 0,
			#'Storable'     => 0,
		},

		build_requires => {
			'Test'         => 0, # 1.25
			'Test::More'   => 0, # 0.60
		},

		recommends => {
			'File::Which'         => 0.05, # 0.05
			'Test::Pod'           => 1.20,
			'Test::Pod::Coverage' => 1.06,
			'Test::Deep'          => 0.093,
		},
	);

$build->create_build_script;

