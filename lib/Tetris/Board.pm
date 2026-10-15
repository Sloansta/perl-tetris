package Tetris::Board;
use v5.36;

sub new ($class, %args) {
    my $self = {
        width => $args{width} // 10, # 10
        height => $args{height} // 20, # 20
    };
    #grid of rows, 0 = empty cell
    my @grid; 
    for my $row (1 .. $self->{height}) {
        push @grid, [ (0) x $self->{width}];
    }
    $self->{cells} = \@grid;
    return bless $self, $class;
}

sub width ($self) { $self->{width} }
sub height ($self) { $self->{height} }

sub is_empty ($self, $x, $y) { !$self->{cells}[$y][$x]}

1;