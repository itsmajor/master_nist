MAKEOPTION=$1;

cd Reference_Implementation_KEM
echo "moved to: ${PWD}"
make saber2 $MAKEOPTION
make saber3 $MAKEOPTION
make saber4 $MAKEOPTION
cd ~-