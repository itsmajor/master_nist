MAKEOPTION=$1;

cd Additional_Implementation/hqc-128/src
echo "moved to: ${PWD}"
make $MAKEOPTION
cd -

cd Additional_Implementation/hqc-192/src
echo "moved to: ${PWD}"
make $MAKEOPTION
cd -

cd Additional_Implementation/hqc-256/src
echo "moved to: ${PWD}"
make $MAKEOPTION
cd -
