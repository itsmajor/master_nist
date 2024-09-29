#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem SABER"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation_KEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
