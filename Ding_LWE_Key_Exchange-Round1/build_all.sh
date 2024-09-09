MAKEOPTION=$1;

cd Optimized_Implementation
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ..