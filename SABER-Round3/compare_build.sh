mkdir -p test_compare
cd Additional_Implementations/Low_Memory/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../test_compare/genkat_BabyBear_AI_Low_Memory
cd  ../../../..

cd Additional_Implementations/With_Asm/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../../test_compare/genkat_BabyBear_AI_With_Asm
cd  ../../../..

cd Optimized_Implementation/crypto_kem/BabyBear
echo "moved to: ${PWD}"
make
cp build/genkat ../../../test_compare/genkat_BabyBear_OI
cd  ../../..
