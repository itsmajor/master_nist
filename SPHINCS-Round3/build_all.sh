MAKEOPTION=$1;

hash_array=('haraka' 'sha256' 'shake256')
sec_array=('128' '192' '256')
letter_array=('f' 's')
variant_array=('robust' 'simple')

for hash in "${hash_array[@]}"; do
  for sec in "${sec_array[@]}"; do
    for letter in "${letter_array[@]}"; do
      for variant in "${variant_array[@]}"; do
        cd Optimized_Implementation/crypto_sign/sphincs-"$hash"-"$sec""$letter"-"$variant"
        echo "moved to: ${PWD}"
        make $MAKEOPTION
        cd ~-
      done
    done
  done
done
