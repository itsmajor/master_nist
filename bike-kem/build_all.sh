mkdir -p tests
cd ../..
echo "trying to clone bike-kem, ignore if already exists"
git clone https://github.com/awslabs/bike-kem.git

cd bike-kem
rm -R -d build
mkdir -p build

cd build
echo "cmake bike level 1"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DNUM_OF_TESTS=3 -DRDTSC=1 ..
make
mv bike-test ../../master_nist/bike-kem/tests/bike-test-1
rm -R *

echo "cmake bike level 3"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=3 -DNUM_OF_TESTS=3 -DRDTSC=1 ..
make
mv bike-test ../../master_nist/bike-kem/tests/bike-test-3
rm -R *

echo "cmake bike level 5"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=5 -DNUM_OF_TESTS=3 -DRDTSC=1 ..
make
mv bike-test ../../master_nist/bike-kem/tests/bike-test-5
rm -R *

echo "build done"
