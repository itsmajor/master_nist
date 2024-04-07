mkdir -p test_compare
cd Optimized_Implementation/crypto_kem/kyber512
echo "moved to: ${PWD}"
make
cp PQCgenKAT_kem ../../../test_compare/PQCgenKAT_kem__OI_kyber512
cd  ../../..

cd Optimized_Implementation/crypto_kem/kyber1024
echo "moved to: ${PWD}"
make
cp PQCgenKAT_kem ../../../test_compare/PQCgenKAT_kem__OI_kyber1024
cd  ../../..

cd Additional_Implementations/clean/crypto_kem/kyber512
echo "moved to: ${PWD}"
make
cp PQCgenKAT_kem ../../../../test_compare/PQCgenKAT_kem__AI_kyber512
cd  ../../../..

cd Additional_Implementations/clean/crypto_kem/kyber1024
echo "moved to: ${PWD}"
make
cp PQCgenKAT_kem ../../../../test_compare/PQCgenKAT_kem__AI_kyber1024
cd  ../../../..