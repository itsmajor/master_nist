MAKEOPTION=$1;
mkdir -p tests

cd Optimized_Implementation/crypto_kem/newhope512cca
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/newhope512cpa
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/newhope1024cca
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/crypto_kem/newhope1024cpa
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..
