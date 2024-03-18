mkdir -p tests

cd Optimized_Implementation/crypto_kem/newhope512cca
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/PQCgenKAT_kem_newhope512cca
cd ../../..

cd Optimized_Implementation/crypto_kem/newhope512cpa
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/PQCgenKAT_kem_newhope512cpa
cd ../../..

cd Optimized_Implementation/crypto_kem/newhope1024cca
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/PQCgenKAT_kem_newhope1024cca
cd ../../..

cd Optimized_Implementation/crypto_kem/newhope1024cpa
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../../../tests/PQCgenKAT_kem_newhope1024cpa
cd ../../..
