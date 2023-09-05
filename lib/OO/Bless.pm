use 5.38.0;

package OO::Bless;

sub new {
    my $class = shift;
    return bless {@_}, $class
}

sub r { return shift->{r} }
sub g { return shift->{g} }
sub b { return shift->{b} }

sub as_css($s) { sprintf "rgb(%f%%,%f%%,%f%%)", $s->@{qw(r g b)} }
