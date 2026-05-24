// =====================================================================
//  CONFIGURACIÓN DEL TFG  —  EDITA AQUÍ TUS DATOS
//  ---------------------------------------------------------------------
//  Este es el fichero que personalizas (equivalente a tfg_vars.tex). Junto
//  con tu contenido en chapters/ y others/, tus referencias en
//  bibliography/bibliography.bib y los términos en others/glossary.typ.
// =====================================================================

// --- Datos del trabajo -----------------------------------------------
#let info = (
  title: "Título de ejemplo del Trabajo de Fin de Grado",
  author: "Nombre Apellido",
  advisor: "Nombre del Tutor o Tutora",
  degree: "Grado en Ingeniería Informática",
  academic-year: "2024-2025",
  thesis-type: "Trabajo de Fin de Grado",
  place-and-date: "Leganés, junio de 2025",
  license: "cc",                       // cc / reserved
  keywords: ("Palabra clave 1", "Palabra clave 2", "Palabra clave 3"),
)

// --- ¿Mostrar el capítulo de demostración? ---------------------------
// Ponlo a false en la versión final (es solo contenido de ejemplo).
#let show-demo = true

// --- Declaración de uso de IA Generativa (anexo obligatorio) ----------
// Pon show-explanations a false para la versión final (sin las ayudas).
#let ai = (
  show-explanations: true,
  used: true,                       // ¿has usado IAG? (true/false)
  confidential-data: false,         // Parte 1, P1
  copyrighted-material: false,      // Parte 1, P2
  personal-data: false,             // Parte 1, P3
  terms-respected: true,            // Parte 1, P4
  system-name: "ChatGPT 4o",
  decl-purpose: "buscar información",
  decl-prompt: "Escribe aquí el prompt que utilizaste",
  decl-interaction: "describe qué hiciste con la respuesta de la IA",
  reflection: "Escribe aquí tu valoración personal (formato libre): fortalezas y debilidades del uso de IAG, y si te ha servido en el aprendizaje, el desarrollo o las conclusiones.",
)
