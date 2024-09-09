MAKEOPTION=$1;

mkdir -p tests

#cd Reference_Implementation/ntru-kem-1024
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv ntru-kem-1024 ../../tests
#cd ../..

cd Reference_Implementation/ntru-kem-443
echo "moved to: ${PWD}"
make $MAKEOPTION
mv ntru-kem-443 ../../tests
cd ../..

cd Reference_Implementation/ntru-kem-743
echo "moved to: ${PWD}"
make $MAKEOPTION
mv ntru-kem-743 ../../tests
cd ../..

#cd Reference_Implementation/ntru-pke-1024
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv ntru-pke-1024 ../../tests
#cd ../..

cd Reference_Implementation/ntru-pke-443
echo "moved to: ${PWD}"
make $MAKEOPTION
mv ntru-pke-443 ../../tests
cd ../..

cd Reference_Implementation/ntru-pke-743
echo "moved to: ${PWD}"
make $MAKEOPTION
mv ntru-pke-743 ../../tests
cd ../..

