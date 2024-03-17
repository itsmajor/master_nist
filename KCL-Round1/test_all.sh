cd Optimized_Implementation/encrypt/AKCN-MLWE-CCA/ref
echo "test KCL encrypt AKCN-MLWE-CCA"
./speed
cd ../../../..

cd Optimized_Implementation/kem/AKCN-MLWE/ref
echo "test KCL kem AKCN-MLWE"
./speed
cd ../../../..

cd Optimized_Implementation/kem/AKCN-SEC/ref
echo "test KCL kem AKCN-SEC"
./speed
cd ../../../..

cd Optimized_Implementation/kem/OKCN-MLWE/ref
echo "test KCL kem OKCN-MLWE"
./speed
cd ../../../..

cd Optimized_Implementation/kem/OKCN-SEC/ref
echo "test KCL kem OKCN-SEC"
./speed
cd ../../../..





