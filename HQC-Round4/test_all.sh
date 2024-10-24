#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem hqc-128"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/hqc-128/src $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem hqc-192"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/hqc-192/src $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem hqc-256"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/hqc-256/src $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
