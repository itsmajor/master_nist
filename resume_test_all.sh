#!/bin/bash
# Es wird geprüft, welche Testverfahren (definiert in expected_tests) noch nicht in der Logdatei
# (testresult/verifyresult.log) protokolliert sind, und deren zugehörige Verzeichnisse werden in Form
# eines Resume-Aufrufs angezeigt.

############### achtung ######################
# ist nur für 32 bit gemacht. die liste kommt von banana pi verifyresults.
# müsste für die weiteren tests auf 64 bit erweitert werden.



set -e

if [ -z $@ ]; then
  OPTIONS=-vb
else
  OPTIONS=$@
fi

echo "=== RESUME TEST_ALL RUN  ==="
echo "Prüfe, ob das Verzeichnis 'testresult' existiert..."
if [ ! -d "testresult" ]; then
  echo "-> 'testresult' existiert NICHT. Kein unvollständiger Testlauf. Abbruch."
  exit 0
fi

LOGFILE="testresult/verifyresult.log"
if [ ! -f "$LOGFILE" ]; then
  echo "-> Logdatei $LOGFILE nicht gefunden. Abbruch."
  exit 0
fi

echo "Lese Logdatei: $LOGFILE"
# Lese alle Log-Zeilen in ein Array
mapfile -t log_lines < "$LOGFILE"

# Extrahiere die Namen der abgeschlossenen Testverfahren (angenommen, das Format ist "Testname = ..." )
declare -A completed_tests
for line in "${log_lines[@]}"; do
  test_name=$(echo "$line" | awk -F ' =' '{print $1}' | xargs)
  completed_tests["$test_name"]=1
done

# Hier die intern erwartete Reihenfolge aller Testverfahren.
# Die Reihenfolge orientiert sich an der tatsächlichen Ausführung:
# Zuerst die Tests aus test_all.sh, danach die aus test_longrunning.sh.
expected_tests=(
  "kyber1024" "kyber1024-90s" "kyber512" "kyber512-90s" "kyber768" "kyber768-90s"
  "Falcon_512_fpu" "Falcon_1024_fpu"
  "hqc-128" "hqc-192" "hqc-256"
  "KCL-AKCN-MLWE-CCA" "KCL-AKCN-MLWE" "KCL-AKCN-SEC" "KCL-OKCN-MLWE" "KCL-OKCN-SEC"
  "Lima-EncapCCA_1018" "Lima-EncapCCA_1024" "Lima-EncapCCA_1306" "Lima-EncapCCA_1822" "Lima-EncapCCA_2048" "Lima-EncapCCA_2062"
  "Lima-EncapCPA_1018" "Lima-EncapCPA_1024" "Lima-EncapCPA_1306" "Lima-EncapCPA_1822" "Lima-EncapCPA_2048" "Lima-EncapCPA_2062"
  "Lima-EncCCA_1018" "Lima-EncCCA_1024" "Lima-EncCCA_1306" "Lima-EncCCA_1822" "Lima-EncCCA_2048" "Lima-EncCCA_2062"
  "newhope512cca" "newhope512cpa" "newhope1024cca" "newhope1024cpa"
  "NTRUEncrypt-ntru-kem-443" "NTRUEncrypt-ntru-kem-743"
  "NTRU_HRSS_KEM"
  "NTRU-Prime-ntrulpr653" "NTRU-Prime-ntrulpr761" "NTRU-Prime-ntrulpr857" "NTRU-Prime-ntrulpr953" "NTRU-Prime-ntrulpr1013" "NTRU-Prime-ntrulpr1277"
  "NTRU-Prime-sntrup653" "NTRU-Prime-sntrup761" "NTRU-Prime-sntrup857" "NTRU-Prime-sntrup953" "NTRU-Prime-sntrup1013" "NTRU-Prime-sntrup1277"
  "NTRU-Round3-ntruhrss701" "NTRU-Round3-ntruhps2048509" "NTRU-Round3-ntruhps2048677" "NTRU-Round3-ntruhps4096821"
  "Picnic_3l1_OI" "Picnic_3l3_OI" "Picnic_3l5_OI" "Picnic_l1fs_OI" "Picnic_l1full_OI" "Picnic_l1ur_OI" "Picnic_l3fs_OI" "Picnic_l3full_OI" "Picnic_l3ur_OI" "Picnic_l5fs_OI" "Picnic_l5full_OI" "Picnic_l5ur_OI"
  "pqNTRUSign-Gaussian-1024" "pqNTRUSign-Uniform-1024"
  "SABER"
  # Ende test_all.sh, Beginn test_longrunning.sh:
  "BIG_QUAKE_1" "BIG_QUAKE_3" "BIG_QUAKE_5"
  "mceliece348864" "mceliece348864f" "mceliece460896" "mceliece460896f" "mceliece6688128" "mceliece6688128f" "mceliece6960119" "mceliece6960119f" "mceliece8192128" "mceliece8192128f"
  "EMBLEM-R_EMBLEM" "EMBLEM-EMBLEM"
  "Gravity_SPHINCS_VERSION_S"
  "Gui-Round1"
  "Odd_Manhattan_128" "Odd_Manhattan_192" "Odd_Manhattan_256"
  "sphincs-haraka-128f-robust" "sphincs-haraka-128f-simple" "sphincs-haraka-128s-robust" "sphincs-haraka-128s-simple"
  "sphincs-haraka-192f-robust" "sphincs-haraka-192f-simple" "sphincs-haraka-192s-robust" "sphincs-haraka-192s-simple"
  "sphincs-haraka-256f-robust" "sphincs-haraka-256f-simple" "sphincs-haraka-256s-robust" "sphincs-haraka-256s-simple"
  "sphincs-sha256-128f-robust" "sphincs-sha256-128f-simple" "sphincs-sha256-128s-robust" "sphincs-sha256-128s-simple"
  "sphincs-sha256-192f-robust" "sphincs-sha256-192f-simple" "sphincs-sha256-192s-robust" "sphincs-sha256-192s-simple"
  "sphincs-sha256-256f-robust" "sphincs-sha256-256f-simple" "sphincs-sha256-256s-robust" "sphincs-sha256-256s-simple"
  "sphincs-shake256-128f-robust" "sphincs-shake256-128f-simple" "sphincs-shake256-128s-robust" "sphincs-shake256-128s-simple"
  "sphincs-shake256-192f-robust" "sphincs-shake256-192f-simple" "sphincs-shake256-192s-robust" "sphincs-shake256-192s-simple"
  "sphincs-shake256-256f-robust" "sphincs-shake256-256f-simple" "sphincs-shake256-256s-robust" "sphincs-shake256-256s-simple"
)

# Ermittele fehlende Tests: Falls ein erwarteter Testname nicht in der Logdatei vorkommt, wird er als "fehlend" gewertet.
missing_tests=()
for test in "${expected_tests[@]}"; do
  if [ -z "${completed_tests[$test]}" ]; then
    missing_tests+=( "$test" )
  fi
done

echo "Folgende Testverfahren fehlen in der Logdatei:"
for t in "${missing_tests[@]}"; do
  echo "  - $t"
done

# Mapping von Testverfahren zu Zielverzeichnissen
declare -A map
map["kyber1024"]="CRYSTALS_Kyber-Round3"
map["kyber1024-90s"]="CRYSTALS_Kyber-Round3"
map["kyber512"]="CRYSTALS_Kyber-Round3"
map["kyber512-90s"]="CRYSTALS_Kyber-Round3"
map["kyber768"]="CRYSTALS_Kyber-Round3"
map["kyber768-90s"]="CRYSTALS_Kyber-Round3"
map["Falcon_512_fpu"]="Falcon-Round3"
map["Falcon_1024_fpu"]="Falcon-Round3"
map["hqc-128"]="HQC-Round4"
map["hqc-192"]="HQC-Round4"
map["hqc-256"]="HQC-Round4"
map["KCL-AKCN-MLWE-CCA"]="KCL-Round1"
map["KCL-AKCN-MLWE"]="KCL-Round1"
map["KCL-AKCN-SEC"]="KCL-Round1"
map["KCL-OKCN-MLWE"]="KCL-Round1"
map["KCL-OKCN-SEC"]="KCL-Round1"
map["Lima-EncapCCA_1018"]="Lima-Round1"
map["Lima-EncapCCA_1024"]="Lima-Round1"
map["Lima-EncapCCA_1306"]="Lima-Round1"
map["Lima-EncapCCA_1822"]="Lima-Round1"
map["Lima-EncapCCA_2048"]="Lima-Round1"
map["Lima-EncapCCA_2062"]="Lima-Round1"
map["Lima-EncapCPA_1018"]="Lima-Round1"
map["Lima-EncapCPA_1024"]="Lima-Round1"
map["Lima-EncapCPA_1306"]="Lima-Round1"
map["Lima-EncapCPA_1822"]="Lima-Round1"
map["Lima-EncapCPA_2048"]="Lima-Round1"
map["Lima-EncapCPA_2062"]="Lima-Round1"
map["Lima-EncCCA_1018"]="Lima-Round1"
map["Lima-EncCCA_1024"]="Lima-Round1"
map["Lima-EncCCA_1306"]="Lima-Round1"
map["Lima-EncCCA_1822"]="Lima-Round1"
map["Lima-EncCCA_2048"]="Lima-Round1"
map["Lima-EncCCA_2062"]="Lima-Round1"
map["newhope512cca"]="NewHope-Round2"
map["newhope512cpa"]="NewHope-Round2"
map["newhope1024cca"]="NewHope-Round2"
map["newhope1024cpa"]="NewHope-Round2"
map["NTRUEncrypt-ntru-kem-443"]="NTRUEncrypt-Round1"
map["NTRUEncrypt-ntru-kem-743"]="NTRUEncrypt-Round1"
map["NTRU_HRSS_KEM"]="NTRU_HRSS_KEM-Round1"
map["NTRU-Prime-ntrulpr653"]="NTRU-Prime-Round3"
map["NTRU-Prime-ntrulpr761"]="NTRU-Prime-Round3"
map["NTRU-Prime-ntrulpr857"]="NTRU-Prime-Round3"
map["NTRU-Prime-ntrulpr953"]="NTRU-Prime-Round3"
map["NTRU-Prime-ntrulpr1013"]="NTRU-Prime-Round3"
map["NTRU-Prime-ntrulpr1277"]="NTRU-Prime-Round3"
map["NTRU-Prime-sntrup653"]="NTRU-Prime-Round3"
map["NTRU-Prime-sntrup761"]="NTRU-Prime-Round3"
map["NTRU-Prime-sntrup857"]="NTRU-Prime-Round3"
map["NTRU-Prime-sntrup953"]="NTRU-Prime-Round3"
map["NTRU-Prime-sntrup1013"]="NTRU-Prime-Round3"
map["NTRU-Prime-sntrup1277"]="NTRU-Prime-Round3"
map["NTRU-Round3-ntruhrss701"]="NTRU-Round3"
map["NTRU-Round3-ntruhps2048509"]="NTRU-Round3"
map["NTRU-Round3-ntruhps2048677"]="NTRU-Round3"
map["NTRU-Round3-ntruhps4096821"]="NTRU-Round3"
map["Picnic_3l1_OI"]="Picnic-Round3"
map["Picnic_3l3_OI"]="Picnic-Round3"
map["Picnic_3l5_OI"]="Picnic-Round3"
map["Picnic_l1fs_OI"]="Picnic-Round3"
map["Picnic_l1full_OI"]="Picnic-Round3"
map["Picnic_l1ur_OI"]="Picnic-Round3"
map["Picnic_l3fs_OI"]="Picnic-Round3"
map["Picnic_l3full_OI"]="Picnic-Round3"
map["Picnic_l3ur_OI"]="Picnic-Round3"
map["Picnic_l5fs_OI"]="Picnic-Round3"
map["Picnic_l5full_OI"]="Picnic-Round3"
map["Picnic_l5ur_OI"]="Picnic-Round3"
map["pqNTRUSign-Gaussian-1024"]="pqNTRUSign-Round1"
map["pqNTRUSign-Uniform-1024"]="pqNTRUSign-Round1"
map["SABER"]="SABER-Round3"
map["BIG_QUAKE_1"]="BIG_QUAKE-Round1"
map["BIG_QUAKE_3"]="BIG_QUAKE-Round1"
map["BIG_QUAKE_5"]="BIG_QUAKE-Round1"
map["mceliece348864"]="Classic-McEliece-Round4"
map["mceliece348864f"]="Classic-McEliece-Round4"
map["mceliece460896"]="Classic-McEliece-Round4"
map["mceliece460896f"]="Classic-McEliece-Round4"
map["mceliece6688128"]="Classic-McEliece-Round4"
map["mceliece6688128f"]="Classic-McEliece-Round4"
map["mceliece6960119"]="Classic-McEliece-Round4"
map["mceliece6960119f"]="Classic-McEliece-Round4"
map["mceliece8192128"]="Classic-McEliece-Round4"
map["mceliece8192128f"]="Classic-McEliece-Round4"
map["EMBLEM-R_EMBLEM"]="EMBLEM_R_EMBLEM-Round1"
map["EMBLEM-EMBLEM"]="EMBLEM_R_EMBLEM-Round1"
map["Gravity_SPHINCS_VERSION_S"]="Gravity_SPHINCS-Round1"
map["Gui-Round1"]="Gui-Round1"
map["Odd_Manhattan_128"]="Odd_Manhattan-Round1"
map["Odd_Manhattan_192"]="Odd_Manhattan-Round1"
map["Odd_Manhattan_256"]="Odd_Manhattan-Round1"
map["sphincs-haraka-128f-robust"]="SPHINCS-Round3"
map["sphincs-haraka-128f-simple"]="SPHINCS-Round3"
map["sphincs-haraka-128s-robust"]="SPHINCS-Round3"
map["sphincs-haraka-128s-simple"]="SPHINCS-Round3"
map["sphincs-haraka-192f-robust"]="SPHINCS-Round3"
map["sphincs-haraka-192f-simple"]="SPHINCS-Round3"
map["sphincs-haraka-192s-robust"]="SPHINCS-Round3"
map["sphincs-haraka-192s-simple"]="SPHINCS-Round3"
map["sphincs-haraka-256f-robust"]="SPHINCS-Round3"
map["sphincs-haraka-256f-simple"]="SPHINCS-Round3"
map["sphincs-haraka-256s-robust"]="SPHINCS-Round3"
map["sphincs-haraka-256s-simple"]="SPHINCS-Round3"
map["sphincs-sha256-128f-robust"]="SPHINCS-Round3"
map["sphincs-sha256-128f-simple"]="SPHINCS-Round3"
map["sphincs-sha256-128s-robust"]="SPHINCS-Round3"
map["sphincs-sha256-128s-simple"]="SPHINCS-Round3"
map["sphincs-sha256-192f-robust"]="SPHINCS-Round3"
map["sphincs-sha256-192f-simple"]="SPHINCS-Round3"
map["sphincs-sha256-192s-robust"]="SPHINCS-Round3"
map["sphincs-sha256-192s-simple"]="SPHINCS-Round3"
map["sphincs-sha256-256f-robust"]="SPHINCS-Round3"
map["sphincs-sha256-256f-simple"]="SPHINCS-Round3"
map["sphincs-sha256-256s-robust"]="SPHINCS-Round3"
map["sphincs-sha256-256s-simple"]="SPHINCS-Round3"
map["sphincs-shake256-128f-robust"]="SPHINCS-Round3"
map["sphincs-shake256-128f-simple"]="SPHINCS-Round3"
map["sphincs-shake256-128s-robust"]="SPHINCS-Round3"
map["sphincs-shake256-128s-simple"]="SPHINCS-Round3"
map["sphincs-shake256-192f-robust"]="SPHINCS-Round3"
map["sphincs-shake256-192f-simple"]="SPHINCS-Round3"
map["sphincs-shake256-192s-robust"]="SPHINCS-Round3"
map["sphincs-shake256-192s-simple"]="SPHINCS-Round3"
map["sphincs-shake256-256f-robust"]="SPHINCS-Round3"
map["sphincs-shake256-256f-simple"]="SPHINCS-Round3"
map["sphincs-shake256-256s-robust"]="SPHINCS-Round3"
map["sphincs-shake256-256s-simple"]="SPHINCS-Round3"

# Für alle fehlenden Tests die zugehörigen Verzeichnisse ermitteln
missing_dirs=()
for test in "${missing_tests[@]}"; do
  dir="${map[$test]}"
  if [ -z "$dir" ]; then
    echo "Warnung: Für Test '$test' gibt es keine Zuordnung in der Mapping-Tabelle – wird übersprungen."
    continue
  fi
  missing_dirs+=( "$dir" )
done

# Dubletten in missing_dirs entfernen
readarray -t uniq_dirs < <(printf "%s\n" "${missing_dirs[@]}" | sort -u)

echo ""
echo "Folgende Verzeichnisse werden fortgesetzt:"
for d in "${uniq_dirs[@]}"; do
  echo "  - $d"
done

echo ""
# In jedem Verzeichnis wird (nur im Dry Run) der lokale Aufruf von ./test_all.sh simuliert
for d in "${uniq_dirs[@]}"; do
  if [ ! -d "$d" ]; then
    echo "Warnung: Verzeichnis $d existiert nicht, überspringe."
    continue
  fi
  echo "Wechsle in Verzeichnis: $d"
  cd "$d"
  echo "Starte: ./test_all.sh $OPTIONS"
  ./test_all.sh $OPTIONS
  cd ..
  echo ""
done

echo "Führe abschließend das Umbenenn-Skript aus: ./rename_testresult.sh $OPTIONS"
./rename_testresult.sh $OPTIONS
echo "=== TEST_ALL FORTSETZUNG ENDE ==="
