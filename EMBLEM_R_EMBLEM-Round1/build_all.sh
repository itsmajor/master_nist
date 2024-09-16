MAKEOPTION=$1;

cd KAT/EMBLEM_OPT
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..

cd KAT/R_EMBLEM_OPT
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ../..