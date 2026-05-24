// =====================================================================
//  TRABAJO DE FIN DE GRADO (TFG) DE LA UC3M — DOCUMENTO PRINCIPAL (Typst)
//  ---------------------------------------------------------------------
//  Compilar (PDF normal):  typst compile --font-path fonts main.typ
//  Compilar (PDF/A-2b):    typst compile --pdf-standard a-2b --font-path fonts main.typ
// =====================================================================

// TUS DATOS están en config.typ (edítalos allí).
#import "config.typ": info, show-demo, ai
#import "lib/tfg-uc3m.typ": tfg-uc3m, cover, landscape
#import "@preview/glossarium:0.5.4": make-glossary, register-glossary, print-glossary, get-entry-back-references
#import "others/glossary.typ": acronyms, glossary-terms
#import "lib/ai-declaration.typ": ai-declaration

// --- Aplica la maquetación -------------------------------------------
#show: tfg-uc3m.with(info: info, lang: "es")
#show: make-glossary
#register-glossary(acronyms + glossary-terms)

// =====================================================================
//  PÁGINAS PRELIMINARES (numeración romana)
// =====================================================================
// Cada bloque de preliminares abre en página impar (recto), con su página en
// blanco intencional —como \cleardoublepage—; los índices van seguidos, sin
// blancos entre ellos.
#cover(info)
#set page(numbering: "i")

#pagebreak(to: "odd", weak: true)
#include "others/acks.typ"

#pagebreak(to: "odd", weak: true)
#include "others/resumen.typ"

#pagebreak(to: "odd", weak: true)
#include "others/abstract.typ"

#pagebreak(to: "odd", weak: true)
#outline(title: [Índice general], indent: auto)
#pagebreak(weak: true)
#outline(title: [Índice de figuras], target: figure.where(kind: image))
#pagebreak(weak: true)
#outline(title: [Índice de tablas], target: figure.where(kind: table))

// =====================================================================
//  CUERPO (numeración arábiga desde 1; capítulos en página impar)
// =====================================================================
#pagebreak(to: "odd", weak: true)   // recto donde empieza el cuerpo
#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

#if show-demo { include "chapters/00_examples.typ" }

#include "chapters/01_introduction.typ"
#include "chapters/02_soa.typ"
#include "chapters/03_method.typ"
#include "chapters/04_validation.typ"
#include "chapters/05_resultsanddiscussion.typ"
#include "chapters/06_projectmanagement.typ"
#include "chapters/07_conclusions.typ"
#include "chapters/08_futurelines.typ"

// =====================================================================
//  PÁGINAS FINALES (acrónimos/glosario y bibliografía)
// =====================================================================
#pagebreak(to: "odd", weak: true)
#heading(numbering: none)[Acrónimos]
// Acrónimo: sigla en negrita + ":" + forma desarrollada en normal; si la forma
// desarrollada coincide con un término del glosario, se añade "(véase el glosario)".
#print-glossary(
  acronyms,
  show-all: true,
  user-print-title: entry => {
    strong(entry.short)
    ": "
    entry.long
    // Si el acrónimo tiene entrada de glosario, enlaza a ella.
    let g = glossary-terms.find(g => g.short == entry.long)
    if g != none {
      [ #emph[(#link(label(g.key))[véase el glosario])]]
    }
  },
)

#pagebreak(weak: true)
#heading(numbering: none)[Glosario]
#print-glossary(
  glossary-terms,
  show-all: true,
  user-print-title: entry => strong(entry.short),
  user-print-back-references: entry => {
    // El término de glosario hereda los retroenlaces de su acrónimo (si existe).
    let a = acronyms.find(a => a.long == entry.short)
    let k = if a != none { a.key } else { entry.key }
    get-entry-back-references((key: k)).join(", ")
  },
)

#pagebreak(to: "odd", weak: true)
#bibliography("bibliography/bibliography.bib", style: "ieee", title: [Bibliografía])

// --- Anexos ----------------------------------------------------------
#include "chapters/09_annexes.typ"

// --- Anexo obligatorio: declaración de uso de IAG --------------------
#pagebreak(to: "odd", weak: true)
#ai-declaration(..ai)
