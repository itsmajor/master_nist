#! /bin/bash
# do a quick round of all KAT, continue to all normal, then longrunning
OPTIONS="$@"

echo "**** start test_quick.sh *** KEM 1 ****"

cd Ding_LWE_Key_Exchange-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd HQC-Round4
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** start test_quick.sh *** ENC 1 ****"

cd KCL-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** start test_quick.sh *** SIGN 1 ****"

cd Falcon-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** start test_quick.sh *** KEM 2 ****"

cd bike-kem
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd CRYSTALS_Kyber-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd FrodoKEM-Round3
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

cd SABER-Round3
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd ThreeBears-Round2
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** start test_quick.sh *** ENC 2 ****"

cd KINDI-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

cd Lima-Round1
echo "moved to: ${PWD}"
./test_all.sh $OPTIONS
cd ..

echo "**** start test_quick.sh *** SIGN 2 ****"

cd CRYSTALS_Dilithium-Round3
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

echo "**** done test_quick.sh continue longrunning ****"
./test_longrunning.sh $@
