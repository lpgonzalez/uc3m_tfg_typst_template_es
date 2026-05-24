// =====================================================================
//  ACRÓNIMOS Y GLOSARIO
//  ---------------------------------------------------------------------
//  Dos listas independientes:
//   - acronyms       : siglas. key, short (sigla), long (forma desarrollada).
//   - glossary-terms : términos definidos. key, short (término), description.
//
//  Un acrónimo puede tener además su entrada de glosario (p. ej. GUL/UC3M):
//  basta con añadir un término al glosario cuyo `short` coincida con el `long`
//  del acrónimo; entonces, en la lista de «Acrónimos» aparece automáticamente
//  la nota «(véase el glosario)».
//
//  En el texto se citan con #gls("key") (o #glspl para el plural).
// =====================================================================

#let acronyms = (
  (key: "gul", short: "GUL", long: "Grupo de Usuarios de Linux"),
  (key: "so", short: "SO", long: "Sistema Operativo"),
  (key: "uc3m", short: "UC3M", long: "Universidad Carlos III de Madrid"),
)

#let glossary-terms = (
  (
    key: "gul-g",
    short: "Grupo de Usuarios de Linux",
    description: "Asociación de estudiantes con inquietudes en torno a los ordenadores y la informática y, en concreto, con la idea común de utilizar y promover el software libre.",
  ),
  (
    key: "uc3m-g",
    short: "Universidad Carlos III de Madrid",
    description: "Universidad pública española situada en la Comunidad de Madrid.",
  ),
  (
    key: "swlibre",
    short: "Software libre",
    description: "Software que respeta la libertad de las personas usuarias para ejecutarlo, copiarlo, estudiarlo, modificarlo y redistribuirlo.",
  ),
)
