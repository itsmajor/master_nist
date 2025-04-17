#! /bin/bash

# clean or build would be done for all!
#. ./_common/script/test_all_param.sh "$@"

OPTIONS="$@"

echo "*** this is longrunning - tests will take hours or even days ***"
if [[ "$OPTIONS" == *s* ]]; then
  echo "*** force enabled! no reduced repeats - this will take ages! ***"
fi

cd BIG_QUAKE-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Classic-McEliece-Round4
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd EMBLEM_R_EMBLEM-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Gravity_SPHINCS-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Gui-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "skip LOTUS-Round1 in 32bit (test fails)"
#cd LOTUS-Round1
#echo "moved to: ${PWD}"
#./test_all.sh $OPTIONS
#cd ..

cd Odd_Manhattan-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd SPHINCS-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** done long running tests ****"