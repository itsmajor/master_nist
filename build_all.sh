#! /bin/bash

#check last added lib
if [ ! -f "/usr/include/gf2x.h" ]; then
  sudo apt install -y libssl-dev libntl-dev libgmp-dev libgf2x-dev
fi

MAKEOPTION=$1;
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` "*** start (root) build_all.sh ***" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`

cd BIG_QUAKE-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

echo "skip bike-kem in 32bit (build fails)"
#if [ -f "bike-kem/bin/bike-5_aes/PQCgenKAT_kem" ]; then
#  echo "moved to: ./bike-kem - found KAT binary, remove bin/ for rebuild"
#else
#  if [ "clean" == $MAKEOPTION ]; then
#    echo "no clean for bike_kem - clean it yourself"
#  else
#    cd bike-kem
#    echo "moved to: ${PWD}"
#    ./build_all.sh $MAKEOPTION
#    cd ~-
#  fi
#fi

cd Classic-McEliece-Round4
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

echo "skip CRYSTALS_Dilithium-Round3 in 32bit (test fails)"
#cd CRYSTALS_Dilithium-Round3
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

cd CRYSTALS_Kyber-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

echo "skip Ding_LWE_Key_Exchange in 32bit (build fails)"
#cd Ding_LWE_Key_Exchange-Round1
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

cd EMBLEM_R_EMBLEM-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd Falcon-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

echo "skip FrodoKEM-Round3 in 32bit (build fails)"
#cd FrodoKEM-Round3
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

cd Gravity_SPHINCS-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd Gui-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd HQC-Round4
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd KCL-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

echo "skip KINDI-Round1 in 32bit (build fails)"
#cd KINDI-Round1
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

cd Lima-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

echo "skip LOTUS-Round1 in 32bit (test fails)"
#cd LOTUS-Round1
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

rm -f -r NewHope-Round1
cd NewHope-Round2
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd NTRUEncrypt-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd NTRU_HRSS_KEM-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd NTRU-Prime-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd NTRU-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd Odd_Manhattan-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd Picnic-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd pqNTRUsign-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd SABER-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd SPHINCS-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

rm -f -r ThreeBears-Round1
echo "skip ThreeBears-Round2 in 32bit (build fails)"
#cd ThreeBears-Round2
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

# removed
#cd Titanium-Round1
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-

echo `date +'%d.%m.%Y %H:%M:%S.%3N'` "*** done (root) build_all.sh ***" `sensors | grep temp | sed 's/  (crit = +110\.0°C)//g'`
