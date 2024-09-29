#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="sign pqNTRUSign-Gaussian-1024"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/Gaussian-1024 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="sign pqNTRUSign-Uniform-1024"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/Uniform-1024 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT