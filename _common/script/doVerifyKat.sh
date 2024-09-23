KATTYPE=$1;
CIPHERNAME=$2;

PARAMCOUNT=2;

if [ ! $# -eq $PARAMCOUNT ]
then
  echo " $PARAMCOUNT parameter expected"
  echo " verifyKat.h KATTYPE CIPHERNAME "
  echo " example: verifyKat.sh kem kyber1024 "
  exit
fi

# called by doVerifyKat, which is called from project test_all.sh
cd ../_common/verify/
make
./verifyKat $KATTYPE $CIPHERNAME


