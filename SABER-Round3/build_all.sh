mkdir -p tests

cd Reference_Implementation_KEM
echo "moved to: ${PWD}"
make
mv test/test_kex ../tests/
cd ..