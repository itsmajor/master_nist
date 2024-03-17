cd Reference_Implementation/crypto_sign/dilithium/test
echo "test dilithium2"
./test_speed2

echo "test dilithium2aes"
./test_speed2aes

echo "test dilithium3"
./test_speed3

echo "test dilithium3aes"
./test_speed3aes

echo "test dilithium5"
./test_speed5

echo "test dilithium5aes"
./test_speed5aes

cd ../../../..