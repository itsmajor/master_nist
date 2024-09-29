#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem Ding_LWE"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
