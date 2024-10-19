#! /bin/bash

echo "test_all will start test_longrunning at the end"

# clean or build would be done for all!
#. ./_common/script/test_all_param.sh "$@"

OPTIONS=$@
#OPTIONS="-bv"
#OPTIONS="-b"
#OPTIONS="-br 1"

echo "skip bike-kem in 32bit"
#cd bike-kem
#echo "moved to: ${PWD}"
#./test_all.sh $OPTIONS
#cd ..

cd CRYSTALS_Dilithium-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd CRYSTALS_Kyber-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Ding_LWE_Key_Exchange-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Falcon-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd FrodoKEM-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd HQC-Round4
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd KCL-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "skip KINDI-Round1 in 32bit"
#cd KINDI-Round1
#echo "moved to: ${PWD}"
#./test_all.sh $OPTIONS
#cd ..

cd Lima-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd NewHope-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd NTRUEncrypt-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd NTRU_HRSS_KEM-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd NTRU-Prime-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd NTRU-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Picnic-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd pqNTRUsign-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd SABER-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "skip ThreeBears-Round1 in 32bit"
#cd ThreeBears-Round1
#echo "moved to: ${PWD}"
#./test_all.sh $OPTIONS
#cd ..


echo "**** done test_all.sh (long running excluded) ****"
./test_longrunning.sh $@

mv mv testresult testresult_`hostname`_$(date +'%Y.%m.%d_%H.%M')_`echo $@ | sed 's/ /_/g'`
