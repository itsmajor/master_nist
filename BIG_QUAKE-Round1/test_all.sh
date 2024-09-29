#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem BIG_QUAKE_1"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_1 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem BIG_QUAKE_3"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_3 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem BIG_QUAKE_5"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_5 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
