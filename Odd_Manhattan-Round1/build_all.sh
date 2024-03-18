mkdir -p tests

cd Optimized_Implementation
echo "moved to: ${PWD}"
make
mv PQCgenKAT_kem ../tests
cd ..