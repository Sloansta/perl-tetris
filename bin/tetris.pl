#!/usr/bin/env perl 
use v5.36;
use FindBin qw($RealBin);
use lib "$RealBin/../lib";
use Tetris::Board;

my $board = Tetris::Board->new;
say 'Board is ', $board->width, 'x', $board->height;