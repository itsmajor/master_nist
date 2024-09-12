MAKEOPTION=$1;

mkdir -p tests

cd Reference_Implementation_KEM
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ..