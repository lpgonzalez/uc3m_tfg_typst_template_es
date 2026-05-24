#!/usr/bin/env python3
# =====================================================================
#  polish.py  —  retoques PDF/A-safe para el PDF generado por Typst
#  ---------------------------------------------------------------------
#  Typst genera un PDF/A-2b válido, pero todavía no controla tres detalles
#  que la plantilla de LaTeX sí ofrece:
#
#    (a) abrir el documento mostrando el panel de marcadores  -> PageMode
#    (b) marcadores SIN el número de capítulo/sección al principio
#    (c) propiedades personalizadas "Template.*" en los metadatos del PDF
#
#  Este script los aplica como un retoque posterior, mediante una
#  actualización INCREMENTAL (no reescribe los objetos existentes), de modo
#  que la validez PDF/A-2b se conserva (las claves Info personalizadas no
#  tienen propiedad XMP análoga, así que están permitidas en PDF/A-2). El
#  título corto del anexo de IA ya se resuelve de forma nativa en
#  lib/ai-declaration.typ, así que aquí no hace falta tocarlo.
#
#  Uso:
#      python tools/polish.py                 # retoca main.pdf in situ
#      python tools/polish.py entrada.pdf     # retoca ese PDF in situ
#      python tools/polish.py entr.pdf sal.pdf
#
#  Requisito:  pip install pymupdf
#  Recompila main.pdf antes de ejecutarlo (la actualización es incremental).
#  Los valores Template.* se editan en tools/template_info.json.
# =====================================================================

import json
import os
import re
import sys
import shutil

try:
    import fitz  # PyMuPDF
except ImportError:
    sys.exit("Falta PyMuPDF. Instálalo con:  pip install -r tools/requirements.txt")

# Fichero con los metadatos de la plantilla (junto a este script).
_INFO_JSON = os.path.join(os.path.dirname(os.path.abspath(__file__)), "template_info.json")


def _pdf_text_string(s: str) -> str:
    """Codifica una cadena como literal hex UTF-16BE con BOM: <FEFF...>.
    Es la forma segura en PDF/A para texto con acentos."""
    return "<FEFF" + s.encode("utf-16-be").hex().upper() + ">"


def _add_template_metadata(doc) -> int:
    """Añade las claves Template.* al diccionario /Info. Devuelve cuántas
    escribió (0 si no hay fichero de metadatos)."""
    if not os.path.exists(_INFO_JSON):
        print(f"  (sin {os.path.basename(_INFO_JSON)}: omito metadatos Template.*)")
        return 0
    with open(_INFO_JSON, encoding="utf-8") as fh:
        data = json.load(fh)

    # Localiza (o crea) el diccionario /Info referenciado desde el tráiler.
    info = doc.xref_get_key(-1, "Info")
    if info[0] == "xref":
        info_xref = int(info[1].split()[0])
    else:
        info_xref = doc.get_new_xref()
        doc.update_object(info_xref, "<<>>")
        doc.xref_set_key(-1, "Info", f"{info_xref} 0 R")

    n = 0
    for key, value in data.items():
        if key.startswith("_") or not str(value):
            continue  # _comment y similares se ignoran
        doc.xref_set_key(info_xref, key, _pdf_text_string(str(value)))
        n += 1
    return n

# Quita la numeración inicial de un título de marcador:
#   "1 Elementos básicos" -> "Elementos básicos"
#   "1.2 Listas"          -> "Listas"
#   "10.1 Anexo A: ..."   -> "Anexo A: ..."
_NUM = re.compile(r"^\d+(\.\d+)*\s+")


def polish(src: str, dst: str) -> None:
    if src != dst:
        shutil.copyfile(src, dst)
    doc = fitz.open(dst)

    # (a) Abrir mostrando el panel de marcadores.
    doc.xref_set_key(doc.pdf_catalog(), "PageMode", "/UseOutlines")

    # (b) Marcadores sin la numeración inicial.
    toc = doc.get_toc()
    for entry in toc:
        entry[1] = _NUM.sub("", entry[1])
    doc.set_toc(toc)

    # (c) Propiedades personalizadas Template.* en /Info.
    n_meta = _add_template_metadata(doc)

    # Guardado INCREMENTAL: conserva los objetos originales y, con ellos, la
    # validez PDF/A-2b (OutputIntent, XMP, etc.).
    doc.save(dst, incremental=True, encryption=fitz.PDF_ENCRYPT_KEEP)
    doc.close()
    print(f"Retocado -> {dst}  (PageMode=UseOutlines, marcadores sin numeración, "
          f"{n_meta} campos Template.*)")


if __name__ == "__main__":
    args = sys.argv[1:]
    src = args[0] if len(args) >= 1 else "main.pdf"
    dst = args[1] if len(args) >= 2 else src
    polish(src, dst)
