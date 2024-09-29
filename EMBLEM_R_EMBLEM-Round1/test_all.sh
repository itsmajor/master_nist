#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem EMBLEM-EMBLEM"
../_common/script/doKat.sh $VALGRIND $CIPHER KAT/EMBLEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem EMBLEM-R_EMBLEM"
../_common/script/doKat.sh $VALGRIND $CIPHER KAT/R_EMBLEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
