MAKEOPTION=$1;

sec_array=('3l1' '3l3' '3l5' 'l1fs' 'l1full' 'l1ur' 'l3fs' 'l3full' 'l3ur' 'l5fs' 'l5full' 'l5ur')

for sec in "${sec_array[@]}"; do
  cd Optimized_Implementation/picnic"$sec"
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done


