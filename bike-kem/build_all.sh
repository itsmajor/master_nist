mkdir -p tests2
mkdir -p build
cd build
rm -R *

echo "*** modified measurement parameter (REPEAT 10, OUTER_REPEAT 1, WARMUP 1) in include/internal/measurement.h ****"
echo "cmake bike level 1 SHA3/SHAKE (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DNUM_OF_TESTS=1 -DRDTSC=1 ..
make
mv bike-test ../tests2/bike-test-1_sha3
rm -R *

echo "cmake bike level 3 SHA3/SHAKE (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=3  ..
make
mv bike-test ../tests2/bike-test-3_sha3
rm -R *

echo "cmake bike level 5 SHA3/SHAKE (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=5 -DRDTSC=1 ..
make
mv bike-test ../tests2/bike-test-5_sha3
rm -R *

echo "cmake bike level 1 AES/SHA2 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DRDTSC=1 -DUSE_AES_AND_SHA2 ..
make
mv bike-test ../tests2/bike-test-1_aes
rm -R *

echo "cmake bike level 3 AES/SHA2 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=3 -DRDTSC=1 -DUSE_AES_AND_SHA2 ..
make
mv bike-test ../tests2/bike-test-3_aes
rm -R *

echo "cmake bike level 5 AES/SHA2 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=5 -DRDTSC=1 -DUSE_AES_AND_SHA2 ..
make
mv bike-test ../tests2/bike-test-5_aes
rm -R *

echo "build done"
