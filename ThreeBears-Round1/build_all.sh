MAKEOPTION=$1;

cd Optimized_Implementation/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/BabyBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/MamaBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/MamaBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/PapaBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/PapaBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..


cd Additional_Implementations/Low_Memory/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/BabyBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/MamaBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/MamaBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/PapaBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/PapaBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..



cd Additional_Implementations/With_Asm/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/BabyBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/MamaBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/MamaBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/PapaBear
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/PapaBearEphem
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../../..