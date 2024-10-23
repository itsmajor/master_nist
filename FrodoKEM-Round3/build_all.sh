MAKEOPTION=$1;

sec_array=(640 976 1344)

for sec in "${sec_array[@]}"; do
  cd Optimized_Implementation/optimized/FrodoKEM-$sec
  echo "moved to: ${PWD}"
  make SEC=$sec MATRIX=AES $MAKEOPTION
  make SEC=$sec MATRIX=SHAKE $MAKEOPTION
  cd ~-
done

