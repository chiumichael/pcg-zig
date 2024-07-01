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

./zig-out/bin/check-pcg32-global > zig-out/bin/actual/check-pcg32-global.out
./zig-out/bin/check-pcg64-global > zig-out/bin/actual/check-pcg64-global.out

./zig-out/bin/check-pcg8i > zig-out/bin/actual/check-pcg8i.out
./zig-out/bin/check-pcg8si > zig-out/bin/actual/check-pcg8si.out

./zig-out/bin/check-pcg16i > zig-out/bin/actual/check-pcg16i.out
./zig-out/bin/check-pcg16si > zig-out/bin/actual/check-pcg16si.out

./zig-out/bin/check-pcg32si > zig-out/bin/actual/check-pcg32si.out
./zig-out/bin/check-pcg32i > zig-out/bin/actual/check-pcg32i.out

./zig-out/bin/check-pcg32 > zig-out/bin/actual/check-pcg32.out
./zig-out/bin/check-pcg32f > zig-out/bin/actual/check-pcg32f.out
./zig-out/bin/check-pcg32s > zig-out/bin/actual/check-pcg32s.out
./zig-out/bin/check-pcg32u > /dev/null

./zig-out/bin/check-pcg64si > zig-out/bin/actual/check-pcg64si.out
./zig-out/bin/check-pcg64i > zig-out/bin/actual/check-pcg64i.out

./zig-out/bin/check-pcg64 > zig-out/bin/actual/check-pcg64.out
./zig-out/bin/check-pcg64f > zig-out/bin/actual/check-pcg64f.out
./zig-out/bin/check-pcg64s > zig-out/bin/actual/check-pcg64s.out
./zig-out/bin/check-pcg64u > /dev/null

./zig-out/bin/check-pcg128i > zig-out/bin/actual/check-pcg128i.out
./zig-out/bin/check-pcg128si > zig-out/bin/actual/check-pcg128si.out

find zig-out/bin/actual -type f -size -64c -delete

if diff -x .gitignore -ru pcg-c/test-high/expected zig-out/bin/actual
then
    echo All tests succeeded.
else
    echo ''
    if diff -x "*-pcg64[fsu].out" -x "*-pcg64-global.out" -x "*-pcg64.out" \
            -x "*-pcg128*.out" -x .gitignore -ru expected zig-out/bin/actual > /dev/null
    then
        echo All tests except tests requiring 128-bit math succceed.
    else
        echo ERROR: Some tests failed.
    fi
fi
