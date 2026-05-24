# Registro de cambios

Todos los cambios destacables de esta plantilla se documentan en este fichero.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/)
y la plantilla sigue [Versionado Semántico](https://semver.org/lang/es/).

## [1.0.0] - 2026-05-24

Primera versión: **port a [Typst](https://typst.app/)** de la
[plantilla en LaTeX](https://github.com/lpgonzalez/uc3m_tfg_latex_template_es)
de TFG de la UC3M (v2.0.0), como réplica fiel de su aspecto, estructura y
funcionalidad.

### Añadido
- Maquetación equivalente a la versión LaTeX: papel A4 con los márgenes de la
  UC3M, interlineado ~1,15, títulos de capítulo con número grande alineado a la
  derecha, encabezado a dos caras (par/impar) y numeración en cifras romanas para
  los preliminares y arábigas para el cuerpo.
- **Portada oficial** de la UC3M (`lib/tfg-uc3m.typ`) con logotipo, titulación,
  curso, tipo de trabajo, título, autor, tutor y aviso de licencia.
- **Salida PDF/A-2b** para el depósito en e-Archivo con
  `typst compile --pdf-standard a-2b`. Validada con veraPDF.
- **Tipografías incrustadas** en `fonts/` (TeX Gyre Heros, TeX Gyre Cursor y
  OpenMoji), por lo que el PDF es portable y no hay que instalar fuentes.
- **Emojis a color** vectoriales con OpenMoji, válidos en PDF/A.
- **Página apaisada** real (A4 horizontal) con la función `#landscape[ ... ]`.
- **Declaración de uso de IA generativa** (`lib/ai-declaration.typ`) como réplica
  del modelo oficial, con casillas, valores resaltados y ayudas conmutables; los
  datos se rellenan desde el diccionario `ai` de `config.typ`.
- **Configuración centralizada en `config.typ`** (datos del trabajo, licencia,
  interruptor `show-demo` y declaración de IA), equivalente a `tfg_vars.tex`.
- **Acrónimos y glosario** como dos secciones separadas (paquete *glossarium*),
  con referencias cruzadas y números de página de retorno.
- **Resaltado de código** por lenguaje, con caja y numeración de líneas.
- **Matemáticas híbridas:** sintaxis nativa de Typst y, si se prefiere, sintaxis
  LaTeX mediante el paquete *mitex*.
- Capítulo de demostración (`chapters/00_examples.typ`) amplio: texto, formatos y
  colores, saltos de página y de línea, espaciado, notas al pie, listas anidadas
  y personalizadas, imágenes ráster y SVG, subfiguras con sub-referencias
  (*subpar*), tablas (columna flexible, reescalado y tabla girada), página
  apaisada, código, ecuaciones, emojis, glosario/acrónimos y citas.
- **Esqueleto de secciones y comentarios-guía** en todos los capítulos
  (`chapters/01`–`09`), propios de una memoria de TFG.
- Ejemplos de referencias en `bibliography/bibliography.bib`: artículo, libro y
  recurso en línea (estilo IEEE por defecto).
- **`tools/polish.py`** (opcional, con PyMuPDF): retoque del PDF que conserva la
  validez PDF/A y añade, mediante actualización incremental, el panel de
  marcadores abierto (`PageMode`), marcadores sin numeración y las propiedades
  personalizadas `Template.*` (editables en `tools/template_info.json`).
- **`.vscode/settings.json`** con `tinymist.fontPaths` para que la
  previsualización use las fuentes incrustadas.
- Documentación y comentarios bilingües (español en este repositorio, inglés en
  `uc3m_tfg_typst_template_en`).

### Notas
- Algunos detalles que en LaTeX gestiona `hyperref` (panel de marcadores abierto,
  marcadores sin numeración y propiedades `Template.*`) no son configurables aún
  de forma nativa en Typst; se aplican con el retoque opcional `tools/polish.py`.
  Sin él, el PDF sigue siendo PDF/A-2b válido.
