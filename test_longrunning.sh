#! /bin/bash

# clean or build would be done for all!
#. ./_common/script/test_all_param.sh "$@"

OPTIONS=$@
#OPTIONS="-bv"
#OPTIONS="-b"
#OPTIONS="-br 1"

echo "this is longrunning - tests will take hours or even days"

cd Gravity_SPHINCS-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Gui-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** done long running tests ****"