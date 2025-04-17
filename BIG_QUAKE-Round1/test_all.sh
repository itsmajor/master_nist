#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
#first param is repeat value, this will be overriden for this test
OPTIONS_ARRAY=($OPTIONS)

CIPHER="kem BIG_QUAKE_1"
REPEATS=5
if [ "${OPTIONS_ARRAY[0]}" -gt "$REPEATS" ] && [ "${OPTIONS_ARRAY[5]}" -ne 1 ]; then
  OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
  echo "*** reduced repeats to $REPEATS for $CIPHER ***"
fi
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_1 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT


CIPHER="kem BIG_QUAKE_3"
REPEATS=2
if [ "${OPTIONS_ARRAY[0]}" -gt "$REPEATS" ] && [ "${OPTIONS_ARRAY[5]}" -ne 1 ]; then
  OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
  echo "*** reduced repeats to $REPEATS for $CIPHER ***"
fi
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_3 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT


CIPHER="kem BIG_QUAKE_5"
REPEATS=2
if [ "${OPTIONS_ARRAY[0]}" -gt "$REPEATS" ] && [ "${OPTIONS_ARRAY[5]}" -ne 1 ]; then
  OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
  echo "*** reduced repeats to $REPEATS for $CIPHER ***"
fi
../_common/script/doKat.sh $VALGRIND $CIPHER Optimized_Implementation/BIG_QUAKE_5 $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT
