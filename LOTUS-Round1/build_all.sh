cd Optimized_Implementation/encrypt
echo "moved to: ${PWD}"
make SEC=128 PQCgenKAT_encrypt
make SEC=192 PQCgenKAT_encrypt
make SEC=256 PQCgenKAT_encrypt
cd ../..

cd Optimized_Implementation/kem
echo "moved to: ${PWD}"
make SEC=128
make SEC=192
make SEC=256
cd ../..

