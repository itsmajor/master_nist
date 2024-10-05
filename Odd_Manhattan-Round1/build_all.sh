MAKEOPTION=$1;

sec_array=(128 192 256)

for sec in "${sec_array[@]}"; do
  cd Optimized_Implementation/$sec
  echo "moved to: ${PWD}"
  make $MAKEOPTION
  cd ~-
done
