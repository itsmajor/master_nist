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


# *****************    here we start Optimized_Implementation      **************************

name=ThreeBears_OI_BabyBear
baseDir=Optimized_Implementation/crypto_kem/BabyBear
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



name=ThreeBears_OI_BabyBearEphem
baseDir=Optimized_Implementation/crypto_kem/BabyBearEphem

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



name=ThreeBears_OI_MamaBear
baseDir=Optimized_Implementation/crypto_kem/MamaBear

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



name=ThreeBears_OI_MamaBearEphem
baseDir=Optimized_Implementation/crypto_kem/MamaBearEphem

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



name=ThreeBears_OI_PapaBear
baseDir=Optimized_Implementation/crypto_kem/PapaBear

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



name=ThreeBears_OI_PapaBearEphem
baseDir=Optimized_Implementation/crypto_kem/PapaBearEphem

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


# *****************    here we start Additional_Implementations - Low_Memory    **************************


name=ThreeBears_Low_Memory_BabyBear
baseDir=Additional_Implementations/Low_Memory/crypto_kem/BabyBear
leaveBaseDir=../../../..

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



name=ThreeBears_Low_Memory_BabyBearEphem
baseDir=Additional_Implementations/Low_Memory/crypto_kem/BabyBearEphem

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


name=ThreeBears_Low_Memory_MamaBear
baseDir=Additional_Implementations/Low_Memory/crypto_kem/MamaBear

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



name=ThreeBears_Low_Memory_MamaBearEphem
baseDir=Additional_Implementations/Low_Memory/crypto_kem/MamaBearEphem

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



name=ThreeBears_Low_Memory_PapaBear
baseDir=Additional_Implementations/Low_Memory/crypto_kem/PapaBear

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



name=ThreeBears_Low_Memory_PapaBearEphem
baseDir=Additional_Implementations/Low_Memory/crypto_kem/PapaBearEphem

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


# *****************    here we start Additional_Implementations - With_Asm    **************************


name=ThreeBears_With_Asm_BabyBear
baseDir=Additional_Implementations/With_Asm/crypto_kem/BabyBear

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



name=ThreeBears_With_Asm_BabyBearEphem
baseDir=Additional_Implementations/With_Asm/crypto_kem/BabyBearEphem

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


name=ThreeBears_With_Asm_MamaBear
baseDir=Additional_Implementations/With_Asm/crypto_kem/MamaBear

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



name=ThreeBears_With_Asm_MamaBearEphem
baseDir=Additional_Implementations/With_Asm/crypto_kem/MamaBearEphem

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



name=ThreeBears_With_Asm_PapaBear
baseDir=Additional_Implementations/With_Asm/crypto_kem/PapaBear

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



name=ThreeBears_With_Asm_PapaBearEphem
baseDir=Additional_Implementations/With_Asm/crypto_kem/PapaBearEphem

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

