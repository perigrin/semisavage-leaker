use 5.38.0;
use lib qw(lib);

use Benchmark qw(:all);
use Devel::Size 'total_size';

our $class;
BEGIN {
    if ($ENV{XS}) { eval "use local::lib 'xs';" }
    $class = 'OO::'.$ENV{OO_SYSTEM};
    eval "require $class";
}

sub benchmarks($class) {
    return {
        accessor => sub {
            my $obj = $class->new(
                r => 255,
                g => 255,
                b => 255,
            );
            my $r = $obj->r();
            my $g = $obj->g();
            my $b = $obj->b();
        },
        method => sub {
            my $obj = $class->new(
                r => 255,
                g => 255,
                b => 255,
            );
            my $rgb = $obj->as_css();
        },
        constructor => sub {
            my $obj = $class->new(
                r => 255,
                g => 255,
                b => 255,
            );
        },
    }
}

sub size_benchmark($class) {
    eval {
        my $obj = $class->new(
            r => 255,
            g => 255,
            b => 255,
        );

        my $size = total_size($obj);
        print "$class size: $size bytes\n";
    }
}

my $benchmarks = benchmarks($class);

timethese($ENV{N} // 10000000, $benchmarks);
size_benchmark($class);

__END__
