mkdir -p tests

cd Additional_Implementations/kem/mceliece348864/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece348864/
mv kat ../../../../tests/mceliece348864/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece348864f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece348864f/
mv kat ../../../../tests/mceliece348864f/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece460896/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece460896/
mv kat ../../../../tests/mceliece460896/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece460896f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece460896f/
mv kat ../../../../tests/mceliece460896f/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece6688128/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6688128/
mv kat ../../../../tests/mceliece6688128/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece6688128f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6688128f/
mv kat ../../../../tests/mceliece6688128f/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece6960119/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6960119/
mv kat ../../../../tests/mceliece6960119/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece6960119f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece6960119f/
mv kat ../../../../tests/mceliece6960119f/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece8192128/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece8192128/
mv kat ../../../../tests/mceliece8192128/kat
cd ../../../..

cd Additional_Implementations/kem/mceliece8192128f/vec
echo "moved to: ${PWD}"
./build
mkdir -p ../../../../tests/mceliece8192128f/
mv kat ../../../../tests/mceliece8192128f/kat
cd ../../../..
