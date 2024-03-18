mkdir -p Reference_Implementation/tests

cd Reference_Implementation/Gaussian-1024
echo "moved to: ${PWD}"
make
mv Gaussian-pqNTRUSign-1024 ../../tests
cd ../..

cd Reference_Implementation/Uniform-1024
echo "moved to: ${PWD}"
make
mv Uniform-pqNTRUSign-1024 ../../tests
cd ../..