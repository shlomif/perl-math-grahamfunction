#!/usr/bin/perl

use strict;
use warnings;

use Test::More tests => 100;

use Math::GrahamFunction;

my @results_array = (
    { n => 1,  factors => [1], },
    { n => 2,  factors => [ 2, 3, 6 ], },
    { n => 3,  factors => [ 3, 6, 8 ], },
    { n => 4,  factors => [4], },
    { n => 5,  factors => [ 5, 8, 10 ], },
    { n => 6,  factors => [ 6, 8, 12 ], },
    { n => 7,  factors => [ 7, 8, 14 ], },
    { n => 8,  factors => [ 8, 10, 12, 15 ], },
    { n => 9,  factors => [9], },
    { n => 10, factors => [ 10, 12, 15, 18 ], },
    { n => 11, factors => [ 11, 18, 22 ], },
    { n => 12, factors => [ 12, 15, 20 ], },
    { n => 13, factors => [ 13, 18, 26 ], },
    { n => 14, factors => [ 14, 15, 18, 20, 21 ], },
    { n => 15, factors => [ 15, 18, 20, 24 ], },
    { n => 16, factors => [16], },
    { n => 17, factors => [ 17, 18, 34 ], },
    { n => 18, factors => [ 18, 24, 27 ], },
    { n => 19, factors => [ 19, 32, 38 ], },
    { n => 20, factors => [ 20, 24, 30 ], },
    { n => 21, factors => [ 21, 27, 28 ], },
    { n => 22, factors => [ 22, 24, 33 ], },
    { n => 23, factors => [ 23, 32, 46 ], },
    { n => 24, factors => [ 24, 27, 32 ], },
    { n => 25, factors => [25], },
    { n => 26, factors => [ 26, 27, 32, 39 ], },
    { n => 27, factors => [ 27, 28, 30, 32, 35 ], },
    { n => 28, factors => [ 28, 32, 35, 40 ], },
    { n => 29, factors => [ 29, 32, 58 ], },
    { n => 30, factors => [ 30, 35, 42 ], },
    { n => 31, factors => [ 31, 32, 62 ], },
    { n => 32, factors => [ 32, 40, 45 ], },
    { n => 33, factors => [ 33, 35, 40, 42, 44 ], },
    { n => 34, factors => [ 34, 35, 42, 45, 51 ], },
    { n => 35, factors => [ 35, 40, 42, 48 ], },
    { n => 36, factors => [36], },
    { n => 37, factors => [ 37, 50, 74 ], },
    { n => 38, factors => [ 38, 54, 57 ], },
    { n => 39, factors => [ 39, 48, 52 ], },
    { n => 40, factors => [ 40, 45, 50 ], },
    { n => 41, factors => [ 41, 50, 82 ], },
    { n => 42, factors => [ 42, 48, 56 ], },
    { n => 43, factors => [ 43, 50, 86 ], },
    { n => 44, factors => [ 44, 45, 55 ], },
    { n => 45, factors => [ 45, 48, 60 ], },
    { n => 46, factors => [ 46, 54, 69 ], },
    { n => 47, factors => [ 47, 50, 94 ], },
    { n => 48, factors => [ 48, 50, 54 ], },
    { n => 49, factors => [49], },
    { n => 50, factors => [ 50, 56, 63 ], },
    { n => 51, factors => [ 51, 54, 56, 63, 68 ], },
    { n => 52, factors => [ 52, 54, 56, 60, 63, 65 ], },
    { n => 53, factors => [ 53, 72, 106 ], },
    { n => 54, factors => [ 54, 60, 63, 70 ], },
    { n => 55, factors => [ 55, 56, 60, 63, 66 ], },
    { n => 56, factors => [ 56, 63, 72 ], },
    { n => 57, factors => [ 57, 75, 76 ], },
    { n => 58, factors => [ 58, 60, 63, 70, 87 ], },
    { n => 59, factors => [ 59, 72, 118 ], },
    { n => 60, factors => [ 60, 63, 70, 72, 75 ], },
    { n => 61, factors => [ 61, 72, 122 ], },
    { n => 62, factors => [ 62, 72, 75, 93 ], },
    { n => 63, factors => [ 63, 66, 72, 75, 77 ], },
    { n => 64, factors => [64], },
    { n => 65, factors => [ 65, 66, 70, 72, 77, 78 ], },
    { n => 66, factors => [ 66, 70, 75, 77, 80 ], },
    { n => 67, factors => [ 67, 72, 134 ], },
    { n => 68, factors => [ 68, 80, 85 ], },
    { n => 69, factors => [ 69, 75, 92 ], },
    { n => 70, factors => [ 70, 72, 75, 80, 84 ], },
    { n => 71, factors => [ 71, 72, 142 ], },
    { n => 72, factors => [ 72, 75, 77, 84, 88 ], },
    { n => 73, factors => [ 73, 98, 146 ], },
    { n => 74, factors => [ 74, 96, 111 ], },
    { n => 75, factors => [ 75, 77, 80, 84, 88, 90 ], },
    { n => 76, factors => [ 76, 80, 95 ], },
    { n => 77, factors => [ 77, 84, 88, 96 ], },
    { n => 78, factors => [ 78, 80, 84, 90, 91 ], },
    { n => 79, factors => [ 79, 98, 158 ], },
    { n => 80, factors => [ 80, 90, 98 ], },
    { n => 81, factors => [81], },
    { n => 82, factors => [ 82, 96, 123 ], },
    { n => 83, factors => [ 83, 98, 166 ], },
    { n => 84, factors => [ 84, 91, 96, 104 ], },
    { n => 85, factors => [ 85, 90, 96, 98, 102 ], },
    { n => 86, factors => [ 86, 96,  129 ], },
    { n => 87, factors => [ 87, 108, 116 ], },
    { n => 88, factors => [ 88, 98,  99 ], },
    { n => 89, factors => [ 89, 98,  178 ], },
    { n => 90, factors => [ 90, 91,  96, 98, 104, 105 ], },
    { n => 91, factors => [ 91, 96,  98, 99, 104, 105, 110 ], },
    { n => 92, factors => [ 92, 98,  99, 110, 115 ], },
    { n => 93, factors => [ 93, 108, 124 ], },
    { n => 94, factors => [ 94, 96,  141 ], },
    { n => 95, factors => [ 95, 96, 98,  99,  110, 114 ], },
    { n => 96, factors => [ 96, 98, 108 ], },
    { n => 97, factors => [ 97, 98, 194 ], },
    { n => 98, factors => [ 98, 99, 105, 108, 110, 112 ], },
    { n => 99,  factors => [ 99, 104, 105, 108, 110, 112, 117 ], },
    { n => 100, factors => [100], },
);

# TEST:$num_results=100
# TEST*$num_results
foreach my $test_me (@results_array)
{
    my $n       = $test_me->{'n'};
    my $solver  = Math::GrahamFunction->new( { 'n' => $n, } );
    my $factors = $solver->solve()->{'factors'};
    is_deeply( $factors, $test_me->{'factors'},
        "Testing the Graham Function Factors of $n" );
}

