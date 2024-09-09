MAKEOPTION=$1;

cd Optimized_Implementation/falcon512/falcon512fpu
echo "moved to: ${PWD}"
make $MAKEOPTION
mv build/kat512fpu ../../../tests/
cd ../../..

cd Optimized_Implementation/falcon1024/falcon1024fpu
echo "moved to: ${PWD}"
make $MAKEOPTION
mv build/kat1024fpu ../../../tests/
cd ../../..

cd Extra/c
echo "moved to: ${PWD}"
make $MAKEOPTION
mv speed ../../tests/
mv test_falcon ../../tests/
cd ../..

