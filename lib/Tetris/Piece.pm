package Tetris::Piece;
use v5.40;
use Carp qw(croak);

use constant SHAPES => {
    I => [ '....',
           '####',
           '....',
           '....' ],
    O => [ '##',
           '##'],
    T => [ '.#.',
           '###',
           '...'],
    S => [ '.##',
           '##.',
           '...'],
    Z => [ '##.',
           '.##',
           '...'],
    J => [ '#..',
           '###',
           '...'],
    L => [ '..#',
           '###',
           '...'],
};

sub types ($class) {
    return sort keys %{ SHAPES() };
}

sub new ($class, %args) {
    my $type = $args{type} // croak 'Piece needs a type';
    my $rows = SHAPES->{$type} or croak "Unknown piece: $type";

    # Turn the drawing into a list of [x, y] coordinates
    my @cells;
    for my $y (0 .. $#$rows) {
        my @chars = split //, $rows->[$y];
        for my $x (0 .. $#chars) {
            push @cells, [$x, $y] if $chars[$x] eq '#';
        }
    }

    return bless {
        type => $type,
        size => scalar @$rows, 
        cells => \@cells,
    }, $class;
}

sub type ($self) { $self->{type} }
sub size ($self) { $self->{size} }
sub cells ($self) { $self->{cells}->@* }

#Clockwise turn inside an n x n box
sub rotate ($self) {
    my $n = $self->size;
    my @turned = map { [ $n - 1 - $_->[1], $_->[0] ] } $self->cells;
    return bless {%$self, cells => \@turned }, ref $self;
}
