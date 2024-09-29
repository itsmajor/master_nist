#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=('VERSION_S' 'VERSION_M' 'VERSION_L')

for sec in "${sec_array[@]}"; do
  CIPHER="sign Gravity_SPHINCS_"$sec
  ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done