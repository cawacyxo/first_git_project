#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: game.pl
#
#        USAGE: ./game.pl  
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
#      CREATED: 12/22/2016 08:50:03 AM
#     REVISION: ---
#===============================================================================


=pod
Constants fo use
=cut

use constant EMPTY   => '-';
use constant WHITE   => 'w';
use constant BLACK   => 'b';
use constant SIZE    => 10;
use constant WIN_CNT => 3;

my @game_field;
my $player = "";

=pod
Filling game field with default value
=cut

sub fill_me {
    for ( my $i = 0; $i < SIZE; $i++ ) {
        for ( my $j = 0; $j < SIZE; $j++ ) {
            $game_field[$i][$j] = EMPTY;
        }
    }
}

# Display game's field
sub display {
    system("clear");
    print "\n\n\n\n\t BE READY TO PLAY !!! \n\n";
    for ( my $i = SIZE-1; $i >= 0; $i-- ) {
        printf "\t%d  ", $i;
        for ( my $j = 0; $j < SIZE; $j++ ) {
            print "$game_field[$j][$i] ";
        }
        print "\n";
    }
    print "\n\t   ";
    my @tmp_arr = ('a'..'z');
    for ( my $i = 0; $i < SIZE; $i++ ) {
        print "$tmp_arr[$i] ";
    }
    print "\n";    
}    


=pod
Fuction sets value in cell by coordinates
=cut
sub set_cell_value {
    my ($input, $color) = @_;
    my $x = index ("abcdefghij",((split(//, $input))[0]));
    my $y = (split(//, $input))[1];
    $game_field[$x][$y] = $color;
}


=pod
Function returns value of cell
=cut
sub get_cell_value {
    my $input = shift;
    my $x = index ("abcdefghij",((split(//, $input))[0]));
    my $y = (split(//, $input))[1];
    return $game_field[$x][$y];
}


sub user_interact {
    my ($curr_player, $mess) = @_;
    my $move = "";
    while ( $move eq "" ) {
        print "\n\t$mess, please enter your move: ";
        chomp( $move = <STDIN> );
        if ( length($move) != 2 ) {
            print "\n\tInput should be 2-bit long and should contain letter a-j and digit 0-9\n";
            $move = "";
            redo;
        }
        my $test_str = substr("abcdefghij", 0, SIZE); 
        my $check = (split(//, $move))[0];
        if ( index($test_str, $check) < 0 ) {
            print "\n\tInput should contain letter \"$test_str\" only on first  position\n";
            $move = "";
            redo;
        }
        $test_str = substr("0123456789", 0, SIZE); 
        $check = (split(//, $move))[1];
        if ( index($test_str, $check) < 0 ) {
            print "\n\tInput should contain digit \"$test_str\" only on second  position\n";
            $move = "";
            redo;
        }
    }
    return $move;
}


sub h_counts {
    my $curr_player = shift;
    my $count = 0;
    for ( my $y = 0; $y < SIZE; $y++ ) {
        for ( my $x = 0; $x < SIZE; $x++ ) {
            unless ( $count ) {
                $count++ if ( $game_field[$x][$y] eq $curr_player );
            } else {
                if ( $game_field[$x][$y] eq $curr_player ) {
                    $count++;
                    return $count if ( $count == WIN_CNT );
                } else { $count = 0 }
            }
        }
    }
    return $count;
}


sub v_counts {
    my $curr_player = shift;
    my $count = 0;
    for ( my $x = 0; $x < SIZE; $x++ ) {
        for ( my $y = 0; $y < SIZE; $y++ ) {
            unless ( $count ) {
                $count++ if ( $game_field[$x][$y] eq $curr_player );
            } else {
                if ( $game_field[$x][$y] eq $curr_player ) {
                    $count++;
                    return $count if ( $count == WIN_CNT );
                } else { $count = 0 }
            }
        }
    }
    return $count;
}


sub r_counts {
    my $curr_player = shift;
    my $count = 0;
    for ( my $p = 0; $p < SIZE; $p++ ) {
        for ( my $x = $p; $x < SIZE; $x++ ) {
            for ( my $y = 0; $y < SIZE; $y++ ) {
                if ( ($x - $p ) == $y ) {
                    unless ( $count ) {
                        $count++ if ( $game_field[$x][$y] eq $curr_player );
                    } else {
                        if ( $game_field[$x][$y] eq $curr_player ) {
                            $count++;
                            return $count if ( $count == WIN_CNT );
                        } else { $count = 0 }
                    }
                }    
            }
        }    
        for ( my $x = 0; $x < SIZE; $x++ ) {
            for ( my $y = $p; $y < SIZE; $y++ ) {
                if ( ($y - $p ) == $x ) {
                    unless ( $count ) {
                        $count++ if ( $game_field[$x][$y] eq $curr_player );
                    } else {
                        if ( $game_field[$x][$y] eq $curr_player ) {
                            $count++;
                            return $count if ( $count == WIN_CNT );
                        } else { $count = 0 }
                    }
                }    
            }
        }
    }
    return $count;
}


sub l_counts {
    my $curr_player = shift;
    my $count = 0;
    for ( my $p = SIZE-1; $p >= 0; $p-- ) {
        for ( my $x = SIZE-1; $x >= 0; $x-- ) {
            for ( my $y = 0; $y < SIZE; $y++ ) {
                if ( ($x + $y ) == $p ) {
                    unless ( $count ) {
                        $count++ if ( $game_field[$x][$y] eq $curr_player );
                    } else {
                        if ( $game_field[$x][$y] eq $curr_player ) {
                            $count++;
                            return $count if ( $count == WIN_CNT );
                        } else { $count = 0 }
                    }
                }    
            }
        }    
    }
    for ( my $p = 0; $p < SIZE; $p++ ) {
        for ( my $x = SIZE-1; $x >= 0; $x-- ) {
            for ( my $y = $p+1; $y < SIZE; $y++ ) {
                if ( ($x + $y ) == ($p+1) ) {
                    unless ( $count ) {
                        $count++ if ( $game_field[$x][$y] eq $curr_player );
                    } else {
                        if ( $game_field[$x][$y] eq $curr_player ) {
                            $count++;
                            return $count if ( $count == WIN_CNT );
                        } else { $count = 0 }
                    }
                }    
            }
        }    
    }

    return $count;
}    
#
#
#   MAIN
#
#

fill_me();
display();
my $player_name;
while ( $player eq "" ) {
    print "\n\tPlease choose player's color to start first \"(w)hite/(b)lack\": ";
    my $inp = <STDIN>;
    chomp($inp);
    if ( $inp eq WHITE ) {
        $player = WHITE;
        $player_name = "\"Whites\"";
    } elsif ( $inp eq BLACK ) {
        $player = BLACK;
        $player_name = "\"Blacks\"";
    } else {
        $player = "";
        print "\n\tWrong input received. Only w or b accepted\n";
        redo;
    }
}
my $count = SIZE * SIZE;
while ( $count ) {
    my $curr_move = user_interact ( $player, $player_name);
    if ( get_cell_value ( $curr_move ) ne EMPTY ) {
        print "\n\tCell $curr_move is occupied. Please choose another!\n";
        redo;
    }
    set_cell_value ( $curr_move, $player);
    display();
    print "\n\n\t$player_name!!! Congratulations. You win!!!\n\n" and exit 0 if ( h_counts ($player) || v_counts($player) || r_counts($player) || l_counts($player));
    if ( $player eq WHITE ) {
        $player = BLACK;
        $player_name = "\"Blacks\"";
    } else {
        $player = WHITE;
        $player_name = "\"Whites\"";
    }
    $count--;
}

