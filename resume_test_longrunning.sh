#!/usr/bin/env bash
# test_longrunning.sh - optimiertes Skript mit Schleife und dynamischer Auswahl

# Optionen (Flags) und Test-Verfahren trennen
OPTIONS=()
SELECTED=()

# Alle Argumente durchgehen
while [[ $# -gt 0 ]]; do
  case "$1" in
    -*)  # Optionen beginnen mit '-'
      OPTIONS+=("$1")
      shift
      ;;
    *)   # alles andere sind Test-Verfahren
      SELECTED+=("$1")
      shift
      ;;
  esac
done

# Info-Ausgaben
echo "*** this is longrunning - tests will take hours or even days ***"
if printf "%s" "${OPTIONS[*]}" | grep -q "s"; then
  echo "*** force enabled! no reduced repeats - this will take ages! ***"
fi

# Liste aller verfügbaren Verfahren (Verzeichnisse)
ALL=(
  BIG_QUAKE-Round1
  Classic-McEliece-Round4
  EMBLEM_R_EMBLEM-Round1
  Gravity_SPHINCS-Round1
  Gui-Round1
  Odd_Manhattan-Round1
  SPHINCS-Round3
)

# Wenn keine Verfahren angegeben wurden, alle ausführen
if [[ ${#SELECTED[@]} -eq 0 ]]; then
  RUNLIST=("${ALL[@]}")
else
  # Nur die angegebenen Verfahren, warnen bei Unbekannten
  for name in "${SELECTED[@]}"; do
    if printf "%s\n" "${ALL[@]}" | grep -xq "$name"; then
      RUNLIST+=("$name")
    else
      echo "Warning: Verfahren '$name' nicht gefunden, wird übersprungen."
    fi
  done
fi

# Durch jede Auswahl iterieren
for dir in "${RUNLIST[@]}"; do
  if [[ -d "$dir" ]]; then
    echo "-> Wechsle nach: $dir"
    pushd "$dir" > /dev/null || exit 1
    ./test_all.sh "${OPTIONS[@]}"
    popd > /dev/null
  else
    echo "Verzeichnis '$dir' existiert nicht!"
  fi
done

echo "**** done long running tests ****"
