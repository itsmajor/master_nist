#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(512 1024)
impl_array=('fpu')

for sec in "${sec_array[@]}"; do
  CIPHER="sign Falcon_"$sec"_fpu"
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/falcon"$sec"/falcon"$sec"fpu $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done