# Perl Object Benchmarks

This is is an amalgam of [jnap's benchmarks][1] and
[kobaken's benchmarks][2] with a new benchmark of more complex methods
and changes to ensure _only_ the object system we care about is loaded
into the benchmark process.

[1]: https://dev.to/jjn1056/benchmarking-core-class-573c
[2]: https://dev.to/kfly8/benchmarked-new-perl-class-feature-with-many-class-builders-17n

## SYNOPSIS

```
    ./install.sh
    carton exec ./run_tests.sh
```

## RESULTS

| System                      | Accessors              | Constructor Only       | "Complex" Method       | Memory Size    |
|-----------------------------|------------------------|------------------------|------------------------|----------------|
| Moose                       | 15s @ 718907.26/s  43% | 11s @ 955109.84/s  30% | 21s @ 471031.56/s  52% | 369 bytes 100% |
| Moose + XSAccessors         | 11s @ 856898.03/s  51% | 9s @ 984251.97/s   31% | 18s @ 535331.91/s  59% | 369 bytes 100% |
| Moo                         | 11s @ 944287.06/s  56% | 7s @ 1410437.24/s  44% | 18s @ 565291.12/s  62% | 369 bytes 100% |
| Moo + XSAccessors           | 10s @ 1145475.37/s 68% | 8s @ 1408450.70/s  44% | 17s @ 637348.63/s  70% | 369 bytes 100% |
| `use experimental 'class';` | 8s @ 1184834.12/s  70% | 6s @ 1972386.59/s  60% | 14s @ 778816.20/s  86% | 107 bytes  29% |
| `bless {@_}, shift;`        | 7s @ 1689189.19/s 100% | 7s @ 3174603.17/s 100% | 12s @ 904159.13/s 100% | 369 bytes 100% |

## RAW RESULTS

```
+ OO_SYSTEM=Moose
+ time perl ./test.pl
Benchmark: timing 10000000 iterations of accessor, constructor, method...
  accessor: 15 wallclock secs (13.85 usr +  0.06 sys = 13.91 CPU) @ 718907.26/s (n=10000000)
constructor: 11 wallclock secs (10.44 usr +  0.03 sys = 10.47 CPU) @ 955109.84/s (n=10000000)
    method: 21 wallclock secs (21.15 usr +  0.08 sys = 21.23 CPU) @ 471031.56/s (n=10000000)
OO::Moose size: 369 bytes
       49.04 real        48.50 user         0.19 sys
+ OO_SYSTEM=Moo
+ time perl ./test.pl
Benchmark: timing 10000000 iterations of accessor, constructor, method...
  accessor: 11 wallclock secs (10.52 usr +  0.07 sys = 10.59 CPU) @ 944287.06/s (n=10000000)
constructor:  7 wallclock secs ( 7.06 usr +  0.03 sys =  7.09 CPU) @ 1410437.24/s (n=10000000)
    method: 18 wallclock secs (17.68 usr +  0.01 sys = 17.69 CPU) @ 565291.12/s (n=10000000)
OO::Moo size: 369 bytes
       38.62 real        38.29 user         0.13 sys
+ OO_SYSTEM=Cor
+ time perl ./test.pl
Benchmark: timing 10000000 iterations of accessor, constructor, method...
  accessor:  8 wallclock secs ( 8.43 usr +  0.01 sys =  8.44 CPU) @ 1184834.12/s (n=10000000)
constructor:  6 wallclock secs ( 5.08 usr + -0.01 sys =  5.07 CPU) @ 1972386.59/s (n=10000000)
    method: 14 wallclock secs (12.83 usr +  0.01 sys = 12.84 CPU) @ 778816.20/s (n=10000000)
OO::Cor size: 107 bytes
       29.43 real        29.36 user         0.05 sys
+ OO_SYSTEM=Bless
+ time perl ./test.pl
Benchmark: timing 10000000 iterations of accessor, constructor, method...
  accessor:  7 wallclock secs ( 5.91 usr +  0.01 sys =  5.92 CPU) @ 1689189.19/s (n=10000000)
constructor:  4 wallclock secs ( 3.14 usr +  0.01 sys =  3.15 CPU) @ 3174603.17/s (n=10000000)
    method: 12 wallclock secs (11.01 usr +  0.05 sys = 11.06 CPU) @ 904159.13/s (n=10000000)
OO::Bless size: 369 bytes
       23.27 real        23.08 user         0.07 sys
+ XS=1
+ OO_SYSTEM=MooseXS
+ time perl ./test.pl
Benchmark: timing 10000000 iterations of accessor, constructor, method...
  accessor: 11 wallclock secs (11.65 usr +  0.02 sys = 11.67 CPU) @ 856898.03/s (n=10000000)
constructor:  9 wallclock secs (10.14 usr +  0.02 sys = 10.16 CPU) @ 984251.97/s (n=10000000)
    method: 18 wallclock secs (18.65 usr +  0.03 sys = 18.68 CPU) @ 535331.91/s (n=10000000)
OO::MooseXS size: 369 bytes
       43.64 real        43.50 user         0.09 sys
+ XS=1
+ OO_SYSTEM=Moo
+ time perl ./test.pl
Benchmark: timing 10000000 iterations of accessor, constructor, method...
  accessor: 10 wallclock secs ( 8.72 usr +  0.01 sys =  8.73 CPU) @ 1145475.37/s (n=10000000)
constructor:  8 wallclock secs ( 7.10 usr + -0.00 sys =  7.10 CPU) @ 1408450.70/s (n=10000000)
    method: 17 wallclock secs (15.66 usr +  0.03 sys = 15.69 CPU) @ 637348.63/s (n=10000000)
OO::Moo size: 369 bytes
       34.57 real        34.50 user         0.06 sys
```

### SYSTEM INFORMATION

The build of perl that generated the above results:

```
Summary of my perl5 (revision 5 version 38 subversion 0) configuration:

  Platform:
    osname=darwin
    osvers=22.5.0
    archname=darwin-2level
    uname='darwin 1-business-laptop.local 22.5.0 darwin kernel version 22.5.0: mon apr 24 20:53:44 pdt 2023; root:xnu-8796.121.2~5release_arm64_t8103 arm64 '
    config_args='-Dprefix=/Users/perigrin/.plenv/versions/5.38.0 -de -Dversiononly -A'eval:scriptdir=/Users/perigrin/.plenv/versions/5.38.0/bin''
    hint=recommended
    useposix=true
    d_sigaction=define
    useithreads=undef
    usemultiplicity=undef
    use64bitint=define
    use64bitall=define
    uselongdouble=undef
    usemymalloc=n
    default_inc_excludes_dot=define
  Compiler:
    cc='cc'
    ccflags ='-fno-common -DPERL_DARWIN -mmacosx-version-min=13.4 -DNO_POSIX_2008_LOCALE -fno-strict-aliasing -pipe -fstack-protector-strong'
    optimize='-O3'
    cppflags='-fno-common -DPERL_DARWIN -mmacosx-version-min=13.4 -DNO_POSIX_2008_LOCALE -fno-strict-aliasing -pipe -fstack-protector-strong'
    ccversion=''
    gccversion='Apple LLVM 14.0.3 (clang-1403.0.22.14.1)'
    gccosandvers=''
    intsize=4
    longsize=8
    ptrsize=8
    doublesize=8
    byteorder=12345678
    doublekind=3
    d_longlong=define
    longlongsize=8
    d_longdbl=define
    longdblsize=8
    longdblkind=0
    ivtype='long'
    ivsize=8
    nvtype='double'
    nvsize=8
    Off_t='off_t'
    lseeksize=8
    alignbytes=8
    prototype=define
  Linker and Libraries:
    ld='cc'
    ldflags =' -mmacosx-version-min=13.4 -fstack-protector-strong -L/usr/local/lib'
    libpth=/Library/Developer/CommandLineTools/usr/lib/clang/14.0.3/lib /Library/Developer/CommandLineTools/SDKs/MacOSX13.3.sdk/usr/lib /Library/Developer/CommandLineTools/usr/lib /usr/local/lib /usr/lib
    libs=
    perllibs=
    libc=
    so=dylib
    useshrplib=false
    libperl=libperl.a
    gnulibc_version=''
  Dynamic Linking:
    dlsrc=dl_dlopen.xs
    dlext=bundle
    d_dlsymun=undef
    ccdlflags=' '
    cccdlflags=' '
    lddlflags=' -mmacosx-version-min=13.4 -bundle -undefined dynamic_lookup -L/usr/local/lib -fstack-protector-strong'


Characteristics of this binary (from libperl):
  Compile-time options:
    HAS_LONG_DOUBLE
    HAS_STRTOLD
    HAS_TIMES
    PERLIO_LAYERS
    PERL_COPY_ON_WRITE
    PERL_DONT_CREATE_GVSV
    PERL_HASH_FUNC_SIPHASH13
    PERL_HASH_USE_SBOX32
    PERL_MALLOC_WRAP
    PERL_OP_PARENT
    PERL_PRESERVE_IVUV
    PERL_USE_SAFE_PUTENV
    USE_64_BIT_ALL
    USE_64_BIT_INT
    USE_LARGE_FILES
    USE_LOCALE
    USE_LOCALE_COLLATE
    USE_LOCALE_CTYPE
    USE_LOCALE_NUMERIC
    USE_LOCALE_TIME
    USE_PERLIO
    USE_PERL_ATOF
  Built under darwin
  Compiled at Jul  2 2023 21:52:42
  @INC:
    /Users/perigrin/.plenv/versions/5.38.0/lib/perl5/site_perl/5.38.0/darwin-2level
    /Users/perigrin/.plenv/versions/5.38.0/lib/perl5/site_perl/5.38.0
    /Users/perigrin/.plenv/versions/5.38.0/lib/perl5/5.38.0/darwin-2level
    /Users/perigrin/.plenv/versions/5.38.0/lib/perl5/5.38.0
```
