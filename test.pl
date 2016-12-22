#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: test.pl
#
#        USAGE: ./test.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 11/29/2016 08:08:30 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

use Data::Dumper qw(Dumper);

my($root, $n);

# first generate 20 random inserts
while ($n++ < 10) { insert($root, int(rand(1000)))}
print Dumper $root;

sub insert {
    my($tree, $value) = @_;
    unless ($tree) {
        $tree = {};                         # allocate new node
        $tree->{VALUE}  = $value;
        $tree->{LEFT}   = undef;
        $tree->{RIGHT}  = undef;
        $_[0] = $tree;              # $_[0] is reference param!
        return;
    }
    if    ($tree->{VALUE} > $value) { insert($tree->{LEFT},  $value) }
    elsif ($tree->{VALUE} < $value) { insert($tree->{RIGHT}, $value) }
    else                            { warn "dup insert of $value\n"  }
                                    # XXX: no dups


}
