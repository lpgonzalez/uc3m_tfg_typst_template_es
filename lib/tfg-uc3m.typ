// =====================================================================
//  ESTILO TFG UC3M PARA TYPST  (réplica de tfg_uc3m.sty + tfg_coverpage.sty)
//  ---------------------------------------------------------------------
//  Exporta:
//    - tfg-uc3m(info, lang, body): aplica la maquetación global.
//    - cover(info): construye la portada oficial.
//    - landscape(body): página(s) apaisada(s).
//  Se usa desde main.typ.
// =====================================================================

#let azulUC3M = rgb("#000066")   // azul corporativo UC3M

// ---------------------------------------------------------------------
//  Plantilla principal: #show: tfg-uc3m.with(info: ..., lang: "es")
// ---------------------------------------------------------------------
#let tfg-uc3m(info: (:), lang: "es", body) = {
  set document(
    title: info.at("title", default: ""),
    author: info.at("author", default: ""),
    keywords: info.at("keywords", default: ()),
  )

  // --- Tipografía: TeX Gyre Heros (cuerpo) y Cursor (monoespaciada) ---
  set text(font: "TeX Gyre Heros", size: 12pt, lang: lang)
  set par(justify: true, leading: 0.78em)   // interlineado ~1,15 (ajustable)

  // Emoji a color automáticos con OpenMoji
  show regex("[\u{1F000}-\u{1FAFF}\u{2600}-\u{27BF}\u{2B00}-\u{2BFF}]"): set text(font: "OpenMoji")

  // --- Página A4, márgenes UC3M; encabezado a dos caras (par/impar) ---
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    numbering: "1",
    number-align: center,
    header: context {
      // Sin encabezado en páginas donde abre un título de nivel 1 (capítulo,
      // glosario, bibliografía, preliminares…), como el estilo 'plain' de LaTeX.
      let here-page = here().page()
      if query(heading.where(level: 1)).any(h => h.location().page() == here-page) { return }
      // Capítulo actual (nivel 1 numerado) y sección actual (nivel 2).
      let chap = query(heading.where(level: 1).before(here())).at(-1, default: none)
      if chap == none or chap.numbering == none { return }
      set text(size: 12pt, weight: "bold")
      let chap-no = numbering(chap.numbering, ..counter(heading).at(chap.location()))
      if calc.even(here().page()) {
        // Página par (verso): marca de CAPÍTULO a la izquierda.
        align(left)[#chap-no#h(1em)#chap.body]
      } else {
        // Página impar (recto): marca de SECCIÓN a la derecha.
        let sec = query(heading.where(level: 2).before(here())).at(-1, default: none)
        if sec != none and sec.location().page() >= chap.location().page() {
          let sec-no = numbering(sec.numbering, ..counter(heading).at(sec.location()))
          align(right)[#sec-no#h(1em)#sec.body]
        }
      }
    },
  )

  // --- Títulos (réplica de los titleformat de LaTeX) -----------------
  set heading(numbering: "1.1")
  // Capítulo: número grande (64 pt) + título (32 pt), alineados a la DERECHA;
  // los capítulos numerados abren en página impar (recto), con blanco si hace falta.
  show heading.where(level: 1): it => {
    if it.numbering != none { pagebreak(to: "odd", weak: true) }
    set par(justify: false)
    block(width: 100%, above: 0pt, below: 2cm, {
      set align(right)
      v(4cm)   // el título de capítulo arranca ~1/4 de página, como en LaTeX
      if it.numbering != none {
        // Número grande, con separación respecto al título (como en LaTeX).
        block(below: 0.65cm, text(size: 64pt, weight: "bold")[#context counter(heading).display("1")])
      }
      text(size: 32pt, weight: "bold", it.body)
    })
  }
  show heading.where(level: 2): set text(size: 18pt)
  show heading.where(level: 2): set block(above: 2.2em, below: 1em)
  show heading.where(level: 3): set text(size: 16pt)
  show heading.where(level: 3): set block(above: 1.6em, below: 0.8em)
  show heading.where(level: 4): set text(size: 14pt)
  show heading.where(level: 4): set block(above: 1.4em, below: 0.7em)

  // --- Figuras y tablas: aire alrededor; rótulos pequeños con punto ---
  show figure: set block(above: 1.6em, below: 1.8em)
  show figure.where(kind: image): set figure(supplement: [Figura])
  show figure.where(kind: table): set figure(supplement: [Tabla])
  show figure.where(kind: raw): set figure(supplement: [Código])
  set figure.caption(separator: [. ])        // "Tabla 1. ..." (como labelsep=period)
  show figure.caption: set text(size: 10pt)

  // --- Ecuaciones numeradas: (1), (2), ... ----------------------------
  set math.equation(numbering: "(1)")

  // --- Código fuente: caja, borde y numeración de líneas; pie a la izq. ---
  show raw: set text(font: "TeX Gyre Cursor")
  show raw.where(block: true): it => block(
    width: 100%,
    fill: luma(248),
    stroke: 0.5pt + luma(210),
    radius: 3pt,
    inset: (x: 8pt, y: 8pt),
    breakable: true,
    grid(
      columns: (auto, 1fr),
      column-gutter: 10pt,
      align(right, text(fill: luma(150))[#for l in it.lines [#l.number\ ]]),
      it,
    ),
  )
  show figure.where(kind: raw): set align(left)

  // --- Enlaces visibles en azul ---------------------------------------
  show link: set text(fill: rgb("#0000ee"))

  body
}

// ---------------------------------------------------------------------
//  Aviso de licencia que se imprime al pie de la portada.
// ---------------------------------------------------------------------
#let license-block(license) = align(left, {
  set text(size: 10pt)   // discreto, no debe destacar
  if license == "cc" {
    grid(
      columns: (auto, 1fr),
      column-gutter: 10pt,
      align: horizon,
      image("/images/coverpage/creativecommons_by-nc-nd.eu.svg", height: 0.95cm),
      [Esta obra se encuentra sujeta a la licencia Creative Commons #strong[Reconocimiento - No Comercial - Sin Obra Derivada].],
    )
  } else if license == "reserved" {
    [Todos los derechos reservados.]
  }
})

// ---------------------------------------------------------------------
//  Portada (réplica de \makecover).
// ---------------------------------------------------------------------
#let cover(info) = page(
  numbering: none, header: none, footer: none,
  margin: (x: 2.5cm, top: 2cm, bottom: 1.5cm),
  {
    set align(center)
    {
      set text(fill: azulUC3M)
      image("/images/coverpage/UC3M_logo.svg", width: 16cm)
      v(2.5cm)
      set text(size: 14pt)
      [#info.degree \ Curso académico #info.at("academic-year")]
      v(2cm)
      emph(info.at("thesis-type", default: "Trabajo de Fin de Grado"))
      v(1em)
      text(size: 24pt, weight: "bold", info.title)
      v(0.5cm)
      line(length: 10.5cm, stroke: 0.1mm)
      v(0.9cm)
      text(size: 18pt, info.author)
      v(1cm)
      set text(size: 14pt)
      [Tutor/a \ #info.advisor \ #info.at("place-and-date")]
    }
    v(1fr)
    license-block(info.at("license", default: "cc"))
  },
)

// ---------------------------------------------------------------------
//  Página(s) apaisada(s). Uso:  #landscape[ ...contenido ancho... ]
// ---------------------------------------------------------------------
#let landscape(body) = page(flipped: true, body)
