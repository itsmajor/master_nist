#! /bin/bash

. ../_common/script/test_all_param.sh "$@"

# do not call this script with -b it will rebuild here

cd Reference_Implementation_KEM
echo "moved to: ${PWD}"
make clean
make saber2
cd ~-

CIPHER="kem LightSABER"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation_KEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT

cd Reference_Implementation_KEM
echo "moved to: ${PWD}"
make clean
make saber4
cd ~-

CIPHER="kem FireSABER"
../_common/script/doKat.sh $VALGRIND $CIPHER Reference_Implementation_KEM $OPTIONS
../_common/script/doVerifyKat.sh $CIPHER $DEBUG_VERIFYKAT


cd ..
./rename_testresult.sh SABER"$@"
./move_to_majorpc.sh
