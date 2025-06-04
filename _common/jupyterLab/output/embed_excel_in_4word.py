import win32com.client
import os

# --- Konfiguration ---
word_doc_path = r'C:\Workspace\jupyter\output\PQC-empty.docx'
xlsx_paths_file = r'C:\Workspace\jupyter\output\list_all_xlsx_pathes.txt'
excel_prefix = r'C:\Workspace\jupyter\\'
output_base_dir = r'C:\Workspace\jupyter\output'

# --- Excel-Pfade einlesen ---
with open(xlsx_paths_file, 'r', encoding='utf-8') as file:
    excel_paths = [os.path.join(excel_prefix, line.strip()) for line in file.readlines()]

ziel_verzeichnisse = [
    r'output\xlsx\liboqs\mem',
    r'output\xlsx\liboqs\time',
    r'output\xlsx\nist\mem',
    r'output\xlsx\nist\time'
]

# Starte Word einmalig
word = win32com.client.Dispatch("Word.Application")
word.Visible = False

for ziel_verzeichnis in ziel_verzeichnisse:
    print(f'Erstelle Word-Dokument für Pfad: {ziel_verzeichnis}')

    # Filtere relevante Pfade
    filtered_paths = [path for path in excel_paths if ziel_verzeichnis in path]

    # Öffne das Basisdokument
    doc = word.Documents.Open(word_doc_path)

    # Ans Ende des Dokuments gehen und Überschrift einfügen
    word.Selection.EndKey(Unit=6)  # wdStory = 6 (ans Ende springen)
    word.Selection.TypeParagraph()
    word.Selection.Style = doc.Styles("Überschrift 1")
    word.Selection.TypeText(f"Anhänge - {ziel_verzeichnis}")
    word.Selection.TypeParagraph()

    # Excel-Dateien einbetten
    for excel_path in filtered_paths:
        print(f'Verarbeite Excel-Datei: {excel_path}')
        if os.path.exists(excel_path):
            word.Selection.TypeParagraph()
            word.Selection.TypeText(os.path.basename(excel_path))
            word.Selection.TypeParagraph()
            word.Selection.InlineShapes.AddOLEObject(
                ClassType="Excel.Sheet.12",
                FileName=excel_path,
                LinkToFile=True,
                DisplayAsIcon=False,
                IconLabel=os.path.basename(excel_path)
            )
            word.Selection.TypeParagraph()
        else:
            print(f'ACHTUNG: Datei nicht gefunden: {excel_path}')

    # Dokument speichern
    safe_name = ziel_verzeichnis.strip('\\').replace('\\', '_').replace('/', '_')
    output_doc_path = os.path.join(output_base_dir, f'PQC-{safe_name}.docx')
    doc.SaveAs(output_doc_path)
    doc.Close()

# Word schließen
word.Quit()
