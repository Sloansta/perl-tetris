use v5.36; 
use Test::More;
use Tetris::Board;

my $board = Tetris::Board->new;
is $board->width, 10, 'default width';
is $board->height, 20, 'default height';
ok $board->is_empty(0, 0), 'new board starts empty';

done_testing;