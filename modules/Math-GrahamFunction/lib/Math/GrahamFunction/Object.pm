package Math::GrahamFunction::Object;

use strict;
use warnings;

use base qw(Class::Accessor);

sub new
{
    my $class = shift;
    my $self = {};
    bless $self, $class;
    $self->_initialize(@_);
    return $self;
}

1;

