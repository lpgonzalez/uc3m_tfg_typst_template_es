# uc3m_tfg_typst_template_es

[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-yellow)](LICENSE)
[![Última versión](https://img.shields.io/github/v/release/lpgonzalez/uc3m_tfg_typst_template_es)](https://github.com/lpgonzalez/uc3m_tfg_typst_template_es/releases)
[![Hecho con Typst](https://img.shields.io/badge/Hecho%20con-Typst-239DAD)](https://typst.app/)

Plantilla en [Typst](https://typst.app/) para los **Trabajos de Fin de Grado
(TFG)** de la Universidad Carlos III de Madrid (UC3M). Versión en español. La
versión en inglés está disponible en
[uc3m_tfg_typst_template_en](https://github.com/lpgonzalez/uc3m_tfg_typst_template_en).

Es una **réplica fiel** de la
[plantilla en LaTeX](https://github.com/lpgonzalez/uc3m_tfg_latex_template_es):
mismo formato (papel A4, márgenes de 2,5 cm superior/inferior y 3 cm
izquierdo/derecho, interlineado ~1,15), misma portada oficial, mismos capítulos
y ejemplos, declaración de uso de IA generativa, y salida **PDF/A-2b** lista para
el depósito en e-Archivo. Si prefieres LaTeX, usa el repositorio enlazado; si
buscas una sintaxis más sencilla y compilación instantánea, esta es tu opción.

---

## Requisitos

- **[Typst](https://github.com/typst/typst) 0.13 o posterior** (desarrollada y
  validada con 0.14.2). Una sola herramienta; no hace falta instalar nada más.
- Las **tipografías van incluidas** en `fonts/` (TeX Gyre Heros, TeX Gyre Cursor
  y OpenMoji), así que no tienes que instalarlas en el sistema.
- Los paquetes que usa (`mitex`, `glossarium`, `subpar`) se descargan solos de
  [Typst Universe](https://typst.app/universe/) la primera vez que compilas (con
  conexión a internet); después quedan en la caché local.
- *Opcional:* [Python](https://www.python.org/) con
  [PyMuPDF](https://pymupdf.readthedocs.io/) (`pip install -r tools/requirements.txt`)
  solo si quieres ejecutar `tools/polish.py` (ver más abajo).

---

## Cómo compilar

### En local (recomendado)

Con Typst instalado, desde la carpeta del proyecto:

```bash
# PDF normal mientras trabajas
typst compile --font-path fonts main.typ

# Recompila al guardar (previsualización en vivo)
typst watch --font-path fonts main.typ

# PDF/A-2b para la entrega final (ver la sección de PDF/A)
typst compile --pdf-standard a-2b --font-path fonts main.typ
```

`--font-path fonts` le dice a Typst que use las tipografías incrustadas de la
plantilla. El resultado es `main.pdf`.

### En VS Code (extensión Tinymist)

Instala la extensión **Tinymist Typst** y abre la carpeta. El fichero
`.vscode/settings.json` ya incluye `"tinymist.fontPaths": ["fonts"]`, así que la
previsualización usa las fuentes correctas sin configurar nada. Abre `main.typ`
y pulsa el botón de previsualización.

### En typst.app (web)

Crea un proyecto y **sube la carpeta completa, incluida `fonts/`**. La app
detecta las fuentes del proyecto automáticamente. La exportación a PDF/A desde la
interfaz web es limitada; para el fichero final usa la línea de comandos local.

---

## Estructura del proyecto

```
main.typ                Documento principal (solo orquestación)
config.typ              Tus datos: título, autor, tutor, licencia, IA, etc.

lib/
  tfg-uc3m.typ          Estilo: maquetación, fuentes, portada, página apaisada
  ai-declaration.typ    Anexo de declaración de uso de IA generativa

others/
  acks.typ              Agradecimientos / dedicatoria
  resumen.typ           Resumen (español)
  abstract.typ          Abstract (inglés) - exigido por la UC3M
  glossary.typ          Entradas del glosario y de los acrónimos

chapters/
  00_examples.typ       Capítulo de demostración (se oculta con show-demo)
  01_introduction.typ
  02_soa.typ            Estado del arte
  03_method.typ
  04_validation.typ
  05_resultsanddiscussion.typ
  06_projectmanagement.typ
  07_conclusions.typ
  08_futurelines.typ
  09_annexes.typ

bibliography/
  bibliography.bib      Tus referencias (formato BibTeX)

fonts/                  Tipografías incrustadas (Heros, Cursor, OpenMoji)
images/
  coverpage/            Logotipos de la UC3M y de la licencia
  examples/             Imágenes usadas por el capítulo de demostración

tools/
  polish.py             Retoque opcional del PDF (marcadores + metadatos)
  template_info.json    Metadatos de la plantilla (versión/procedencia)
```

---

## Cómo personalizarla

Casi todo lo que editas como alumno está en **`config.typ`**:

1. **Tus datos:** el diccionario `info` (título, autor, tutor, titulación, curso
   académico, lugar y fecha, palabras clave). Alimentan también la portada y los
   metadatos del PDF.
2. **Licencia:** el campo `license` admite `"cc"` (Creative Commons, recomendada)
   o `"reserved"` (todos los derechos reservados).
3. **Declaración de IA:** el diccionario `ai` (si usaste IAG, respuestas de la
   Parte 1, tu declaración técnica y tu reflexión). Pon `show-explanations` a
   `false` para ocultar las ayudas en la versión final.
4. **Capítulo de demostración:** pon `show-demo` a `false` antes de entregar (es
   solo contenido de ejemplo); puedes borrar también `chapters/00_examples.typ`.

El resto:

5. **Contenido:** escribe cada capítulo en `chapters/` (vienen con un esqueleto
   de secciones y comentarios-guía propios de una memoria de TFG) y los
   resúmenes en `others/`.
6. **Glosario y acrónimos:** define las entradas en `others/glossary.typ` y
   úsalas con `#gls("clave")`.
7. **Bibliografía:** añade tus referencias a `bibliography/bibliography.bib`. El
   estilo de citas (IEEE por defecto) se cambia en `main.typ`, en la llamada a
   `bibliography(..., style: "ieee")` (admite también `"apa"`, etc.).
8. **Tipografía y colores:** se definen una sola vez en `lib/tfg-uc3m.typ`.

---

## Salida PDF/A para depósito (e-Archivo)

El repositorio de la UC3M (e-Archivo) solicita un fichero PDF/A, un formato de
preservación a largo plazo con fuentes y metadatos incrustados. Para generarlo:

1. Pon `show-demo` a `false` y `ai.show-explanations` a `false` en `config.typ`,
   y escribe tu contenido real.
2. Compila con el estándar PDF/A activado:

   ```bash
   typst compile --pdf-standard a-2b --font-path fonts main.typ
   ```

3. *(Opcional)* Ejecuta el retoque de marcadores y metadatos:

   ```bash
   python tools/polish.py
   ```

4. Valida el resultado con [veraPDF](https://verapdf.org) o Adobe Preflight antes
   de entregar.

Usamos el nivel **A-2b** (no el más estricto A-1b) porque admite la transparencia
presente en los logotipos SVG. Todas las fuentes (incluidos los emojis) se
incrustan, por lo que el PDF es portable y se ve igual en cualquier visor.

### Retoque opcional con `tools/polish.py`

Typst genera un PDF/A-2b válido por sí solo. El script `tools/polish.py` (que usa
PyMuPDF) añade, mediante una **actualización incremental que conserva la validez
PDF/A**, tres detalles que Typst todavía no controla de forma nativa y que la
versión LaTeX sí ofrece:

- **(a)** abrir el documento mostrando el panel de marcadores (`PageMode`);
- **(b)** marcadores **sin** el número de capítulo/sección al principio;
- **(c)** propiedades personalizadas **`Template.*`** en los metadatos del PDF
  (URL, Author, Contributors, Version, Date, Comments), visibles en Adobe →
  Propiedades del documento → *Personalizado*.

Es totalmente **opcional**: si no lo ejecutas, el PDF sigue siendo válido, pero
los marcadores llevarán número y el documento no abrirá el panel automáticamente.
Los valores `Template.*` se editan en `tools/template_info.json` (los actualiza
quien mantiene la plantilla, no el alumnado en cada TFG).

---

## Notas

- Referencia figuras, tablas, ecuaciones, capítulos, etc. con `@etiqueta`
  (p. ej. `@fig:vector`); las etiquetas se ponen con `<fig:vector>`.
- **Resaltado de código:** indica el lenguaje tras las comillas triples
  (`` ```python ``); Typst conoce muchos lenguajes y aplica el color solo.
- **Tablas anchas:** tienes una columna flexible (`1fr`, ajuste de línea
  automático, equivalente a `tabularx`), `scale(..., reflow: true)` (reescalado,
  equivalente a `\resizebox`) y `rotate(-90deg, reflow: true, ...)` (girar una
  tabla en su sitio). Para una **página apaisada** (horizontal), envuelve el
  contenido en `#landscape[ ... ]`. Tienes ejemplos de todo en el capítulo de
  demostración.
- **Matemáticas:** puedes escribir con la sintaxis nativa de Typst (`$ ... $`) o,
  si prefieres LaTeX, con `#mitex(`\frac{...}{...}`)` gracias al paquete *mitex*.
- **Emojis** a color con la fuente vectorial OpenMoji (incrustada en `fonts/`);
  basta con escribir el emoji directamente.
- El capítulo de demostración muestra texto, listas, imágenes (ráster y SVG),
  subfiguras, tablas (todas las variantes), página apaisada, notas al pie,
  código, ecuaciones, emojis, términos del glosario y citas.

---

## Créditos y agradecimientos

Plantilla basada en la plantilla oficial de TFG de la Universidad Carlos III de
Madrid, portada a Typst desde la versión en LaTeX, con influencias de otras
plantillas, desarrollos propios, y sugerencias y mejoras aportadas por antiguos
alumnos, además de diversas optimizaciones.

A todas las alumnas y alumnos —pasados, presentes y futuros— que confiaron,
confían y confiarán en mí como tutor de TFG/TFM, y que me inspiraron para
rescatar, refactorizar y mejorar esta plantilla hasta su estado actual, con el
fin de facilitarles el desarrollo de su trabajo de fin de etapa. Gracias también
a la comunidad de Typst por su soporte y a quienes crearon Typst.

---

## Licencia

Esta plantilla se distribuye bajo la licencia **MIT** (ver [LICENSE](LICENSE)):
puedes usarla, modificarla y redistribuirla libremente, incluido tu propio TFG.
