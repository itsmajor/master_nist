mkdir -p tests

cd Optimized_Implementation/falcon512/falcon512fpu
echo "moved to: ${PWD}"
make
mv kat512fpu ../../../tests/
cd ../../..

cd Optimized_Implementation/falcon1024/falcon1024fpu
echo "moved to: ${PWD}"
make
mv kat1024fpu ../../../tests/
cd ../../..

cd Extra/c
echo "moved to: ${PWD}"
make
mv speed ../../tests/
mv test_falcon ../../tests/
cd ../..

