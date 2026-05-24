// =====================================================================
//  DECLARACIÓN DE USO DE IA GENERATIVA (IAG)  — anexo obligatorio UC3M
//  ---------------------------------------------------------------------
//  Réplica del modelo oficial. La ayuda (en verde) y la guía de la Parte 2
//  se muestran solo si show-explanations es true; ponlo a false para la
//  versión final lista para entregar.
// =====================================================================

#let ai-selected-bg = rgb("#FFE066")   // opción seleccionada
#let ai-fill-bg = rgb("#D7E9FF")       // valores que rellenas
#let ai-hint-color = rgb("#1A7F5A")    // texto de ayuda

// Resalta un valor escrito por el alumno.
#let ai-fill(body) = highlight(fill: ai-fill-bg, body)

// Caja con marco a ancho completo para escribir.
#let ai-box(body, height: 2cm) = block(
  width: 100%, height: height, stroke: 0.5pt, inset: 6pt, above: 0.8em, below: 0.8em,
  breakable: false,   // no partir la caja entre páginas
  body,
)

// Casillas dibujadas (renderizan en cualquier fuente).
#let mark-on = box(baseline: 0.15em, width: 0.85em, height: 0.85em, stroke: 0.6pt, inset: 0.5pt, align(center + horizon, text(size: 0.75em, sym.checkmark)))
#let mark-off = box(baseline: 0.15em, width: 0.85em, height: 0.85em, stroke: 0.6pt)

// Celdas SÍ/NO: la opción elegida lleva casilla marcada, fondo y negrita.
#let ai-yes-cell(val, body) = if val {
  table.cell(fill: ai-selected-bg)[#mark-on #strong(body)]
} else {
  table.cell[#mark-off #body]
}
#let ai-no-cell(val, body) = if val {
  table.cell[#mark-off #body]
} else {
  table.cell(fill: ai-selected-bg)[#mark-on #strong(body)]
}

// ---------------------------------------------------------------------
//  Declaración completa.
//  IMPORTANTE: los valores reales se pasan desde el diccionario `ai` de
//  main.typ. Edita allí (no estos valores por defecto, que se sobrescriben).
// ---------------------------------------------------------------------
#let ai-declaration(
  show-explanations: true,
  used: true,
  confidential-data: false,
  copyrighted-material: false,
  personal-data: false,
  terms-respected: true,
  system-name: "ChatGPT 4o",
  decl-purpose: "buscar información",
  decl-prompt: "Escribe aquí el prompt que utilizaste",
  decl-interaction: "describe qué hiciste con la respuesta de la IA",
  reflection: "Escribe aquí tu valoración personal.",
) = {
  // Ayuda (verde, cursiva) como bloque propio, separada del resto del contenido.
  let hint = body => if show-explanations { block(above: 0.9em, below: 0.9em, text(fill: ai-hint-color, style: "italic", body)) }
  let qtable(yes, no) = table(columns: (1fr, 1fr), stroke: 0.5pt, inset: 6pt, yes, no)

  // Título corto para el marcador y el índice; el nombre oficial completo va
  // como subtítulo en la página.
  heading(numbering: none)[Declaración de uso de IAG]

  block(below: 1em, text(size: 13pt, weight: "bold")[Declaración de uso de Inteligencia Artificial Generativa (IAG) en el Trabajo de Fin de Grado (TFG)])

  [*He usado IAG en mi TFG*]

  hint[Marca lo que corresponda:]

  align(center, table(
    columns: (3.5cm, 3.5cm), stroke: 0.5pt, inset: 6pt, align: center,
    ai-yes-cell(used, [SÍ]), ai-no-cell(used, [NO]),
  ))

  if used {
    hint[Si has marcado SÍ, completa las siguientes 3 partes de este documento.]

    // ============== PARTE 1 ==============
    heading(level: 2, numbering: none)[Parte 1: declaración sobre comportamiento legal, ético y responsable]

    [Ten presente que el uso de IAG conlleva unos riesgos y puede generar una serie de consecuencias académicas graves: la evaluación de tu TFG puede verse comprometida si el uso de la IAG comporta la utilización de datos de carácter confidencial, materiales protegidos por derechos de autoría, o datos de carácter personal, y se hace sin cumplir las condiciones exigidas en cada caso (autorización de los interesados, autorización de los titulares, seguimiento de las instrucciones de la Universidad).]

    [*Pregunta 1.* En mi interacción con herramientas de IAG he facilitado *datos de carácter confidencial* contando siempre con la debida autorización de los interesados. La confidencialidad abarca toda información que una persona u organización desea proteger por razones legales, comerciales, de privacidad o estratégicas (como patentes o secretos comerciales).]
    qtable(
      ai-yes-cell(confidential-data, [SÍ, he usado estos datos con la autorización de los interesados]),
      ai-no-cell(confidential-data, [NO, no he usado datos de carácter confidencial]),
    )

    [*Pregunta 2.* En mi interacción con herramientas de IAG he facilitado *materiales protegidos por derechos de autoría* contando siempre con la autorización de los respectivos titulares.]
    qtable(
      ai-yes-cell(copyrighted-material, [SÍ, he usado estos materiales con autorización de los titulares; o bien sin ella porque se ajustan a una excepción legal: obra en dominio público; obra con licencia (p. ej. Creative Commons); o uso de fragmentos con fines de investigación (derecho de cita).]),
      ai-no-cell(copyrighted-material, [NO, no he usado materiales protegidos por derechos de autoría]),
    )

    [*Pregunta 3.* En mi interacción con herramientas de IAG he facilitado *datos de carácter personal* con la debida autorización de los interesados.]
    qtable(
      ai-yes-cell(personal-data, [SÍ, he usado estos datos con autorización de los interesados y conforme a las instrucciones de la guía aprobada por la Universidad]),
      ai-no-cell(personal-data, [NO, no he usado datos de carácter personal]),
    )

    [*Pregunta 4.* Mi utilización de la herramienta de IAG ha *respetado sus términos de uso*, así como los principios éticos esenciales, no orientándola de manera maliciosa a obtener un resultado inapropiado para el trabajo presentado.]
    qtable(
      ai-yes-cell(terms-respected, [SÍ]),
      ai-no-cell(terms-respected, [NO]),
    )

    // ============== PARTE 2 ==============
    heading(level: 2, numbering: none)[Parte 2: declaración de uso técnico]

    hint[Utiliza el siguiente modelo de declaración tantas veces como sea necesario, a fin de reflejar todos los tipos de interacción que has tenido con herramientas de IAG. Incluye un ejemplo por cada tipo de uso realizado.]

    hint[Algunos usos habituales — documentación y redacción: soporte a la reflexión (análisis de alternativas y enfoques); revisión o reescritura de párrafos; búsqueda de información; búsqueda y resumen de bibliografía; traducción de textos. Desarrollar contenido específico: asistencia con líneas de código; generación de esquemas/imágenes/audios/vídeos (indícalo además en una nota al pie del elemento); procesos de optimización; tratamiento de datos; inspiración de ideas en el proceso creativo.]

    hint[En cada caso puedes añadir *el prompt* (la petición a la IAG) y *la interacción* (qué hiciste tras la respuesta). Ejemplo: «Declaro haber hecho uso del sistema de IAG ChatGPT 3.5 para buscar información empleando el prompt: "Dime un ejemplo que ilustre la Ciudad de los 15 minutos en España" teniendo como interacción la inclusión del ejemplo del distrito de Chamartín en la memoria».]

    [*Mi declaración:*]
    ai-box(height: 2.5cm)[*Declaro* haber hecho uso del sistema de IAG #ai-fill(system-name) para #ai-fill(decl-purpose) empleando *el prompt:* "#ai-fill(decl-prompt)" teniendo como interacción #ai-fill(decl-interaction).]

    // ============== PARTE 3 ==============
    heading(level: 2, numbering: none)[Parte 3: reflexión sobre utilidad]

    hint[Aporta una valoración personal (formato libre) sobre las fortalezas y debilidades que has identificado al usar IAG, y si te ha servido en el aprendizaje, el desarrollo o las conclusiones del trabajo.]

    ai-box(height: 5cm, reflection)
  } else {
    [No he hecho uso de herramientas de IAG en mi TFG, por lo que no procede completar las partes 1, 2 y 3 de esta declaración.]
  }
}
