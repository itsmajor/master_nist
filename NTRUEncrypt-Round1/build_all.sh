mkdir -p NTRUEncrypt-Round1/Reference_Implementation/tests

cd NTRUEncrypt-Round1/Reference_Implementation/ntru-kem-1024
echo "moved to: ${PWD}"
make
mv ntru-kem-1024 ../tests
cd ../../..

cd NTRUEncrypt-Round1/Reference_Implementation/ntru-kem-443
echo "moved to: ${PWD}"
make
mv ntru-kem-443 ../tests
cd ../../..

cd NTRUEncrypt-Round1/Reference_Implementation/ntru-kem-743
echo "moved to: ${PWD}"
make
mv ntru-kem-743 ../tests
cd ../../..

cd NTRUEncrypt-Round1/Reference_Implementation/ntru-pke-1024
echo "moved to: ${PWD}"
make
mv ntru-pke-1024 ../tests
cd ../../..

cd NTRUEncrypt-Round1/Reference_Implementation/ntru-pke-443
echo "moved to: ${PWD}"
make
mv ntru-pke-443 ../tests
cd ../../..

cd NTRUEncrypt-Round1/Reference_Implementation/ntru-pke-743
echo "moved to: ${PWD}"
make
mv ntru-pke-743 ../tests
cd ../../..

