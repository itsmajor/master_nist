mkdir -p test_compare
cd Optimized_Implementation/crypto_kem/kyber512
echo "moved to: ${PWD}"
make
cp PQCgenKAT_kem ../../../test_compare/PQCgenKAT_kem__clean_kyber512
cd  ../../..

#cd Additional_Implementations/With_Asm/crypto_kem/BabyBear
#echo "moved to: ${PWD}"
#make
#cp build/genkat ../../../../test_compare/genkat_BabyBear_AI_With_Asm
#cd  ../../../..
