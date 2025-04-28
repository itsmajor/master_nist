MAKEOPTION=$1;

mode_array=(1 3 5)
hash_array=('AES' 'SHA3')
cd Reference_Implementation
echo "moved to: ${PWD}"
for hash in "${hash_array[@]}"; do
  for mode in "${mode_array[@]}"; do
    make MODE=$mode HASH=$hash $MAKEOPTION
  done
done
cd ~-