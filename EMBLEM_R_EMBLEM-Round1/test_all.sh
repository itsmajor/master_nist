#! /bin/bash

. ../_common/script/test_all_param.sh "$@"
OPTIONS_ARRAY=($OPTIONS)

CIPHER="kem EMBLEM-R_EMBLEM"
../_common/script/doKat.sh $VALGRIND $CIPHER KAT/R_EMBLEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

CIPHER="kem EMBLEM-EMBLEM"
REPEATS=2
if [ ${OPTIONS_ARRAY[0]} -gt $REPEATS ]; then
  OPTIONS="$REPEATS ${OPTIONS_ARRAY[1]} ${OPTIONS_ARRAY[2]} ${OPTIONS_ARRAY[3]} ${OPTIONS_ARRAY[4]} ${OPTIONS_ARRAY[5]}"
  echo "*** reduced repeats to $REPEATS for $CIPHER ***"
fi
../_common/script/doKat.sh $VALGRIND $CIPHER KAT/EMBLEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT