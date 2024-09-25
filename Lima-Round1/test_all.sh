doValgrindFull=$1;
doValgrindKeygen=$2;
doValgrindEnc=$3;
doValgrindDec=$4;

if [ ! $# -eq 4 ];
then
  ../_common/script/doKat.sh explain4param
  exit
fi

if [ $doValgrindFull -eq 9 ];
then
  ./build_all.sh
fi

VALGRIND="$doValgrindFull $doValgrindKeygen $doValgrindEnc $doValgrindDec"

###############################  6x EncapCCA    ###################################

CIPHER="kem Lima-EncapCCA_1018"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCCA/1018
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCCA_1024"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCCA/1024
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCCA_1306"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCCA/1306
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCCA_1822"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCCA/1822
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCCA_2048"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCCA/2048
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCCA_2062"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCCA/2062
../_common/script/doVerifyKat.sh $CIPHER


################################  6x EncapCPA    ###################################

CIPHER="kem Lima-EncapCPA_1018"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCPA/1018
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCPA_1024"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCPA/1024
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCPA_1306"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCPA/1306
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCPA_1822"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCPA/1822
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCPA_2048"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCPA/2048
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="kem Lima-EncapCPA_2062"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncapCPA/2062
../_common/script/doVerifyKat.sh $CIPHER


################################  6x EncCCA    ###################################

CIPHER="encrypt Lima-EncCCA_1018"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCCA/1018
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCCA_1024"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCCA/1024
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCCA_1306"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCCA/1306
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCCA_1822"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCCA/1822
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCCA_2048"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCCA/2048
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCCA_2062"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCCA/2062
../_common/script/doVerifyKat.sh $CIPHER


###############################  6x EncCPA    ###################################

CIPHER="encrypt Lima-EncCPA_1018"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCPA/1018
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCPA_1024"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCPA/1024
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCPA_1306"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCPA/1306
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCPA_1822"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCPA/1822
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCPA_2048"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCPA/2048
../_common/script/doVerifyKat.sh $CIPHER

CIPHER="encrypt Lima-EncCPA_2062"
../_common/script/doKat.sh $VALGRIND $CIPHER bin/EncCPA/2062
../_common/script/doVerifyKat.sh $CIPHER