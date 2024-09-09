MAKEOPTION=$1;

cd Optimized_Implementation/crypto_kem/kyber1024
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber1024-90s
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber512
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber512-90s
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber768
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/kyber768-90s
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..


