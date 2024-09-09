MAKEOPTION=$1;

mkdir -p tests

cd Optimized_Implementation/crypto_kem/kyber1024
echo "moved to: ${PWD}"
make $MAKEOPTION
cp PQCgenKAT_kem ../../../tests/PQCgenKAT_kem__kyber1024
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber1024-90s
echo "moved to: ${PWD}"
make $MAKEOPTION
cp PQCgenKAT_kem ../../../tests/PQCgenKAT_kem__kyber1024-90s
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber512
echo "moved to: ${PWD}"
make $MAKEOPTION
cp PQCgenKAT_kem ../../../tests/PQCgenKAT_kem__kyber512
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber512-90s
echo "moved to: ${PWD}"
make $MAKEOPTION
cp PQCgenKAT_kem ../../../tests/PQCgenKAT_kem__kyber512-90s
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber768
echo "moved to: ${PWD}"
make $MAKEOPTION
cp PQCgenKAT_kem ../../../tests/PQCgenKAT_kem__kyber768
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber768-90s
echo "moved to: ${PWD}"
make $MAKEOPTION
cp PQCgenKAT_kem ../../../tests/PQCgenKAT_kem__kyber768-90s
cd ../../..


