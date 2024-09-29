MAKEOPTION=$1;

cd Reference_Implementation/Gaussian-1024
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-

cd Reference_Implementation/Uniform-1024
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-