MAKEOPTION=$1;

cd Optimized_Implementation/BIG_QUAKE_1
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..

cd Optimized_Implementation/BIG_QUAKE_3
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..

cd Optimized_Implementation/BIG_QUAKE_5
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..
