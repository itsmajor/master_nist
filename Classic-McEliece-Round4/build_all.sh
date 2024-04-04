mkdir -p tests

cd Additional_Implementations/kem/mceliece348864/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece348864/
mv run ../../../../tests/mceliece348864/run
cd ../../../..

cd Additional_Implementations/kem/mceliece348864f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece348864f/
mv run ../../../../tests/mceliece348864f/run
cd ../../../..

cd Additional_Implementations/kem/mceliece460896/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece460896/
mv run ../../../../tests/mceliece460896/run
cd ../../../..

cd Additional_Implementations/kem/mceliece460896f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece460896f/
mv run ../../../../tests/mceliece460896f/run
cd ../../../..

cd Additional_Implementations/kem/mceliece6688128/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6688128/
mv run ../../../../tests/mceliece6688128/run
cd ../../../..

cd Additional_Implementations/kem/mceliece6688128f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6688128f/
mv run ../../../../tests/mceliece6688128f/run
cd ../../../..

cd Additional_Implementations/kem/mceliece6960119/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6960119/
mv run ../../../../tests/mceliece6960119/run
cd ../../../..

cd Additional_Implementations/kem/mceliece6960119f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6960119f/
mv run ../../../../tests/mceliece6960119f/run
cd ../../../..

cd Additional_Implementations/kem/mceliece8192128/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece8192128/
mv run ../../../../tests/mceliece8192128/run
cd ../../../..

cd Additional_Implementations/kem/mceliece8192128f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece8192128f/
mv run ../../../../tests/mceliece8192128f/run
cd ../../../..
