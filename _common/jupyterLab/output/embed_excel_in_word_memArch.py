import win32com.client
import os

### das erstellte word wird beim öffnen fragen ob es alle links aktualisieren soll
### ja führt zu out of memory, mit nein geht das word problemlos auf


# --- Konfiguration ---
word_doc_path = r'C:\Workspace\jupyter\output\PQC-empty.docx'
xlsx_paths_file = r'C:\Workspace\jupyter\output\list_all_nist_memArch.txt'
output_doc_path = r'C:\Workspace\jupyter\output\PQC-all_memArch.docx'
excel_prefix = r'C:\Workspace\jupyter\\'

# --- Excel-Pfade einlesen ---
with open(xlsx_paths_file, 'r', encoding='utf-8') as file:
    excel_paths = [os.path.join(excel_prefix, line.strip()) for line in file.readlines()]

# --- Word-Dokument öffnen ---
word = win32com.client.Dispatch("Word.Application")
word.Visible = False  # Zeigt Word während der Verarbeitung an (auf False setzen, wenn nicht gewünscht)

doc = word.Documents.Open(word_doc_path)

# Ans Ende des Dokuments gehen und Überschrift einfügen
word.Selection.EndKey(Unit=6)  # wdStory = 6 (ans Ende springen)
word.Selection.TypeParagraph()
word.Selection.Style = doc.Styles("Überschrift 1")
word.Selection.TypeText("Anhänge")
word.Selection.TypeParagraph()

# Excel-Dateien einbetten
for excel_path in excel_paths:
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
        
# --- Word-Dokument speichern ---
doc.SaveAs(output_doc_path)
doc.Close()
word.Quit()
