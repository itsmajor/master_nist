#! /bin/bash

echo "test_all will start test_longrunning at the end"

# clean or build would be done for all!
#. ./_common/script/test_all_param.sh "$@"

OPTIONS="$@"
#OPTIONS="-bv"
#OPTIONS="-b"
#OPTIONS="-br 1"


cd bike-kem
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

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

cd KINDI-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Lima-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd NewHope-Round2
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

# skip pqNTRUsign-Round1 on PiBanana
if [[ "$(hostname)" != "PiBanana" ]]; then
  cd pqNTRUsign-Round1
  echo "moved to: ${PWD}"
  ./test_all.sh $OPTIONS
  cd ..
else
  echo "skip pqNTRUsign-Round1 auf $(hostname)"
fi

cd SABER-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd ThreeBears-Round2
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..


echo "**** done test_all.sh (long running excluded) ****"
./test_longrunning.sh $@

echo "finished" >> testresult/verifyresult.log
./rename_testresult.sh $@
