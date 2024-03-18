cd tests

echo "test newhope512cca"
./PQCgenKAT_kem_newhope512cca
echo "test newhope512cpa"
./PQCgenKAT_kem_newhope512cpa
echo "test newhope1024cca"
./PQCgenKAT_kem_newhope1024cca
echo "test newhope1024cpa"
./PQCgenKAT_kem_newhope1024cpa

cd ..
