#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem FrodoKEM-640"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/optimized/FrodoKEM-640 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem FrodoKEM-976"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/optimized/FrodoKEM-976 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem FrodoKEM-1344"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/optimized/FrodoKEM-1344 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT


