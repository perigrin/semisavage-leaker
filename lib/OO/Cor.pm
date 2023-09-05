use 5.38.0;

use experimental 'class';

class OO::Cor {
    field $r :param;
    field $g :param;
    field $b :param;

    method r() { $r }
    method g() { $g }
    method b() { $b }

    method as_css() { sprintf "rgb(%f%%,%f%%,%f%%)", $r, $g, $b; }
}
