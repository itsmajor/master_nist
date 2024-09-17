doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEncDec=$3;

if [ ! $# -eq 3 ];
then
  echo "3 parameter expected for valgrind control (doValgrindFull, doValgrindKeygen, doValgrindEncDec)"
  echo "set 1 to be executed, 0 to skip it"
  echo "example: $ ./test_all.sh 0 1 0   --> will do only valgrind keygen"
  echo "example: $ ./test_all.sh 0 1 1   --> will do valgrind keygen, encoding and decoding"
  echo "example: $ ./test_all.sh 0 0 0   --> no valgrind"
  exit
fi

name=lotus128_encrypt
baseDir=Optimized_Implementation/encrypt/lotus128
leaveBaseDir=../../..

mkdir -p ../testresult
mkdir -p ../testresult/$name
rm ../testresult/$name/* 2> /dev/null

cd $baseDir
echo "test" $name
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./PQCgenKAT_encrypt
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_encrypt done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEncDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi
mv PQCkemKAT.req $leaveBaseDir/../testresult/$name
mv PQCkemKAT*.rsp $leaveBaseDir/../testresult/$name
mv massif.* $leaveBaseDir/../testresult/$name/ 2> /dev/null
cd $leaveBaseDir

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $name



name=lotus192_encrypt
baseDir=Optimized_Implementation/encrypt/lotus192

mkdir -p ../testresult/$name
rm ../testresult/$name/* 2> /dev/null

cd $baseDir
echo "test" $name
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./PQCgenKAT_encrypt
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_encrypt done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEncDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi
mv PQCkemKAT.req $leaveBaseDir/../testresult/$name
mv PQCkemKAT*.rsp $leaveBaseDir/../testresult/$name
mv massif.* $leaveBaseDir/../testresult/$name/ 2> /dev/null
cd $leaveBaseDir

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $name



name=lotus256_encrypt
baseDir=Optimized_Implementation/encrypt/lotus256

mkdir -p ../testresult/$name
rm ../testresult/$name/* 2> /dev/null

cd $baseDir
echo "test" $name
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./PQCgenKAT_encrypt
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_encrypt done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEncDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_encrypt_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_encrypt_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi
mv PQCkemKAT.req $leaveBaseDir/../testresult/$name
mv PQCkemKAT*.rsp $leaveBaseDir/../testresult/$name
mv massif.* $leaveBaseDir/../testresult/$name/ 2> /dev/null
cd $leaveBaseDir

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $name




name=lotus128_kem
baseDir=Optimized_Implementation/kem/lotus128

mkdir -p ../testresult/$name
rm ../testresult/$name/* 2> /dev/null

cd $baseDir
echo "test" $name
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./PQCgenKAT_kem
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_kem done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_kem
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_kem
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_kem_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_kem_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEncDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_kem_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_kem_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_kem_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_kem_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi
mv PQCkemKAT.req $leaveBaseDir/../testresult/$name
mv PQCkemKAT*.rsp $leaveBaseDir/../testresult/$name
mv massif.* $leaveBaseDir/../testresult/$name/ 2> /dev/null
cd $leaveBaseDir

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $name



name=lotus192_kem
baseDir=Optimized_Implementation/kem/lotus192

mkdir -p ../testresult/$name
rm ../testresult/$name/* 2> /dev/null

cd $baseDir
echo "test" $name
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./PQCgenKAT_kem
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_kem done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_kem
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_kem
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_kem_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_kem_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEncDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_kem_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_kem_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_kem_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_kem_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi
mv PQCkemKAT.req $leaveBaseDir/../testresult/$name
mv PQCkemKAT*.rsp $leaveBaseDir/../testresult/$name
mv massif.* $leaveBaseDir/../testresult/$name/ 2> /dev/null
cd $leaveBaseDir

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $name


name=lotus256_kem
baseDir=Optimized_Implementation/kem/lotus256

mkdir -p ../testresult/$name
rm ../testresult/$name/* 2> /dev/null

cd $baseDir
echo "test" $name
echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - start
./PQCgenKAT_kem
echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - PQCgenKAT_kem done
if [ $doValgrindFull == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.full.heap --heap=yes --stacks=no ./PQCgenKAT_kem
  valgrind -q --tool=massif --massif-out-file=massif.out.full.stack --heap=no --stacks=yes ./PQCgenKAT_kem
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind full done
fi
if [ $doValgrindKeygen == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.heap --heap=yes --stacks=no ./PQCgenKAT_kem_keygen
  valgrind -q --tool=massif --massif-out-file=massif.out.keygen.stack --heap=no --stacks=yes ./PQCgenKAT_kem_keygen
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind keygen done
fi
if [ $doValgrindEncDec == "1" ]; then
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.heap --heap=yes --stacks=no ./PQCgenKAT_kem_enc
  valgrind -q --tool=massif --massif-out-file=massif.out.enc.stack --heap=no --stacks=yes ./PQCgenKAT_kem_enc
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind enc done
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.heap --heap=yes --stacks=no ./PQCgenKAT_kem_dec
  valgrind -q --tool=massif --massif-out-file=massif.out.dec.stack --heap=no --stacks=yes ./PQCgenKAT_kem_dec
  echo `date +'%d.%m.%Y %H:%M:%S.%3N'` - valgrind dec done
fi
mv PQCkemKAT.req $leaveBaseDir/../testresult/$name
mv PQCkemKAT*.rsp $leaveBaseDir/../testresult/$name
mv massif.* $leaveBaseDir/../testresult/$name/ 2> /dev/null
cd $leaveBaseDir

echo $(date +'%d.%m.%Y %H:%M:%S.%3N') - end
echo "done" $name

