KATTYPE=$1;
CIPHERNAME=$2;
DEBUG=$3; #optional

PARAMCOUNT=2;

if [ ! $# -ge $PARAMCOUNT ]
then
  echo " $PARAMCOUNT parameter expected"
  echo " verifyKat.h KATTYPE CIPHERNAME DEBUG"
  echo " example: verifyKat.sh kem kyber1024 0"
  echo " DEBUG 0 disable, 1 enable"
  exit
fi

# for debug sh example check verify_all.sh in BIG_QUAKE

# called by doVerifyKat, which is called from project test_all.sh
cd ../_common/verify/
make
./verifyKat $KATTYPE $CIPHERNAME $DEBUG


