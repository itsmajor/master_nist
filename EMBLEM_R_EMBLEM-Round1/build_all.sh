MAKEOPTION=$1;

cd KAT/EMBLEM
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..

cd KAT/R_EMBLEM
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..