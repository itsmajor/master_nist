#! /bin/bash

# clean or build would be done for all!
#. ./_common/script/test_all_param.sh "$@"

OPTIONS=$@
#OPTIONS="-bv"
#OPTIONS="-b"
#OPTIONS="-br 1"

echo "**** start test_sign.sh ****"

cd CRYSTALS_Dilithium-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Falcon-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd pqNTRUsign-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Picnic-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** continue test_sign.sh with longrunning SPHINCS-Round3 ****"
cd SPHINCS-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** continue test_sign.sh with longrunning Gui-Round1 ****"
cd Gui-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** continue test_sign.sh with longrunning Gravity_SPHINCS-Round1 ****"
cd Gravity_SPHINCS-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
#./test_all.sh -vr 2
cd ..

echo "**** done test_sign.sh ****"