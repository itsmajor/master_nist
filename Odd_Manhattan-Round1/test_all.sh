#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

#CIPHER="kem Odd_Manhattan_128"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/128 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
#
#CIPHER="kem Odd_Manhattan_192"
#../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/192 $OPTIONS
#../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem Odd_Manhattan_256"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/256 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

