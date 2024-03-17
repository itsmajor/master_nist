cd Optimized_Implementation/encrypt/lotus128
echo "test encrypt lotus128"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/encrypt/lotus192
echo "test encrypt lotus192"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/encrypt/lotus256
echo "test encrypt lotus256"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/kem/lotus128
echo "test kem lotus128"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/kem/lotus192
echo "test kem lotus192"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/kem/lotus256
echo "test kem lotus256"
./PQCgenKAT_encrypt
cd ../../..