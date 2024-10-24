#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

sec_array=('3l1' '3l3' '3l5' 'l1fs' 'l1full' 'l1ur' 'l3fs' 'l3full' 'l3ur' 'l5fs' 'l5full' 'l5ur')

for sec in "${sec_array[@]}"; do
  CIPHER="sign Picnic_"$sec"_OI"
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/picnic"$sec" $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done
