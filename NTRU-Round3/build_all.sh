MAKEOPTION=$1;

cd Optimized_Implementation/crypto_kem/ntruhrss701
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-

cd Optimized_Implementation/crypto_kem/ntruhps2048509
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-

cd Optimized_Implementation/crypto_kem/ntruhps2048677
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-

cd Optimized_Implementation/crypto_kem/ntruhps4096821
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-
