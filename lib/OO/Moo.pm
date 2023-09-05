use 5.38.0;

package OO::Moo;
use Moo;

has 'r' => (is => 'ro');
has 'g' => (is => 'ro');
has 'b' => (is => 'ro');

sub as_css($s) { sprintf "rgb(%f%%,%f%%,%f%%)", $s->r, $s->g, $s->b; }

