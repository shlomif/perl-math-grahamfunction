use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Math::GrahamFunction',
    license             => 'bsd',
    dist_author         => 'Shlomi Fish <shlomif@cpan.org>',
    dist_version_from   => 'lib/Math/GrahamFunction.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'Class::Accessor' => 0,
        'List::Util' => 0,
    },
    add_to_cleanup      => [ 'Math::GrahamFunction-*' ],
);

$builder->create_build_script();
