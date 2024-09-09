MAKEOPTION=$1;

mkdir -p tests

cd Optimized_Implementation
echo "moved to: ${PWD}"
make $MAKEOPTION
mv PQCgenKAT_kem ../tests
cd ..