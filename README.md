# Masterarbeit: Umsetzbarkeit von Post-Quanten-Kryptographie auf Embedded Systemen

Dieses Repository ist Teil der Masterarbeit:

**"Umsetzbarkeit von Post-Quanten-Kryptographie auf Embedded Systemen"**  
Fachhochschule FH Campus Wien – Masterstudiengang IT-Security

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

## Lizenz

Dieses Repository ist ausschließlich für akademische Zwecke vorgesehen. Eine Weiterverwendung oder Veröffentlichung bedarf der Zustimmung des Autors.
