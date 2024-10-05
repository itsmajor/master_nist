#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=(184 312 448)
#sec_array=(184)

for sec in "${sec_array[@]}"; do
  CIPHER="sign Gui-"$sec
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/amd64/Gui-$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done