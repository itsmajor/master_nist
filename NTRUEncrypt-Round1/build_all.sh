MAKEOPTION=$1;


cd Reference_Implementation/ntru-kem-443
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-

cd Reference_Implementation/ntru-kem-743
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-

# fails in origin
#cd Reference_Implementation/ntru-kem-1024
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ~-

# fails when CT read from file, decrypt does not work
#cd Reference_Implementation/ntru-pke-443
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ~-

# fails when CT read from file, decrypt does not work
#cd Reference_Implementation/ntru-pke-743
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ~-

# fails in origin
#cd Reference_Implementation/ntru-pke-1024
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ~-
