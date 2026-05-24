#import "/lib/tfg-uc3m.typ": landscape, azulUC3M
#import "@preview/mitex:0.2.4": mitex
#import "@preview/glossarium:0.5.4": gls, glspl
#import "@preview/subpar:0.2.2"

= Elementos básicos <ch:basics>

// Capítulo de demostración con las principales funciones de la plantilla.
// Pon `show-demo` a false en config.typ para excluirlo de la versión final.
//
// Los colores como azulUC3M se definen una sola vez en lib/tfg-uc3m.typ, así
// que están disponibles en todo el documento.

== Texto

=== Texto simple

Mi primer documento en Typst. Ejemplo simple sin construcciones adicionales.

=== Formatos para texto simple

Lo más *importante* de este #underline[documento] no es la _cursiva_.
También podemos *_encadenar formatos_*.

=== Colores en el texto

Hola, soy un #text(fill: red)[texto en rojo] y yo un #text(fill: blue)[texto en
azul] y en #text(fill: green)[verde].

== Texto con color personalizado y resaltado

Ahora podemos poner #text(fill: azulUC3M)[UC3M] en el color corporativo y
#highlight[resaltar texto] en amarillo «fosforito».

== Salto de página

El comando `pagebreak()` fuerza el comienzo de una página nueva (lo verás justo
a continuación de esta línea).
#pagebreak()

== Salto de línea

Texto \
otro texto en una línea nueva (con `\` al final de la línea, o `linebreak()`).

== Espaciado personalizado entre líneas de texto

Hola, soy un texto.
#v(1cm)
Y yo soy otro texto con una separación de 1 cm.
#v(50pt)
Y yo soy otro texto más alejado.

== Notas al pie

Las notas al pie se crean con `footnote[...]`#footnote[Esto es una nota al pie;
su numeración es continua en todo el documento. Útil para aclaraciones o
referencias accesorias.].

== Listas simples

Las listas con viñetas son sencillas:
- Las entradas comienzan con un guion (`-`).
- En este tipo de lista cada entrada empieza con una viñeta.
- La longitud de cada entrada es arbitraria.
- Y el número de elementos también lo es.

== Listas enumeradas

Las listas enumeradas también son sencillas:
+ Los elementos se enumeran automáticamente.
+ Los números se generan solos (con `+`).
+ Otra entrada.

=== Sublistas enumeradas

+ Primer nivel.
  + Segundo nivel.
    + Tercer nivel.
    + Tercer nivel.
  + Segundo nivel.
+ Primer nivel.

== Más sublistas

Otro ejemplo de anidamiento, ahora con viñetas:
- Primer nivel.
  - Segundo nivel.
    - Tercer nivel.
    - Tercer nivel.
  - Segundo nivel.
- Primer nivel.

== Listas personalizadas

Una lista de términos permite etiquetar cada entrada a tu gusto:
/ Importante: una entrada etiquetada con una palabra.
/ Nota: otra entrada con su propia etiqueta.
/ Paso 1: las etiquetas pueden ser cualquier texto.

Y puedes cambiar la viñeta de una lista normal con la opción `marker`:
#list(
  marker: box(baseline: 0.1em, square(size: 0.45em, fill: black)),
  [Primer punto con viñeta cuadrada],
  [Segundo punto],
)

== Imágenes

=== Ráster

#figure(
  image("/images/examples/gul_logo_raster.png", height: 7cm),
  caption: [Logo del GUL en formato ráster (PNG)],
) <fig:raster>

La @fig:raster es un mapa de bits.

=== Vectorial (SVG)

#figure(
  image("/images/examples/gul_logo_vector.svg", width: 100%),
  caption: [Logo del GUL en formato vectorial (SVG, nativo en Typst)],
) <fig:vector>

=== Subfiguras

// El paquete subpar coloca varias figuras, cada una con su propio rótulo (a),
// (b)..., dentro de una misma figura, y permite referenciarlas por separado.
#subpar.grid(
  figure(image("/images/examples/gul_logo_raster.png", width: 90%),
    caption: [Primera subfigura]), <fig:sub-a>,
  figure(image("/images/examples/gul_logo_raster.png", width: 90%),
    caption: [Segunda subfigura]), <fig:sub-b>,
  columns: (1fr, 1fr),
  caption: [Figura compuesta por dos subfiguras],
  label: <fig:subfigures>,
)

Puedes referenciar la figura completa (@fig:subfigures) o una subfigura concreta
(@fig:sub-a).

== Tablas y enlaces externos

Recurso recomendado: #link("https://www.tablesgenerator.com/")[Tables generator].

#figure(
  table(
    columns: 3,
    align: center,
    table.header([*Columna A*], [*Columna B*], [*Columna C*]),
    [1], [3], [5],
    [2], [4], [6],
  ),
  caption: [Tabla de ejemplo],
) <tab:example>

Las celdas se pueden combinar con `colspan` y `rowspan`:

#figure(
  table(
    columns: 3,
    align: center + horizon,
    table.cell(colspan: 2)[Columnas combinadas], [Simple],
    table.cell(rowspan: 2)[Filas combinadas], [A], [B],
    [C], [D],
  ),
  caption: [Ejemplo de celdas combinadas],
) <tab:merged>

=== Ajuste de línea automático (columnas flexibles)

// Una columna de ancho flexible (1fr) ajusta su contenido de línea
// automáticamente, ocupando el ancho disponible. Equivale a tabularx de LaTeX.
#figure(
  table(
    columns: (auto, auto, 1fr),
    align: (center, left, left),
    table.header([*ID*], [*Requisito*], [*Descripción*]),
    [RF-01], [Registro],
    [El sistema permitirá registrar usuarios mediante correo y contraseña,
     validando el formato y la unicidad del correo electrónico.],
    [RF-02], [Autenticación],
    [El sistema permitirá iniciar sesión y mantendrá la sesión activa de forma
     segura durante un tiempo configurable.],
  ),
  caption: [Tabla con una columna flexible (`1fr`) que ajusta la línea],
) <tab:flex>

=== Reescalado para que quepa

// scale(..., reflow: true) reduce TODA la tabla de forma uniforme hasta que cabe
// en el ancho del texto. Equivale a \resizebox de LaTeX: tipografía más pequeña
// pero homogénea. Útil para tablas anchas de muchas columnas.
#figure(
  scale(78%, reflow: true, table(
    columns: 13,
    align: center,
    table.header([*Métrica*], [Ene], [Feb], [Mar], [Abr], [May], [Jun], [Jul],
      [Ago], [Sep], [Oct], [Nov], [Dic]),
    [Ingresos], [100], [120], [130], [110], [140], [150], [160], [155], [145], [165], [170], [180],
    [Gastos], [80], [90], [95], [85], [100], [105], [110], [108], [102], [112], [115], [120],
    [Balance], [20], [30], [35], [25], [40], [45], [50], [47], [43], [53], [55], [60],
  )),
  caption: [Tabla ancha reescalada para ajustarse al ancho del texto],
) <tab:resize>

=== Tabla apaisada (contenido girado)

// rotate(..., reflow: true) gira 90° el contenido en su sitio, sin girar la
// página entera (para eso, mira la sección «Página apaisada»). Equivale a
// \rotatebox de LaTeX.
#figure(
  rotate(-90deg, reflow: true, table(
    columns: 6,
    align: (left, center, center, center, center, center),
    table.header([*Criterio*], [*Opción A*], [*Opción B*], [*Opción C*], [*Opción D*], [*Opción E*]),
    [Coste], [Bajo], [Medio], [Alto], [Medio], [Bajo],
    [Rendimiento], [Medio], [Alto], [Alto], [Bajo], [Alto],
    [Soporte], [#sym.checkmark], [#sym.checkmark], [—], [#sym.checkmark], [—],
  )),
  caption: [Tabla con el contenido girado 90° en su sitio],
) <tab:sideways>

== Página apaisada

// Página realmente apaisada (A4 horizontal) con la función landscape (definida
// en lib/tfg-uc3m.typ): vale para tablas, figuras o texto muy anchos, y funciona
// también en PDF/A. El resto del documento permanece en vertical.
Esta sección incluye una página en orientación apaisada (la siguiente), útil para
contenidos muy anchos. El resto del documento permanece en vertical.

#landscape[
  #figure(
    table(
      columns: 9,
      align: center + horizon,
      table.header([*Criterio*], [*A*], [*B*], [*C*], [*D*], [*E*], [*F*], [*G*], [*H*]),
      [Coste], [Bajo], [Medio], [Alto], [Medio], [Bajo], [Alto], [Medio], [Bajo],
      [Rendimiento], [Medio], [Alto], [Alto], [Bajo], [Alto], [Medio], [Alto], [Medio],
      [Soporte],
      [#sym.checkmark], [#sym.checkmark], [—], [#sym.checkmark], [—],
      [#sym.checkmark], [#sym.checkmark], [—],
    ),
    caption: [Tabla ancha en una página apaisada, con cabecera en negrita y marcas de verificación],
  ) <tab:wide>
]

== Código fuente

// Solo tienes que indicar el lenguaje tras las comillas triples; el resaltado
// se aplica automáticamente (Typst conoce muchos lenguajes).
#figure(
  ```python
  def saludar(nombre):
      """Devuelve un mensaje de saludo."""
      return f"Hola, {nombre}!"

  print(saludar("UC3M"))
  ```,
  caption: [Una función sencilla en Python],
) <lst:python>

#figure(
  ```cpp
  #include <iostream>

  // Saluda a un usuario
  int main() {
      std::cout << "Hola, UC3M!" << std::endl;
      return 0;
  }
  ```,
  caption: [Una función equivalente en C++],
) <lst:cpp>

#figure(
  ```html
  <!-- Un saludo -->
  <p class="saludo">Hola, <strong>UC3M</strong>!</p>
  ```,
  caption: [Un fragmento de HTML],
) <lst:html>

El @lst:python muestra un fragmento en Python; el mismo esquema resalta cualquier
lenguaje que indiques (aquí también C++ y HTML).

== Ecuaciones

La identidad de Euler (las ecuaciones en bloque se numeran automáticamente):
$ e^(i pi) + 1 = 0 $ <eq:euler>

La @eq:euler es la identidad de Euler. También se pueden escribir fórmulas en
línea, por ejemplo $a^2 + b^2 = c^2$.

Varias ecuaciones alineadas por el signo igual:
$ (a+b)^2 &= a^2 + 2 a b + b^2 \
  (a-b)^2 &= a^2 - 2 a b + b^2 $

También puedes escribir matemáticas con sintaxis LaTeX gracias a #emph[mitex]:
#mitex(`\frac{\partial f}{\partial x} = 2x`)

== Emojis

Emojis a color (automáticos con OpenMoji): 🌹 🍃 🚀 ✅

// Cualquier emoji se compone por su carácter Unicode; OpenMoji (incrustada en la
// plantilla) lo dibuja a color. Lista completa de códigos:
// https://www.unicode.org/emoji/charts/full-emoji-list.html

== Acrónimos y glosario

El #gls("gul") promueve el #gls("swlibre") en la #gls("uc3m") desde hace años.
En la primera aparición se muestran la forma desarrollada y la sigla; después,
los acrónimos aparecen abreviados, por ejemplo #gls("gul") o #gls("uc3m") más
adelante. Las siglas se recogen en «Acrónimos» y los términos definidos, en
«Glosario».

== Bibliografía y citas

Una cita simple @prieto2014applications y una cita múltiple
@knuth1984texbook @uc3m_earchivo. Así aparecen las tres referencias de ejemplo
en la bibliografía.
