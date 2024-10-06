#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

#disabled 448 because one run (non valgrind) takes 64 minutes!
#312 takes 10m for one run (non valgrind)
#sec_array=(184 312 448)
sec_array=(184)
repeat_array=(3 1 1)

i=0
for sec in "${sec_array[@]}"; do
  CIPHER="sign Gui-"$sec
  REPEATS=${repeat_array[i++]}
  if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
    OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]}"
    echo "*** reduced repeats to $REPEATS for $CIPHER ***"
  fi
  ../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/amd64/Gui-$sec $OPTIONS
  ../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
done
