cd Optimized_Implementation/encrypt/tests/lotus128
echo "test encrypt lotus128"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/encrypt/tests/lotus192
echo "test encrypt lotus192"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/encrypt/tests/lotus256
echo "test encrypt lotus256"
./PQCgenKAT_encrypt
cd ../../..

cd Optimized_Implementation/kem/tests/lotus128
echo "test kem lotus128"
./PQCgenKAT_kem
cd ../../..

cd Optimized_Implementation/kem/tests/lotus192
echo "test kem lotus192"
./PQCgenKAT_kem
cd ../../..

cd Optimized_Implementation/kem/tests/lotus256
echo "test kem lotus256"
./PQCgenKAT_kem
cd ../../..