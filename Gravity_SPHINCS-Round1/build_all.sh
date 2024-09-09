MAKEOPTION=$1;

cd Reference_Implementation
echo "moved to: ${PWD}"
make bench
cd ..