cd tests

echo "create KAT kyber512"
./PQCgenKAT_kem__kyber512

echo "create KAT kyber512-90s"
./PQCgenKAT_kem__kyber512-90s

echo "create KAT kyber768"
./PQCgenKAT_kem__kyber768

echo "create KAT kyber768-90s"
./PQCgenKAT_kem__kyber768-90s

echo "create KAT kyber1024"
./PQCgenKAT_kem__kyber1024

echo "create KAT kyber1024-90s"
./PQCgenKAT_kem__kyber1024-90s

cd ..






