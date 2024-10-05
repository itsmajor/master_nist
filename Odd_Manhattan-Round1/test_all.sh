#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(128 192 256)

for sec in "${sec_array[@]}"; do
  CIPHER="kem Odd_Manhattan_"$sec
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done


