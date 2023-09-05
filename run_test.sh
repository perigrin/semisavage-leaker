#!/bin/bash -x
OO_SYSTEM=Moose time perl ./test.pl
OO_SYSTEM=Moo   time perl ./test.pl
OO_SYSTEM=Cor   time perl ./test.pl
OO_SYSTEM=Bless time perl ./test.pl

# xs extensions
XS=1 OO_SYSTEM=MooseXS time perl ./test.pl
XS=1 OO_SYSTEM=Moo     time perl ./test.pl
