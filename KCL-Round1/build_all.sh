MAKEOPTION=$1;

#cd Optimized_Implementation/encrypt/AKCN-MLWE-CCA/ref
#echo "moved to: ${PWD}"
#make speed
#cd ../../../..

cd Optimized_Implementation/kem/AKCN-MLWE/ref
echo "moved to: ${PWD}"
make speed
cd ../../../..

cd Optimized_Implementation/kem/AKCN-SEC/ref
echo "moved to: ${PWD}"
make speed
cd ../../../..

cd Optimized_Implementation/kem/OKCN-MLWE/ref
echo "moved to: ${PWD}"
make speed
cd ../../../..

cd Optimized_Implementation/kem/OKCN-SEC/ref
echo "moved to: ${PWD}"
make speed
cd ../../../..





