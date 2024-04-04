cd tests2
echo "test bike 1 SHA3/SHAKE (avg of 10 repeats)"
./bike-test-1_sha3

echo "test bike 1 AES/SHA2 (avg of 10 repeats)"
./bike-test-1_aes

echo "test bike 3 SHA3/SHAKE (avg of 10 repeats)"
./bike-test-3_sha3

echo "test bike 3 AES/SHA2 (avg of 10 repeats)"
./bike-test-3_aes

echo "test bike 5 SHA3/SHAKE (avg of 10 repeats)"
./bike-test-5_sha3

echo "test bike 5 AES/SHA2 (avg of 10 repeats)"
./bike-test-5_aes

cd ..

