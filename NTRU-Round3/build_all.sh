mkdir -p tests
mkdir -p tests/ntruhrss701
mkdir -p tests/ntruhps2048509
mkdir -p tests/ntruhps2048677
mkdir -p tests/ntruhps4096821


cd Optimized_Implementation/crypto_kem/ntruhrss701
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/ntruhrss701/
cd ../../..

cd Optimized_Implementation/crypto_kem/ntruhps2048509
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/ntruhps2048509/
cd ../../..

cd Optimized_Implementation/crypto_kem/ntruhps2048677
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/ntruhps2048677/
cd ../../..

cd Optimized_Implementation/crypto_kem/ntruhps4096821
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/ntruhps4096821/
cd ../../..
