import win32com.client
import os
import glob

# --- Konfiguration ---
word_doc_path   = r'C:\Workspace\jupyter\output\PQC-empty.docx'
output_doc_path = r'C:\Workspace\jupyter\output\PQC-all_nist_excel.docx'
xlsx_dir = r'C:\Workspace\jupyter\output\xlsx\nist_scaled'

# --- Excel-Pfade einlesen ---
excel_paths = glob.glob(os.path.join(xlsx_dir, '*.xlsx'))

# NUR ZUM TESTEN: Auf 2 Dateien beschränken
# excel_paths = excel_paths[:5]

# --- Mapping für schönere Beschriftungen ---
caption_mapping = {
    "BIG_QUAKE_1": "BIG QUAKE 1",
    "BIG_QUAKE_3": "BIG QUAKE 3",
    "BIG_QUAKE_5": "BIG QUAKE 5",
    "bike-1_aes": "BIKE 1 AES",
    "bike-1_sha3": "BIKE 1 SHA3",
    "bike-3_aes": "BIKE 3 AES",
    "bike-3_sha3": "BIKE 3 SHA3",
    "bike-5_aes": "BIKE 5 AES",
    "bike-5_sha3": "BIKE 5 SHA3",
    "CRYSTALS-DILITHIUM_mode2_AES": "CRYSTALS-DILITHIUM Mode2 AES",
    "CRYSTALS-DILITHIUM_mode2_SHA": "CRYSTALS-DILITHIUM Mode2 SHA",
    "CRYSTALS-DILITHIUM_mode3_AES": "CRYSTALS-DILITHIUM Mode3 AES",
    "CRYSTALS-DILITHIUM_mode3_SHA": "CRYSTALS-DILITHIUM Mode3 SHA",
    "CRYSTALS-DILITHIUM_mode5_AES": "CRYSTALS-DILITHIUM Mode5 AES",
    "CRYSTALS-DILITHIUM_mode5_SHA": "CRYSTALS-DILITHIUM Mode5 SHA",
    "Ding_LWE": "Ding LWE",
    "EMBLEM-EMBLEM": "EMBLEM",
    "EMBLEM-R_EMBLEM": "R-EMBLEM",
    "Falcon_1024_fpu": "Falcon 1024 FPU",
    "Falcon_512_fpu": "Falcon 512 FPU",
    "FrodoKEM-1344_AES": "FrodoKEM 1344 AES",
    "FrodoKEM-1344_SHAKE": "FrodoKEM 1344 SHAKE",
    "FrodoKEM-640_AES": "FrodoKEM 640 AES",
    "FrodoKEM-640_SHAKE": "FrodoKEM 640 SHAKE",
    "FrodoKEM-976_AES": "FrodoKEM 976 AES",
    "FrodoKEM-976_SHAKE": "FrodoKEM 976 SHAKE",
    "Gravity_SPHINCS_VERSION_S": "Gravity SPHINCS Version S",
    "Gui-184": "Gui 184",
    "hqc-128": "HQC 128",
    "hqc-192": "HQC 192",
    "hqc-256": "HQC 256",
    "KCL-AKCN-MLWE-CCA": "KCL AKCN-MLWE-CCA",
    "KCL-AKCN-MLWE": "KCL AKCN-MLWE",
    "KCL-AKCN-SEC": "KCL AKCN-SEC",
    "KCL-OKCN-MLWE": "KCL OKCN-MLWE",
    "KCL-OKCN-SEC": "KCL OKCN-SEC",
    "KINDI-256-3-4-2_encrypt":  "KINDI 256-3-4-2 Encrypt",
    "KINDI-256-3-4-2_kem":      "KINDI 256-3-4-2 KEM",
    "KINDI-256-5-2-2_encrypt":  "KINDI 256-5-2-2 Encrypt",
    "KINDI-256-5-2-2_kem":      "KINDI 256-5-2-2 KEM",
    "KINDI-512-2-2-2_encrypt":  "KINDI 512-2-2-2 Encrypt",
    "KINDI-512-2-2-2_kem":      "KINDI 512-2-2-2 KEM",
    "KINDI-512-2-4-1_encrypt":  "KINDI 512-2-4-1 Encrypt",
    "KINDI-512-2-4-1_kem":      "KINDI 512-2-4-1 KEM",
    "KINDI-512-3-2-1_encrypt":  "KINDI 512-3-2-1 Encrypt",
    "KINDI-512-3-2-1_kem":      "KINDI 512-3-2-1 KEM",
    "kyber1024-90s": "Kyber 1024 90s",
    "kyber1024": "Kyber 1024",
    "kyber512-90s": "Kyber 512 90s",
    "kyber512": "Kyber 512",
    "kyber768-90s": "Kyber 768 90s",
    "kyber768": "Kyber 768",
    "Lima-EncapCCA_1018": "Lima EncapCCA 1018",
    "Lima-EncapCCA_1024": "Lima EncapCCA 1024",
    "Lima-EncapCCA_1306": "Lima EncapCCA 1306",
    "Lima-EncapCCA_1822": "Lima EncapCCA 1822",
    "Lima-EncapCCA_2048": "Lima EncapCCA 2048",
    "Lima-EncapCCA_2062": "Lima EncapCCA 2062",
    "Lima-EncapCPA_1018": "Lima EncapCPA 1018",
    "Lima-EncapCPA_1024": "Lima EncapCPA 1024",
    "Lima-EncapCPA_1306": "Lima EncapCPA 1306",
    "Lima-EncapCPA_1822": "Lima EncapCPA 1822",
    "Lima-EncapCPA_2048": "Lima EncapCPA 2048",
    "Lima-EncapCPA_2062": "Lima EncapCPA 2062",
    "Lima-EncCCA_1018": "Lima EncCCA 1018",
    "Lima-EncCCA_1024": "Lima EncCCA 1024",
    "Lima-EncCCA_1306": "Lima EncCCA 1306",
    "Lima-EncCCA_1822": "Lima EncCCA 1822",
    "Lima-EncCCA_2048": "Lima EncCCA 2048",
    "Lima-EncCCA_2062": "Lima EncCCA 2062",
    "Lima-EncCPA_1018": "Lima EncCPA 1018",
    "Lima-EncCPA_1024": "Lima EncCPA 1024",
    "Lima-EncCPA_1306": "Lima EncCPA 1306",
    "Lima-EncCPA_1822": "Lima EncCPA 1822",
    "Lima-EncCPA_2048": "Lima EncCPA 2048",
    "Lima-EncCPA_2062": "Lima EncCPA 2062",
    "lotus128_encrypt": "Lotus 128 Encrypt",
    "lotus128_kem": "Lotus 128 KEM",
    "lotus192_encrypt": "Lotus 192 Encrypt",
    "lotus192_kem": "Lotus 192 KEM",
    "lotus256_encrypt": "Lotus 256 Encrypt",
    "lotus256_kem": "Lotus 256 KEM",
    "mceliece348864": "McEliece 348864",
    "mceliece348864f": "McEliece 348864f",
    "mceliece460896": "McEliece 460896",
    "mceliece460896f": "McEliece 460896f",
    "mceliece6688128": "McEliece 6688128",
    "mceliece6688128f": "McEliece 6688128f",
    "mceliece6960119": "McEliece 6960119",
    "mceliece6960119f": "McEliece 6960119f",
    "mceliece8192128": "McEliece 8192128",
    "mceliece8192128f": "McEliece 8192128f",
    "newhope1024cca": "NewHope 1024 CCA",
    "newhope1024cpa": "NewHope 1024 CPA",
    "newhope512cca": "NewHope 512 CCA",
    "newhope512cpa": "NewHope 512 CPA",
    "NTRU-Prime-ntrulpr1013": "NTRU-Prime ntrulpr1013",
    "NTRU-Prime-ntrulpr1277": "NTRU-Prime ntrulpr1277",
    "NTRU-Prime-ntrulpr653": "NTRU-Prime ntrulpr653",
    "NTRU-Prime-ntrulpr761": "NTRU-Prime ntrulpr761",
    "NTRU-Prime-ntrulpr857": "NTRU-Prime ntrulpr857",
    "NTRU-Prime-ntrulpr953": "NTRU-Prime ntrulpr953",
    "NTRU-Prime-sntrup1013": "NTRU-Prime sntrup1013",
    "NTRU-Prime-sntrup1277": "NTRU-Prime sntrup1277",
    "NTRU-Prime-sntrup653": "NTRU-Prime sntrup653",
    "NTRU-Prime-sntrup761": "NTRU-Prime sntrup761",
    "NTRU-Prime-sntrup857": "NTRU-Prime sntrup857",
    "NTRU-Prime-sntrup953": "NTRU-Prime sntrup953",
    "NTRU-Round3-ntruhps2048509": "NTRU-Round3 ntruhps2048509",
    "NTRU-Round3-ntruhps2048677": "NTRU-Round3 ntruhps2048677",
    "NTRU-Round3-ntruhps4096821": "NTRU-Round3 ntruhps4096821",
    "NTRU-Round3-ntruhrss701": "NTRU-Round3 ntruhrss701",
    "NTRUEncrypt-ntru-kem-443": "NTRUEncrypt ntru-kem-443",
    "NTRUEncrypt-ntru-kem-743": "NTRUEncrypt ntru-kem-743",
    "NTRU_HRSS_KEM": "NTRU HRSS KEM",
    "Odd_Manhattan_128": "Odd Manhattan 128",
    "Odd_Manhattan_192": "Odd Manhattan 192",
    "Odd_Manhattan_256": "Odd Manhattan 256",
    "Picnic_3l1_neon": "Picnic 3l1 Neon",
    "Picnic_3l1_OI": "Picnic 3l1 OI",
    "Picnic_3l3_neon": "Picnic 3l3 Neon",
    "Picnic_3l3_OI": "Picnic 3l3 OI",
    "Picnic_3l5_neon": "Picnic 3l5 Neon",
    "Picnic_3l5_OI": "Picnic 3l5 OI",
    "Picnic_l1fs_neon": "Picnic l1fs Neon",
    "Picnic_l1fs_OI": "Picnic l1fs OI",
    "Picnic_l1full_neon": "Picnic l1full Neon",
    "Picnic_l1full_OI": "Picnic l1full OI",
    "Picnic_l1ur_neon": "Picnic l1ur Neon",
    "Picnic_l1ur_OI": "Picnic l1ur OI",
    "Picnic_l3fs_neon": "Picnic l3fs Neon",
    "Picnic_l3fs_OI": "Picnic l3fs OI",
    "Picnic_l3full_neon": "Picnic l3full Neon",
    "Picnic_l3full_OI": "Picnic l3full OI",
    "Picnic_l3ur_neon": "Picnic l3ur Neon",
    "Picnic_l3ur_OI": "Picnic l3ur OI",
    "Picnic_l5fs_neon": "Picnic l5fs Neon",
    "Picnic_l5fs_OI": "Picnic l5fs OI",
    "Picnic_l5full_neon": "Picnic l5full Neon",
    "Picnic_l5full_OI": "Picnic l5full OI",
    "Picnic_l5ur_neon": "Picnic l5ur Neon",
    "Picnic_l5ur_OI": "Picnic l5ur OI",
    "pqNTRUSign-Gaussian-1024": "pqNTRUSign Gaussian 1024",
    "pqNTRUSign-Uniform-1024": "pqNTRUSign Uniform 1024",
    "SABER": "SABER",
    "sphincs-haraka-128f-robust": "SPHINCS Haraka 128f Robust",
    "sphincs-haraka-128f-simple": "SPHINCS Haraka 128f Simple",
    "sphincs-haraka-128s-robust": "SPHINCS Haraka 128s Robust",
    "sphincs-haraka-128s-simple": "SPHINCS Haraka 128s Simple",
    "sphincs-haraka-192f-robust": "SPHINCS Haraka 192f Robust",
    "sphincs-haraka-192f-simple": "SPHINCS Haraka 192f Simple",
    "sphincs-haraka-192s-robust": "SPHINCS Haraka 192s Robust",
    "sphincs-haraka-192s-simple": "SPHINCS Haraka 192s Simple",
    "sphincs-haraka-256f-robust": "SPHINCS Haraka 256f Robust",
    "sphincs-haraka-256f-simple": "SPHINCS Haraka 256f Simple",
    "sphincs-haraka-256s-robust": "SPHINCS Haraka 256s Robust",
    "sphincs-haraka-256s-simple": "SPHINCS Haraka 256s Simple",
    "sphincs-sha256-128f-robust": "SPHINCS SHA256 128f Robust",
    "sphincs-sha256-128f-simple": "SPHINCS SHA256 128f Simple",
    "sphincs-sha256-128s-robust": "SPHINCS SHA256 128s Robust",
    "sphincs-sha256-128s-simple": "SPHINCS SHA256 128s Simple",
    "sphincs-sha256-192f-robust": "SPHINCS SHA256 192f Robust",
    "sphincs-sha256-192f-simple": "SPHINCS SHA256 192f Simple",
    "sphincs-sha256-192s-robust": "SPHINCS SHA256 192s Robust",
    "sphincs-sha256-192s-simple": "SPHINCS SHA256 192s Simple",
    "sphincs-sha256-256f-robust": "SPHINCS SHA256 256f Robust",
    "sphincs-sha256-256f-simple": "SPHINCS SHA256 256f Simple",
    "sphincs-sha256-256s-robust": "SPHINCS SHA256 256s Robust",
    "sphincs-sha256-256s-simple": "SPHINCS SHA256 256s Simple",
    "sphincs-shake256-128f-robust": "SPHINCS SHAKE256 128f Robust",
    "sphincs-shake256-128f-simple": "SPHINCS SHAKE256 128f Simple",
    "sphincs-shake256-128s-robust": "SPHINCS SHAKE256 128s Robust",
    "sphincs-shake256-128s-simple": "SPHINCS SHAKE256 128s Simple",
    "sphincs-shake256-192f-robust": "SPHINCS SHAKE256 192f Robust",
    "sphincs-shake256-192f-simple": "SPHINCS SHAKE256 192f Simple",
    "sphincs-shake256-192s-robust": "SPHINCS SHAKE256 192s Robust",
    "sphincs-shake256-192s-simple": "SPHINCS SHAKE256 192s Simple",
    "sphincs-shake256-256f-robust": "SPHINCS SHAKE256 256f Robust",
    "sphincs-shake256-256f-simple": "SPHINCS SHAKE256 256f Simple",
    "sphincs-shake256-256s-robust": "SPHINCS SHAKE256 256s Robust",
    "sphincs-shake256-256s-simple": "SPHINCS SHAKE256 256s Simple",
    "ThreeBears_Low_Memory_BabyBear": "ThreeBears Low Memory BabyBear",
    "ThreeBears_Low_Memory_BabyBearEphem": "ThreeBears Low Memory BabyBearEphem",
    "ThreeBears_Low_Memory_MamaBear": "ThreeBears Low Memory MamaBear",
    "ThreeBears_Low_Memory_MamaBearEphem": "ThreeBears Low Memory MamaBearEphem",
    "ThreeBears_Low_Memory_PapaBear": "ThreeBears Low Memory PapaBear",
    "ThreeBears_Low_Memory_PapaBearEphem": "ThreeBears Low Memory PapaBearEphem",
    "ThreeBears_OI_BabyBear": "ThreeBears OI BabyBear",
    "ThreeBears_OI_BabyBearEphem": "ThreeBears OI BabyBearEphem",
    "ThreeBears_OI_MamaBear": "ThreeBears OI MamaBear",
    "ThreeBears_OI_MamaBearEphem": "ThreeBears OI MamaBearEphem",
    "ThreeBears_OI_PapaBear": "ThreeBears OI PapaBear",
    "ThreeBears_OI_PapaBearEphem": "ThreeBears OI PapaBearEphem",
    "ThreeBears_With_Asm_BabyBear": "ThreeBears With Asm BabyBear",
    "ThreeBears_With_Asm_BabyBearEphem": "ThreeBears With Asm BabyBearEphem",
    "ThreeBears_With_Asm_MamaBear": "ThreeBears With Asm MamaBear",
    "ThreeBears_With_Asm_MamaBearEphem": "ThreeBears With Asm MamaBearEphem",
    "ThreeBears_With_Asm_PapaBear": "ThreeBears With Asm PapaBear",
    "ThreeBears_With_Asm_PapaBearEphem": "ThreeBears With Asm PapaBearEphem",
}

# --- Word starten ---
word = win32com.client.Dispatch("Word.Application")
word.Visible = False

doc = word.Documents.Open(word_doc_path)

# --- Alle Excel-Dateien einfügen ---
word.Selection.EndKey(Unit=6)  # wdStory = 6

for excel_path in excel_paths:
    print(f'Verarbeite Excel-Datei: {excel_path}')
    if os.path.exists(excel_path):
        filename = os.path.basename(excel_path).replace('.xlsx', '')

        # Beschriftung aus Mapping holen oder Standard verwenden
        caption_text = caption_mapping.get(filename, filename)

        # Beschriftung hinzufügen
        word.Selection.TypeParagraph()
        caption_range = word.Selection.Range
        word.Selection.InsertCaption(
            Label="Tabelle",
            Title=f": {caption_text}",
            Position=1  # wdCaptionPositionAbove
        )
        caption_end = caption_range.End
        word.Selection.MoveLeft(Unit=1, Count=len(caption_text) + 2, Extend=1)  # +2 für ": "
        word.Selection.Font.Bold = True
        word.Selection.Collapse(0)
        word.Selection.TypeParagraph()

        # Excel-Tabelle einfügen
        word.Selection.Style = doc.Styles("FHCW_DA_Text_Zentriert")
        shape = word.Selection.InlineShapes.AddOLEObject(
            ClassType="Excel.Sheet.12",
            FileName=excel_path,
            LinkToFile=True,
            DisplayAsIcon=False,
            IconLabel=filename
        )

    else:
        print(f'ACHTUNG: Datei nicht gefunden: {excel_path}')

# --- Speichern und schließen ---
doc.SaveAs(output_doc_path)
doc.Close()
word.Quit()
