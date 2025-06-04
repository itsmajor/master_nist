import win32com.client
import os
import glob

# --- Konfiguration ---
word_doc_path   = r'C:\Workspace\jupyter\output\PQC-empty.docx'
output_doc_path = r'C:\Workspace\jupyter\output\PQC-all_liboqs_excel.docx'
xlsx_dir = r'C:\Workspace\jupyter\output\xlsx\liboqs_scaled'

# --- Excel-Pfade einlesen ---
excel_paths = glob.glob(os.path.join(xlsx_dir, '*.xlsx'))

# NUR ZUM TESTEN: Auf 3 Dateien beschränken
#excel_paths = excel_paths[:2]

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

        # Dateiname als Überschrift (Ebene4 ohne Nummer)
        word.Selection.TypeParagraph()
        word.Selection.Style = doc.Styles("FHCW_DA_Ebene4_OhneNr")
        word.Selection.TypeText(filename)
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
