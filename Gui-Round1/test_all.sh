cd Optimized_Implementation/amd64/tests/Gui-184
echo "--------------------"
echo "test Gui-184 generate key"
#gui-genkey pk_file_name sk_file_name [random_seed_file]
./gui-genkey pk sk
#gui-sign sk_file_name file_to_be_signed [random_seed_file]
echo "Gui-184 signing"
./gui-sign sk gui-genkey > sig
echo
#gui-verify pk_file_name signature_file_name message_file_name
./gui-verify pk sig gui-genkey
cd ../../../..

cd Optimized_Implementation/amd64/tests/Gui-312
echo "--------------------"
echo "test Gui-312"
./gui-genkey pk sk
echo "Gui-312 signing"
./gui-sign sk gui-genkey > sig
./gui-verify pk sig gui-genkey
cd ../../../..

cd Optimized_Implementation/amd64/tests/Gui-448
echo "--------------------"
echo "test Gui-448"
./gui-genkey pk sk
echo "Gui-448 signing"
./gui-sign sk gui-genkey > sig
./gui-verify pk sig gui-genkey
cd ../../../..