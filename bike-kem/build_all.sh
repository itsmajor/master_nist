MAKEOPTION=$1;

mkdir -p build
mkdir -p bin
mkdir -p bin/bike-1_sha3
mkdir -p bin/bike-3_sha3
mkdir -p bin/bike-5_sha3
mkdir -p bin/bike-1_aes
mkdir -p bin/bike-3_aes
mkdir -p bin/bike-5_aes
cd build
rm -f -R *

#echo "*** modified measurement parameter (REPEAT 10, OUTER_REPEAT 1, WARMUP 1) in include/internal/measurement.h ****"
echo "cmake bike level 1 SHA3/SHAKE (10 repeats)"
#cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DNUM_OF_TESTS=1 -DRDTSC=1 ..
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DRDTSC=1 -DUSE_NIST_RAND=1 ..
make $MAKEOPTION
mv PQCgenKAT_kem* ../bin/bike-1_sha3/
rm -R *

echo "cmake bike level 3 SHA3/SHAKE (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=3 -DRDTSC=1 -DUSE_NIST_RAND=1 ..
make $MAKEOPTION
mv PQCgenKAT_kem* ../bin/bike-3_sha3/
rm -R *

echo "cmake bike level 5 SHA3/SHAKE (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=5 -DRDTSC=1 -DUSE_NIST_RAND=1 ..
make $MAKEOPTION
mv PQCgenKAT_kem* ../bin/bike-5_sha3/
rm -R *

echo "cmake bike level 1 AES/SHA2 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=1 -DRDTSC=1 -DUSE_AES_AND_SHA2=1 -DUSE_NIST_RAND=1 ..
make $MAKEOPTION
mv PQCgenKAT_kem* ../bin/bike-1_aes/
rm -R *

echo "cmake bike level 3 AES/SHA2 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=3 -DRDTSC=1 -DUSE_AES_AND_SHA2=1 -DUSE_NIST_RAND=1 ..
make $MAKEOPTION
mv PQCgenKAT_kem* ../bin/bike-3_aes/
rm -R *

echo "cmake bike level 5 AES/SHA2 (10 repeats)"
cmake -DCMAKE_BUILD_TYPE=Release -DLEVEL=5 -DRDTSC=1 -DUSE_AES_AND_SHA2=1 -DUSE_NIST_RAND=1 ..
make $MAKEOPTION
mv PQCgenKAT_kem* ../bin/bike-5_aes/
rm -R *

echo "build done"
