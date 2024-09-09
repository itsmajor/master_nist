MAKEOPTION=$1;

cd Optimized_Implementation/EMBLEM_OPT
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..

cd Optimized_Implementation/R_EMBLEM_OPT
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..