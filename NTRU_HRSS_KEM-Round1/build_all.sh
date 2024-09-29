MAKEOPTION=$1;

cd Optimized_Implementation/crypto_kem/ntruhrss701
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-