MAKEOPTION=$1;

#cd Optimized_Implementation/128
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ~-
#
#cd Optimized_Implementation/192
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#cd ~-

cd Optimized_Implementation/256
echo "moved to: ${PWD}"
make $MAKEOPTION
cd ~-