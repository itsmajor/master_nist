mkdir -p tests2
mkdir -p build
cd build
rm -R *

echo "*** modified measurement parameter (REPEAT 10, OUTER_REPEAT 1, WARMUP 0) in include/internal/measurement.h ****"
echo "cmake bike level 1 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DNUM_OF_TESTS=1 -DRDTSC=1 ..
make
mv bike-test ../tests2/bike-test-1
rm -R *

echo "cmake bike level 3 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=3 -DNUM_OF_TESTS=1 -DRDTSC=1 ..
make
mv bike-test ../tests2/bike-test-3
rm -R *

echo "cmake bike level 5 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=5 -DNUM_OF_TESTS=1 -DRDTSC=1 ..
make
mv bike-test ../tests2/bike-test-5
rm -R *

echo "build done"
