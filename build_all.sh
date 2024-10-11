#! /bin/bash

MAKEOPTION=$1;

cd BIG_QUAKE-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

if [ -f "bike-kem/bin/bike-5_aes/PQCgenKAT_kem" ]; then
  echo "moved to: ./bike-kem - found KAT binary, remove bin/ for rebuild"
else
  if [ "clean" == $MAKEOPTION ]; then
    echo "no clean for bike_kem - clean it yourself"
  else
    cd bike-kem
    echo "moved to: ${PWD}"
    ./build_all.sh $MAKEOPTION
    cd ~-
  fi
fi

cd Classic-McEliece-Round4
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd CRYSTALS_Dilithium-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd CRYSTALS_Kyber-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd Ding_LWE_Key_Exchange-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

# removed
#cd DualModeMS-Round1
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

cd FrodoKEM-Round3
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

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

cd KINDI-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd Lima-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd LOTUS-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

cd NewHope-Round1
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

cd ThreeBears-Round1
echo "moved to: ${PWD}"
./build_all.sh $MAKEOPTION
cd ~-

# removed
#cd Titanium-Round1
#echo "moved to: ${PWD}"
#./build_all.sh $MAKEOPTION
#cd ~-


echo "**** root build_all.sh done ****"