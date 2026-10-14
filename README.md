# Doc2MD

**Convert Word, PowerPoint, Excel, PDF and more into a single self-contained Markdown file — optimized for LLMs and online agents.**

[![Python 3.10+](https://img.shields.io/badge/python-3.10%2B-blue.svg)](https://www.python.org/downloads/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform: Windows](https://img.shields.io/badge/platform-Windows-0078D6.svg)](https://www.microsoft.com/windows)

---

## Why?

When you upload a raw `.docx`, `.pptx` or `.pdf` to ChatGPT, Claude, Gemini or any other LLM, the model has to spend a large portion of its context window just parsing the binary format.

A well-structured Markdown file typically uses **60–80 % fewer tokens** for the same content.  
Doc2MD produces a **single, portable `.md` file** with images already embedded as Base64 data URIs, so you can drag-and-drop one file into any chat and the model sees both text and pictures.

---

## Features

- **One-click interactive menu** (`run.bat`) – no need to open a terminal first
- **Single-file or whole-folder conversion** – convert one document or an entire project folder at once
- **Format filter** – convert only Word, only PDF, only PowerPoint, Excel, or a custom mix
- **Two-stage conversion**
  1. MarkItDown → high-quality text, headings, lists and tables
  2. undoc → extracts every embedded image and embeds it as a Base64 data URI
- **Self-contained output** – the resulting `.md` needs no external image folder
- **Wide format support** – `.docx`, `.pptx`, `.xlsx`, `.pdf` and everything else MarkItDown understands
- **Full Unicode / Persian / Arabic path support** + smart RTL fixes for PDFs
- **Graceful degradation** – if undoc is missing, you still get a clean text-only Markdown
- **Clear progress messages** and SUCCESS / ERROR feedback
- Window stays open after every operation (no sudden close)

---

## Requirements

- Windows 10 or later
- Python 3.10 or newer (make sure “Add Python to PATH” was checked during installation)

---

## Installation (one-click)

1. Download or clone this repository.
2. Double-click **`install.bat`**.
3. Wait until you see `[SUCCESS] Installation finished!`

That’s it. The script upgrades pip and installs:

```text
markitdown[docx,pptx,xlsx,pdf]
undoc
pymupdf
python-bidi
```

---

## Usage

1. Double-click **`run.bat`**.
2. You will see a simple numbered menu:

```text
========================================================
                 Doc2MD  -  Document to Markdown
========================================================

   [1] Convert a single file to Markdown
   [2] Convert a whole folder
   [3] Check prerequisites
   [4] Install / Update prerequisites
   [5] Exit
```

3. Choose **[1]** for one file or **[2]** for a whole folder.
4. For folders you can pick: All formats, only Word, only PowerPoint, only Excel, only PDF, or a custom mix.
5. Each converted `.md` file appears **next to its original** with the same name.

You can also call the converter directly from any terminal:

```bat
REM Single file
python converter.py "C:\Users\Me\Documents\report.docx"

REM Whole folder (all formats)
python converter.py --folder "C:\Users\Me\Projects\MyDocs"

REM Only PDF and Word files
python converter.py --folder "C:\Users\Me\Projects\MyDocs" --ext docx,pdf
```

---

## Project Structure

```text
doc2md/
├── run.bat          ← main interactive menu (double-click this)
├── check.bat        ← prerequisite checker
├── install.bat      ← one-click installer
├── converter.py     ← core conversion logic
├── README.md
└── LICENSE
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `Python is not recognized` | Re-install Python and tick **“Add Python to PATH”**. Or add the Python folder manually to your system PATH. |
| `pip install` fails with permission error | Run the Command Prompt **as Administrator**, or use `python -m pip install --user ...` |
| Persian / Arabic file names look broken | The scripts already set `chcp 65001` (UTF-8). Make sure your Windows console font supports the characters (Consolas or Cascadia Mono work well). |
| Images are missing in the `.md` | undoc could not be installed or the file is not an Office Open XML format (`.docx`/`.pptx`/`.xlsx`). Check with option **[3]**. |
| Persian text broken in PDF | Run install.bat again so `pymupdf` + `python-bidi` are present. Some scanned PDFs still need OCR. |
| MarkItDown returns empty content | The document may be image-only or password-protected. Try opening it in the original application first. |

---

## Contributing

Pull requests are welcome!  
If you add support for a new format or improve image placement (instead of appending at the end), please open an issue first so we can discuss the design.

---

## License

This project is released under the **MIT License**. See [LICENSE](LICENSE) for the full text.
