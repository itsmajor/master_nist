#! /bin/bash

# clean or build would be done for all!
#. ./_common/script/test_all_param.sh "$@"

OPTIONS="$@"
#OPTIONS="-bv"
#OPTIONS="-b"
#OPTIONS="-br 1"

echo "**** start test_encrypt.sh ****"

cd KCL-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd KINDI-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Lima-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** continue test_encrypt.sh with longrunning LOTUS ****"

cd LOTUS-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

# broken - no encrypt works
#cd NTRUEncrypt-Round1
#echo "moved to: ${PWD}"
#./test_all.sh $OPTIONS
#cd ..



echo "**** done test_encrypt.sh ****"