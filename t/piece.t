use v5.40;
use Test::More;
use Tetris::Piece;

# cells come back in any order, so sort them by row, then column
sub sorted (@cells) { [ sort { $a->[1] <=> $b->[1] || $a->[0] <=> $b->[0] } @cells ] }

is_deeply [ Tetris::Piece->types ], [qw(I J L O S T Z)], 'seven piece types';

my $t = Tetris::Piece->new(type => 'T');
is $t->type, 'T', 'type';
is $t->size, 3, 'T fits a 3x3 box';
is_deeply sorted($t->cells), [[1,0],[0,1],[1,1],[2,1]], 'T cells';

my $r = $t->rotate;
is_deeply sorted($r->cells), [[1,0],[1,1],[2,1],[1,2]], 'T rotated clockwise';
is_deeply sorted($t->cells), [[1,0],[0,1],[1,1],[2,1]], 'original piece unchanged';

my $spun = $t;
$spun = $spun->rotate for 1 .. 4;
is_deeply sorted($spun->cells), sorted($t->cells), 'four turns is a full circle';

my $o = Tetris::Piece->new(type => 'O');
is_deeply sorted($o->rotate->cells), sorted($o->cells), 'O looks the same rotated';
is(Tetris::Piece->new(type => 'I')->size, 4, 'I fits a 4x4 box');

ok !eval { Tetris::Piece->new(type => 'X'); 1 }, 'unknown type dies';
like $@, qr/Unknown piece/, 'with a useful message';

done_testing;