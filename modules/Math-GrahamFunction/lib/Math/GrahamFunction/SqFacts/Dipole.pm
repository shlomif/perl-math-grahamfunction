package Math::GrahamFunction::SqFacts::Dipole;

use strict;
use warnings;

=head1 NAME

Math::GrahamFunction::SqFacts::Dipole - a dipole of two vectors - a result and
a composition.

=cut

use base qw(Math::GrahamFunction::SqFacts);

use List::Util ();
__PACKAGE__->mk_accessors(qw(result compose));
             
sub _initialize
{
    my $self = shift;
    my $args = shift;

    $self->result($args->{result});
    $self->compose($args->{compose});

    return 0;
}

sub clone
{
    my $self = shift;
    return __PACKAGE__->new(
        {
            'result' => $self->result()->clone(),
            'compose' => $self->compose()->clone(),
        });
}

sub mult_by
{
    my $n_ref = shift;
    my $m_ref = shift;

    $n_ref->result()->mult_by($m_ref->result());
    $n_ref->compose()->mult_by($m_ref->compose());

    return 0;
}

sub is_square
{
    my $self = shift;
    return $self->result()->is_square();
}

sub exists
{
    my ($self, $factor) = @_;

    return $self->result()->exists($factor);
}

sub first
{
    my $self = shift;

    return $self->result()->first();
}

sub factors
{
    my $self = shift;

    return $self->result->factors();
}

sub _get_ret
{
    my $self = shift;

    return [ @{$self->compose->factors()} ];
}

1;

