mkdir -p tests
cd ../..
git clone https://github.com/awslabs/bike-kem.git
cd -

cd Additional_Implementations/bike_kem/build
echo "moved to: ${PWD}"
make all
mv bike-test ../../../tests/bike-test
cd ../../..