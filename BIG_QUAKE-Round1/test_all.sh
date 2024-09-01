mkdir -p testresult
mkdir -p testresult/BIG_QUAKE_1
mkdir -p testresult/BIG_QUAKE_3
mkdir -p testresult/BIG_QUAKE_5
rm testresult/BIG_QUAKE_1/* 2> /dev/null
rm testresult/BIG_QUAKE_3/* 2> /dev/null
rm testresult/BIG_QUAKE_5/* 2> /dev/null

cd Optimized_Implementation/BIG_QUAKE_1
echo "test BIG_QUAKE_1"
date +'%d.%m.%Y %H:%M:%S.%3N'
#valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_kem
#valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_kem
#echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
#valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_kem_keygen
#valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_kem_keygen
#echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
./PQCgenKAT_kem
cp PQCkemKAT.req ../../testresult/BIG_QUAKE_1/
cp PQCkemKAT*.rsp ../../testresult/BIG_QUAKE_1/
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_kem done
valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_kem_enc
valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_kem_enc
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_kem_dec
valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_kem_dec
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
mv massif.* ../../testresult/BIG_QUAKE_1/
cd ../..

cd Optimized_Implementation/BIG_QUAKE_3
echo "test BIG_QUAKE_3"
date +'%d.%m.%Y %H:%M:%S.%3N'
#valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_kem
#valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_kem
#echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
#valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_kem_keygen
#valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_kem_keygen
#echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
./PQCgenKAT_kem
cp PQCkemKAT.req ../../testresult/BIG_QUAKE_3/
cp PQCkemKAT*.rsp ../../testresult/BIG_QUAKE_3/
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_kem done
valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_kem_enc
valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_kem_enc
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_kem_dec
valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_kem_dec
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
mv massif.* ../../testresult/BIG_QUAKE_3/
cd ../..

cd Optimized_Implementation/BIG_QUAKE_5
echo "test BIG_QUAKE_5"
date +'%d.%m.%Y %H:%M:%S.%3N'
#valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_kem
#valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_kem
#echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
#valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_kem_keygen
#valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_kem_keygen
#echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
./PQCgenKAT_kem
cp PQCkemKAT.req ../../testresult/BIG_QUAKE_5/
cp PQCkemKAT*.rsp ../../testresult/BIG_QUAKE_5/
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_kem done
valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_kem_enc
valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_kem_enc
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_kem_dec
valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_kem_dec
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
mv massif.* ../../testresult/BIG_QUAKE_5/
cd ../..

echo "done BIG_QUAKE"
date +'%d.%m.%Y %H:%M:%S.%3N'