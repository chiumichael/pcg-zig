#!/bin/sh
# 
# PCG Random Number Generation for C.
# 
# Copyright 2014-2017 Melissa O'Neill <oneill@pcg-random.org>,
#                     and the PCG Project contributors.
#
# SPDX-License-Identifier: (Apache-2.0 OR MIT)
#
# Licensed under the Apache License, Version 2.0 (provided in
# LICENSE-APACHE.txt and at http://www.apache.org/licenses/LICENSE-2.0)
# or under the MIT license (provided in LICENSE-MIT.txt and at
# http://opensource.org/licenses/MIT), at your option. This file may not
# be copied, modified, or distributed except according to those terms.
#
# Distributed on an "AS IS" BASIS, WITHOUT WARRANTY OF ANY KIND, either
# express or implied.  See your chosen license for details.
#
# For additional information about the PCG random number generation scheme,
# visit http://www.pcg-random.org/.
#

echo Performing a quick sanity check...

mkdir -p zig-out/bin/actual
rm -f zig-out/bin/actual/*

# Setseq

./zig-out/bin/check-setseq-8-rxs-m-xs-8 > zig-out/bin/actual/check-setseq-8-rxs-m-xs-8.out
./zig-out/bin/check-setseq-16-xsh-rr-8 > zig-out/bin/actual/check-setseq-16-xsh-rr-8.out
./zig-out/bin/check-setseq-16-xsh-rs-8 > zig-out/bin/actual/check-setseq-16-xsh-rs-8.out
./zig-out/bin/check-setseq-16-rxs-m-xs-16 > zig-out/bin/actual/check-setseq-16-rxs-m-xs-16.out
./zig-out/bin/check-setseq-16-rxs-m-8 > zig-out/bin/actual/check-setseq-16-rxs-m-8.out
./zig-out/bin/check-setseq-32-xsh-rr-16 > zig-out/bin/actual/check-setseq-32-xsh-rr-16.out
./zig-out/bin/check-setseq-32-xsh-rs-16 > zig-out/bin/actual/check-setseq-32-xsh-rs-16.out
./zig-out/bin/check-setseq-32-rxs-m-xs-32 > zig-out/bin/actual/check-setseq-32-rxs-m-xs-32.out
./zig-out/bin/check-setseq-32-rxs-m-16 > zig-out/bin/actual/check-setseq-32-rxs-m-16.out
./zig-out/bin/check-setseq-64-xsh-rr-32 > zig-out/bin/actual/check-setseq-64-xsh-rr-32.out
./zig-out/bin/check-setseq-64-xsh-rs-32 > zig-out/bin/actual/check-setseq-64-xsh-rs-32.out
./zig-out/bin/check-setseq-64-xsl-rr-32 > zig-out/bin/actual/check-setseq-64-xsl-rr-32.out
./zig-out/bin/check-setseq-64-rxs-m-xs-64 > zig-out/bin/actual/check-setseq-64-rxs-m-xs-64.out
./zig-out/bin/check-setseq-64-rxs-m-32 > zig-out/bin/actual/check-setseq-64-rxs-m-32.out
./zig-out/bin/check-setseq-64-xsl-rr-rr-64 > zig-out/bin/actual/check-setseq-64-xsl-rr-rr-64.out
./zig-out/bin/check-setseq-128-xsh-rr-64 > zig-out/bin/actual/check-setseq-128-xsh-rr-64.out
./zig-out/bin/check-setseq-128-xsh-rs-64 > zig-out/bin/actual/check-setseq-128-xsh-rs-64.out
./zig-out/bin/check-setseq-128-xsl-rr-64 > zig-out/bin/actual/check-setseq-128-xsl-rr-64.out
./zig-out/bin/check-setseq-128-rxs-m-xs-128 > zig-out/bin/actual/check-setseq-128-rxs-m-xs-128.out
./zig-out/bin/check-setseq-128-rxs-m-64 > zig-out/bin/actual/check-setseq-128-rxs-m-64.out
./zig-out/bin/check-setseq-128-xsl-rr-rr-128 > zig-out/bin/actual/check-setseq-128-xsl-rr-rr-128.out

# Oneseq

./zig-out/bin/check-oneseq-8-rxs-m-xs-8 > zig-out/bin/actual/check-oneseq-8-rxs-m-xs-8.out
./zig-out/bin/check-oneseq-16-xsh-rr-8 > zig-out/bin/actual/check-oneseq-16-xsh-rr-8.out
./zig-out/bin/check-oneseq-16-xsh-rs-8 > zig-out/bin/actual/check-oneseq-16-xsh-rs-8.out
./zig-out/bin/check-oneseq-16-rxs-m-xs-16 > zig-out/bin/actual/check-oneseq-16-rxs-m-xs-16.out
./zig-out/bin/check-oneseq-16-rxs-m-8 > zig-out/bin/actual/check-oneseq-16-rxs-m-8.out
./zig-out/bin/check-oneseq-32-xsh-rr-16 > zig-out/bin/actual/check-oneseq-32-xsh-rr-16.out
./zig-out/bin/check-oneseq-32-xsh-rs-16 > zig-out/bin/actual/check-oneseq-32-xsh-rs-16.out
./zig-out/bin/check-oneseq-32-rxs-m-xs-32 > zig-out/bin/actual/check-oneseq-32-rxs-m-xs-32.out
./zig-out/bin/check-oneseq-32-rxs-m-16 > zig-out/bin/actual/check-oneseq-32-rxs-m-16.out
./zig-out/bin/check-oneseq-64-xsh-rr-32 > zig-out/bin/actual/check-oneseq-64-xsh-rr-32.out
./zig-out/bin/check-oneseq-64-xsh-rs-32 > zig-out/bin/actual/check-oneseq-64-xsh-rs-32.out
./zig-out/bin/check-oneseq-64-xsl-rr-32 > zig-out/bin/actual/check-oneseq-64-xsl-rr-32.out
./zig-out/bin/check-oneseq-64-rxs-m-xs-64 > zig-out/bin/actual/check-oneseq-64-rxs-m-xs-64.out
./zig-out/bin/check-oneseq-64-rxs-m-32 > zig-out/bin/actual/check-oneseq-64-rxs-m-32.out
./zig-out/bin/check-oneseq-64-xsl-rr-rr-64 > zig-out/bin/actual/check-oneseq-64-xsl-rr-rr-64.out
./zig-out/bin/check-oneseq-128-xsh-rr-64 > zig-out/bin/actual/check-oneseq-128-xsh-rr-64.out
./zig-out/bin/check-oneseq-128-xsh-rs-64 > zig-out/bin/actual/check-oneseq-128-xsh-rs-64.out
./zig-out/bin/check-oneseq-128-xsl-rr-64 > zig-out/bin/actual/check-oneseq-128-xsl-rr-64.out
./zig-out/bin/check-oneseq-128-rxs-m-xs-128 > zig-out/bin/actual/check-oneseq-128-rxs-m-xs-128.out
./zig-out/bin/check-oneseq-128-rxs-m-64 > zig-out/bin/actual/check-oneseq-128-rxs-m-64.out
./zig-out/bin/check-oneseq-128-xsl-rr-rr-128 > zig-out/bin/actual/check-oneseq-128-xsl-rr-rr-128.out

# MCG

./zig-out/bin/check-mcg-16-xsh-rr-8 > zig-out/bin/actual/check-mcg-16-xsh-rr-8.out
./zig-out/bin/check-mcg-16-xsh-rs-8 > zig-out/bin/actual/check-mcg-16-xsh-rs-8.out
./zig-out/bin/check-mcg-16-rxs-m-8 > zig-out/bin/actual/check-mcg-16-rxs-m-8.out
./zig-out/bin/check-mcg-32-xsh-rr-16 > zig-out/bin/actual/check-mcg-32-xsh-rr-16.out
./zig-out/bin/check-mcg-32-xsh-rs-16 > zig-out/bin/actual/check-mcg-32-xsh-rs-16.out
./zig-out/bin/check-mcg-32-rxs-m-16 > zig-out/bin/actual/check-mcg-32-rxs-m-16.out
./zig-out/bin/check-mcg-64-xsh-rr-32 > zig-out/bin/actual/check-mcg-64-xsh-rr-32.out
./zig-out/bin/check-mcg-64-xsh-rs-32 > zig-out/bin/actual/check-mcg-64-xsh-rs-32.out
./zig-out/bin/check-mcg-64-rxs-m-32 > zig-out/bin/actual/check-mcg-64-rxs-m-32.out
./zig-out/bin/check-mcg-64-xsl-rr-32 > zig-out/bin/actual/check-mcg-64-xsl-rr-32.out
./zig-out/bin/check-mcg-128-xsh-rr-64 > zig-out/bin/actual/check-mcg-128-xsh-rr-64.out
./zig-out/bin/check-mcg-128-xsh-rs-64 > zig-out/bin/actual/check-mcg-128-xsh-rs-64.out
./zig-out/bin/check-mcg-128-rxs-m-64 > zig-out/bin/actual/check-mcg-128-rxs-m-64.out
./zig-out/bin/check-mcg-128-xsl-rr-64 > zig-out/bin/actual/check-mcg-128-xsl-rr-64.out

# Unique

# The unique versions produce different outputs every run, so cannot be
# checked this way
# ./check-unique-16-xsh-rr-8 > actual/check-unique-16-xsh-rr-8.out
# ./check-unique-16-xsh-rs-8 > actual/check-unique-16-xsh-rs-8.out
# ./check-unique-16-rxs-m-xs-16 > actual/check-unique-16-rxs-m-xs-16.out
# ./check-unique-16-rxs-m-8 > actual/check-unique-16-rxs-m-8.out
# ./check-unique-32-xsh-rr-16 > actual/check-unique-32-xsh-rr-16.out
# ./check-unique-32-xsh-rs-16 > actual/check-unique-32-xsh-rs-16.out
# ./check-unique-32-rxs-m-xs-32 > actual/check-unique-32-rxs-m-xs-32.out
# ./check-unique-32-rxs-m-16 > actual/check-unique-32-rxs-m-16.out
# ./check-unique-64-xsh-rr-32 > actual/check-unique-64-xsh-rr-32.out
# ./check-unique-64-xsh-rs-32 > actual/check-unique-64-xsh-rs-32.out
# ./check-unique-64-xsl-rr-32 > actual/check-unique-64-xsl-rr-32.out
# ./check-unique-64-rxs-m-xs-64 > actual/check-unique-64-rxs-m-xs-64.out
# ./check-unique-64-rxs-m-32 > actual/check-unique-64-rxs-m-32.out
# ./check-unique-64-xsl-rr-rr-64 > actual/check-unique-64-xsl-rr-rr-64.out
# ./check-unique-128-xsh-rr-64 > actual/check-unique-128-xsh-rr-64.out
# ./check-unique-128-xsh-rs-64 > actual/check-unique-128-xsh-rs-64.out
# ./check-unique-128-xsl-rr-64 > actual/check-unique-128-xsl-rr-64.out
# ./check-unique-128-rxs-m-xs-128 > actual/check-unique-128-rxs-m-xs-128.out
# ./check-unique-128-rxs-m-64 > actual/check-unique-128-rxs-m-64.out
# ./check-unique-128-xsl-rr-rr-128 > actual/check-unique-128-xsl-rr-rr-128.out

./zig-out/bin/check-unique-16-xsh-rr-8       > /dev/null
./zig-out/bin/check-unique-16-xsh-rs-8       > /dev/null
./zig-out/bin/check-unique-16-rxs-m-xs-16    > /dev/null
./zig-out/bin/check-unique-16-rxs-m-8        > /dev/null
./zig-out/bin/check-unique-32-xsh-rr-16      > /dev/null
./zig-out/bin/check-unique-32-xsh-rs-16      > /dev/null
./zig-out/bin/check-unique-32-rxs-m-xs-32    > /dev/null
./zig-out/bin/check-unique-32-rxs-m-16       > /dev/null
./zig-out/bin/check-unique-64-xsh-rr-32      > /dev/null
./zig-out/bin/check-unique-64-xsh-rs-32      > /dev/null
./zig-out/bin/check-unique-64-xsl-rr-32      > /dev/null
./zig-out/bin/check-unique-64-rxs-m-xs-64    > /dev/null
./zig-out/bin/check-unique-64-rxs-m-32       > /dev/null
./zig-out/bin/check-unique-64-xsl-rr-rr-64   > /dev/null
./zig-out/bin/check-unique-128-xsh-rr-64     > /dev/null
./zig-out/bin/check-unique-128-xsh-rs-64     > /dev/null
./zig-out/bin/check-unique-128-xsl-rr-64     > /dev/null
./zig-out/bin/check-unique-128-rxs-m-xs-128  > /dev/null
./zig-out/bin/check-unique-128-rxs-m-64      > /dev/null
./zig-out/bin/check-unique-128-xsl-rr-rr-128 > /dev/null

find zig-out/bin/actual -type f -size -64c -delete

if diff -x .gitignore -ru pcg-c/test-low/expected zig-out/bin/actual
then
    echo All tests succeeded.
else
    echo ''
    if diff -x "*-128-*" -x .gitignore -ru pcg-c/test-low/expected zig-out/bin/actual > /dev/null
    then
        echo All tests except 128-bit tests succceed.
    else
        echo ERROR: Some tests failed.
    fi
fi
