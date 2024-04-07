mkdir -p tests/OI/BabyBear
mkdir -p tests/OI/BabyBearEphem
mkdir -p tests/OI/MamaBear
mkdir -p tests/OI/MamaBearEphem
mkdir -p tests/OI/PapaBear
mkdir -p tests/OI/PapaBearEphem

cd Optimized_Implementation/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../tests/OI/BabyBear
cd ../../..

cd Optimized_Implementation/crypto_kem/BabyBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../tests/OI/BabyBearEphem
cd ../../..

cd Optimized_Implementation/crypto_kem/MamaBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../tests/OI/MamaBear
cd ../../..

cd Optimized_Implementation/crypto_kem/MamaBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../tests/OI/MamaBearEphem
cd ../../..

cd Optimized_Implementation/crypto_kem/PapaBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../tests/OI/PapaBear
cd ../../..

cd Optimized_Implementation/crypto_kem/PapaBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../tests/OI/PapaBearEphem
cd ../../..



mkdir -p tests/AI_LowMem/BabyBear
mkdir -p tests/AI_LowMem/BabyBearEphem
mkdir -p tests/AI_LowMem/MamaBear
mkdir -p tests/AI_LowMem/MamaBearEphem
mkdir -p tests/AI_LowMem/PapaBear
mkdir -p tests/AI_LowMem/PapaBearEphem

cd Additional_Implementations/Low_Memory/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_LowMem/BabyBear
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/BabyBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_LowMem/BabyBearEphem
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/MamaBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_LowMem/MamaBear
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/MamaBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_LowMem/MamaBearEphem
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/PapaBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_LowMem/PapaBear
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/PapaBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_LowMem/PapaBearEphem
cd ../../../..



mkdir -p tests/AI_Asm/BabyBear
mkdir -p tests/AI_Asm/BabyBearEphem
mkdir -p tests/AI_Asm/MamaBear
mkdir -p tests/AI_Asm/MamaBearEphem
mkdir -p tests/AI_Asm/PapaBear
mkdir -p tests/AI_Asm/PapaBearEphem

cd Additional_Implementations/Low_Memory/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_Asm/BabyBear
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/BabyBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_Asm/BabyBearEphem
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/MamaBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_Asm/MamaBear
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/MamaBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_Asm/MamaBearEphem
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/PapaBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_Asm/PapaBear
cd ../../../..

cd Additional_Implementations/Low_Memory/crypto_kem/PapaBearEphem
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../tests/AI_Asm/PapaBearEphem
cd ../../../..