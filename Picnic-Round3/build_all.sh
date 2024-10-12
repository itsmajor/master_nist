MAKEOPTION=$1;

sec_array=('3l1' '3l3' '3l5' 'l1fs' 'l1full' 'l1ur' 'l3fs' 'l3full' 'l3ur' 'l5fs' 'l5full' 'l5ur')

for sec in "${sec_array[@]}"; do
  cd Optimized_Implementation/picnic"$sec"
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done


#mkdir -p tests
#
#cd Additional_Implementations/picnic3l1-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnic3l1-neon
#cd ~-
#
#cd Additional_Implementations/picnic3l3-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnic3l3-neon
#cd ~-
#
#cd Additional_Implementations/picnic3l5-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnic3l5-neon
#cd ~-
#
#cd Additional_Implementations/picnicl1fs-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl1fs-neon
#cd ~-
#
#cd Additional_Implementations/picnicl1full-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl1full-neon
#cd ~-
#
#cd Additional_Implementations/picnicl1ur-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl1ur-neon
#cd ~-
#
#cd Additional_Implementations/picnicl3fs-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl3fs-neon
#cd ~-
#
#cd Additional_Implementations/picnicl3full-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl3full-neon
#cd ~-
#
#cd Additional_Implementations/picnicl3ur-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl3ur-neon
#cd ~-
#
#cd Additional_Implementations/picnicl5fs-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl5fs-neon
#cd ~-
#
#cd Additional_Implementations/picnicl5full-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl5full-neon
#cd ~-
#
#cd Additional_Implementations/picnicl5ur-neon
#echo "moved to: ${PWD}"
#make $MAKEOPTION
#mv tests/picnic_test ../../tests/picnicl5ur-neon
#cd ~-
#
