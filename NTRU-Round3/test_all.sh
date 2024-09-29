#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

CIPHER="kem NTRU-Round3-ntruhrss701"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhrss701 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Round3-ntruhps2048509"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhps2048509 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Round3-ntruhps2048677"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhps2048677 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem NTRU-Round3-ntruhps4096821"
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/crypto_kem/ntruhps4096821 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

