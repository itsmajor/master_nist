MAKEOPTION=$1;

cd Reference_Implementation/crypto_sign/dilithium
echo "moved to: ${PWD}"

mode_array=(2 3 5)
hash_array=('AES' 'SHA')
for hash in "${hash_array[@]}"; do
  for mode in "${mode_array[@]}"; do
    make MODE=$mode HASH=$hash $MAKEOPTION
  done
done

cd ~-


#cd Reference_Implementation/crypto_sign/dilithium
 #echo "moved to: ${PWD}"
 #make MODE=2 HASH=AES $MAKEOPTION
 #make MODE=3 HASH=AES $MAKEOPTION
 #make MODE=5 HASH=AES $MAKEOPTION
 #make MODE=2 HASH=SHA $MAKEOPTION
 #make MODE=3 HASH=SHA $MAKEOPTION
 #make MODE=5 HASH=SHA $MAKEOPTION
 #cd ~-