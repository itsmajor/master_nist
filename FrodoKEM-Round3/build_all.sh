mkdir -p tests

cd Optimized_Implementation/optimized/FrodoKEM-640
echo "moved to: ${PWD}"
make
mv frodo/test_KEM ../../../tests/frodo_640
cd ../../..

cd Optimized_Implementation/optimized/FrodoKEM-976
echo "moved to: ${PWD}"
make
mv frodo/test_KEM ../../../tests/frodo_976
cd ../../..

cd Optimized_Implementation/optimized/FrodoKEM-1344
echo "moved to: ${PWD}"
make
mv frodo/test_KEM ../../../tests/frodo_1344
cd ../../..

