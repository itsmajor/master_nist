mkdir -p tests

cd Optimized_Implementation/crypto_kem/ntruhrss701
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests
cd ../../..