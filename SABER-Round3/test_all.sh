#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem LightSABER"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/SABER_L-2 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem SABER"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/SABER_L-3 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem FireSABER"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/SABER_L-4 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT