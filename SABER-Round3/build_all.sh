MAKEOPTION=$1;

cd Reference_Implementation_KEM
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-