use 5.38.0;

package OO::MooseXS;
use Moose;
use MooseX::XSAccessor;

has 'r' => (is => 'ro');
has 'g' => (is => 'ro');
has 'b' => (is => 'ro');

sub as_css($s) { sprintf "rgb(%f%%,%f%%,%f%%)", $s->r, $s->b, $s->g; }

__PACKAGE__->meta->make_immutable();

