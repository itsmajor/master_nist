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



name=ntrulpr653
baseDir=Optimized_Implementation/kem/ntrulpr653
leaveBaseDir=../../..

mkdir -p ../testresult
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



name=ntrulpr761
baseDir=Optimized_Implementation/kem/ntrulpr761

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




name=ntrulpr857
baseDir=Optimized_Implementation/kem/ntrulpr857

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




name=ntrulpr953
baseDir=Optimized_Implementation/kem/ntrulpr953

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




name=ntrulpr1013
baseDir=Optimized_Implementation/kem/ntrulpr1013

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




name=ntrulpr1277
baseDir=Optimized_Implementation/kem/ntrulpr1277

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




name=sntrup653
baseDir=Optimized_Implementation/kem/sntrup653

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




name=sntrup761
baseDir=Optimized_Implementation/kem/sntrup761

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




name=sntrup857
baseDir=Optimized_Implementation/kem/sntrup857

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




name=sntrup953
baseDir=Optimized_Implementation/kem/sntrup953

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




name=sntrup1013
baseDir=Optimized_Implementation/kem/sntrup1013

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




name=sntrup1277
baseDir=Optimized_Implementation/kem/sntrup1277

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
