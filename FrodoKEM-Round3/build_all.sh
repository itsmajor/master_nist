MAKEOPTION=$1;

cd Optimized_Implementation/optimized/FrodoKEM-640
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/optimized/FrodoKEM-976
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

cd Optimized_Implementation/optimized/FrodoKEM-1344
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../../..

