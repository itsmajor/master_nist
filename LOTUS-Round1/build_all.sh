MAKEOPTION=$1;

cd Optimized_Implementation/encrypt
echo "moved to: ${PWD}"
make SEC=128 PQCgenKAT_encrypt $MAKEOPTION
make SEC=192 PQCgenKAT_encrypt $MAKEOPTION
make SEC=256 PQCgenKAT_encrypt $MAKEOPTION
cd ../..

cd Optimized_Implementation/kem
echo "moved to: ${PWD}"
make SEC=128 $MAKEOPTION
make SEC=192 $MAKEOPTION
make SEC=256 $MAKEOPTION
cd ../..

