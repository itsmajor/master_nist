MAKEOPTION=$1;

mkdir -p tests

cd Additional_Implementation/hqc-128
echo "moved to: ${PWD}"
make folders
make hqc-128
mv bin/hqc-128 ../../tests/hqc-128
cd ../..

cd Additional_Implementation/hqc-192
echo "moved to: ${PWD}"
make folders
make hqc-192
mv bin/hqc-192 ../../tests/hqc-192
cd ../..

cd Additional_Implementation/hqc-256
echo "moved to: ${PWD}"
make folders
make hqc-256
mv bin/hqc-256 ../../tests/hqc-256
cd ../..
