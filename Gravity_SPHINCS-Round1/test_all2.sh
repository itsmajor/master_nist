#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

# 'VERSION_M' 'VERSION_L' disabled - segfault/too long running
sec_array=('VERSION_S' 'VERSION_M' 'VERSION_L')

for sec in "${sec_array[@]}"; do
  CIPHER="sign Gravity_SPHINCS_"$sec
  REPEATS=1
  if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
    OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
    echo "*** reduced repeats to $REPEATS for $CIPHER ***"
  fi
  ../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation/$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done