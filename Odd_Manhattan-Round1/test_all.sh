#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

sec_array=(128 192 256)
repeat_array=(3 2 1)

i=0
for sec in "${sec_array[@]}"; do
  CIPHER="kem Odd_Manhattan_"$sec
  REPEATS=${repeat_array[i++]}
  if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
      OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]}"
      echo "*** reduced repeats to $REPEATS for $CIPHER ***"
  fi
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done


