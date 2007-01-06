package Math::GrahamFunction::SqFacts;

use strict;
use warnings;

use base qw(Math::GrahamFunction::Object);

use List::Util ();
__PACKAGE__->mk_accessors(qw(n factors));
             
sub _initialize
{
    my $self = shift;
    my $args = shift;

    if ($args->{n})
    {
        $self->n($args->{n});

        $self->calc_sq_factors();
    }
    elsif ($args->{factors})
    {
        $self->factors($args->{factors});
    }
    else
    {
        die "factors or n must be supplied.";
    }

    return 0;
}

sub clone
{
    my $self = shift;
    return __PACKAGE__->new({'factors' => [@{$self->factors()}]});
}

sub calc_sq_factors
{
    my $self = shift;

    $self->factors($self->get_sq_facts($self->n()));

    return 0;
}

my %gsf_cache = (1 => []);

sub get_sq_facts
{
    my $self = shift;
    my $n = shift;

    if (exists($gsf_cache{$n}))
    {
        return $gsf_cache{$n};
    }

    my $start_from = shift || 2;

    for(my $p=$start_from; ;$p++)
    {
        if ($n % $p == 0)
        {
            # This function is recursive to make better use of the Memoization
            # feature.
            my $division_factors = $self->get_sq_facts(($n / $p), $p);
            if (@$division_factors && ($division_factors->[0] == $p))
            {
                return ($gsf_cache{$n} = [ @{$division_factors}[1 .. $#$division_factors] ]);
            }
            else
            {
                return ($gsf_cache{$n} = [ $p, @$division_factors ]);
            }
        }
    }
}

# Removed because it is too slow - we now use our own custom memoization (
# or perhaps it is just called caching)
# memoize('get_squaring_factors', 'NORMALIZER' => sub { return $_[0]; });

# This function multiplies the squaring factors of $n and $m to receive
# the squaring factors of ($n*$m)

# OOP-Wise, it should be a multi-method, but since we don't inherit this
# object it's all-right.

sub mult_by
{
    my $n_ref = shift;
    my $m_ref = shift;

    my @n = @{$n_ref->factors()};
    my @m = 
    eval {
        @{$m_ref->factors()};
    };
    if ($@)
    {
        print "Hello\n";
    }

    my @ret = ();

    while (scalar(@n) && scalar(@m))
    {
        if ($n[0] == $m[0])
        {
            shift(@n);
            shift(@m);
        }
        elsif ($n[0] < $m[0])
        {
            push @ret, shift(@n);
        }
        else
        {
            push @ret, shift(@m);
        }
    }
    push @ret, @n, @m;

    $n_ref->factors(\@ret);

    # 0 for success
    return 0;
}

sub mult
{
    my $n = shift;
    my $m = shift;
    
    my $result = $n->clone();
    $result->mult_by($m);
    return $result;
}

sub is_square
{
    my $self = shift;
    return (scalar(@{$self->factors()}) == 0);
}

sub exists
{
    my ($self, $factor) = @_;
    
    return defined(List::Util::first { $_ == $factor } @{$self->factors()});
}

sub last
{
    my $self = shift;

    return $self->factors()->[-1];
}

use vars qw($a $b);

sub product
{
    my $self = shift;

    return (List::Util::reduce { $a * $b } @{$self->factors()});
}

sub first
{
    my $self = shift;

    return $self->factors()->[0];    
}



1;

