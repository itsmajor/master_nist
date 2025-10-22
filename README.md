# Masterarbeit: Umsetzbarkeit von Post-Quanten-Kryptographie auf Embedded Systemen

Dieses Repository ist Teil der Masterarbeit:

**"Umsetzbarkeit von Post-Quanten-Kryptographie auf Embedded Systemen"**  
Hochschule Campus Wien – Masterstudiengang IT-Security

Dieses Repository enthält die vollständige Testumgebung für die Evaluation ausgewählter *NIST Post-Quantum Cryptography* (PQC)-Kandidaten.

## Überblick

- **Verfahren:**  
  Alle relevanten Kandidaten der NIST-Standardisierung (Rounds 1–4) sind in eigenen Verzeichnissen enthalten.

- **Tests:**  
  Vollständig automatisierbare Tests für Schlüsselgenerierung, Kapselung/Entkapselung, Verschlüsselung/Entschlüsselung und Signaturerzeugung/Verifikation.

- **Ziel:**  
  Evaluierung von Laufzeit und Speicherverbrauch der Verfahren auf ressourcenbeschränkten Embedded-Plattformen wie Raspberry Pi oder Banana Pi.

## Projektstruktur

- **Verfahrensverzeichnisse** (`BIG_QUAKE-Round1`, `CRYSTALS_Kyber-Round3`, etc.):  
  Originalimplementierungen der ausgewählten NIST-Verfahren.

- **Skripte im Hauptverzeichnis:**
    - `build_all.sh` – Kompiliert alle Verfahren.
    - `start_daemon_test_all.sh` – Startet vollautomatische Langzeittests.
    - `resume_test_all.sh` – Setzt unterbrochene Testläufe fort.
    - `rename_testresult.sh` – Organisiert Testergebnisse.
    - `test_all.sh`, `test_longrunning.sh` – Steuerung der Tests.
    - Weitere Hilfsskripte für spezielle Testmodi (Signaturen, Verschlüsselung).

- **Verzeichnis `_common`:**  
  Gemeinsame Dateien und Hilfsfunktionen für alle Tests.

## Branches

- **master:** Generische Version, vorbereitet für 64-Bit-Plattformen.
- **generic32:** Angepasste Version für 32-Bit-Systeme (Banana Pi, ältere Raspberry Pi Modelle).

> Ein Mergen der beiden Branches ist nicht vorgesehen, da spezifische Compiler- und Plattformanpassungen erforderlich sind.

## Nutzung

### 1. Vorbereitung

Pakete installieren (auf Debian/Ubuntu-Systemen):

```bash
sudo apt install astyle cmake gcc ninja-build libssl-dev python3-pytest \
                 python3-pytest-xdist unzip xsltproc doxygen graphviz python3-yaml valgrind
```

### 2. Kompilieren

```bash
./build_all.sh
```

### 3. Testlauf starten

```bash
./start_daemon_test_all.sh
```

Ergebnisse werden in automatisch erzeugte `testresult_*`-Verzeichnisse geschrieben.

### 4. Laufende Tests verwalten

- Testlauf pausiert?  → `./resume_test_all.sh`
- Testresultate verschieben und sichern  → `./rename_testresult.sh`

### 5. Einzeltests durchführen

- Nur Verschlüsselung/Entschlüsselung: `./test_encrypt.sh`
- Nur Signaturverfahren: `./test_sign.sh`
- Ausgewählte Verfahren gezielt testen: `./test_some.sh`

## Ergebnisse

- Ergebnisdaten werden als Logdateien und CSV-Tabellen gespeichert.
- Die weitere Analyse erfolgt über externe Jupyter-Notebooks (siehe _common/jupyterLab). 

## Hinweise

- Die getesteten Implementierungen sind originalgetreu (übernommen aus offiziellen NIST-Einreichungen oder deren optimierten Varianten).
- Anpassungen erfolgten nur zur Portierung und Testbarkeit (Makefiles, Hardwarekompatibilität).
- Keine Änderungen der kryptographischen Verfahren selbst.
- Dieses Repository ist für akademische Zwecke erstellt worden. 

## Lizenz

MIT License

Copyright (c) 2025 Tomas Antal

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Source Acknowledgment

All folders in this repository represent cryptographic schemes submitted to the NIST Post-Quantum Cryptography Standardization Process. The naming of each folder includes an indicator of the corresponding round (`Round1`, `Round2`, `Round3`, `Round4`).

For more information about each round, refer to the official NIST documentation:
- [Round 1](https://csrc.nist.gov/Projects/post-quantum-cryptography/post-quantum-cryptography-standardization/round-1-submissions)
- [Round 2](https://csrc.nist.gov/Projects/post-quantum-cryptography/post-quantum-cryptography-standardization/round-2-submissions)
- [Round 3](https://csrc.nist.gov/Projects/post-quantum-cryptography/post-quantum-cryptography-standardization/round-3-submissions)
- [Round 4](https://csrc.nist.gov/Projects/post-quantum-cryptography/round-4-submissions)

The scripts in the `_common/liboqs` directory are adapted from the [Open Quantum Safe (liboqs) repository](https://github.com/open-quantum-safe/liboqs). To execute them properly, a local clone of the `liboqs` repository is required.
