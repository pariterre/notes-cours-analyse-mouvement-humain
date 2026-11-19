// Éléments graphiques communs aux figures sur le centre de masse
// (barre en équilibre, appui, centre de masse, masses).
#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"

/// Décalage de profondeur de la perspective cavalière.
#let depth = (0.4, 0.3)

/// Couleurs de la barre (gris bleuté) et des masses (bleu).
#let bar-shade = (
  front: rgb("#b0bec5"),
  top: rgb("#90a4ae"),
  side: rgb("#cfd8dc"),
  edge: rgb("#546e7a"),
)
#let mass-shade = (
  front: palette.blue.line,
  top: palette.blue.line.lighten(35%),
  side: palette.blue.line.darken(30%),
  edge: palette.blue.text,
)

/// Prisme vu en perspective cavalière, coin inférieur gauche de la face
/// avant en `origin`.
#let prism(origin, width, height, shade) = {
  import cetz.draw: *
  let (x, y) = origin
  let (dx, dy) = depth
  let edge = 0.8pt + shade.edge
  rect((x, y), (x + width, y + height), fill: shade.front, stroke: edge)
  line(
    (x, y + height),
    (x + width, y + height),
    (x + width + dx, y + height + dy),
    (x + dx, y + height + dy),
    close: true,
    fill: shade.top,
    stroke: edge,
  )
  line(
    (x + width, y),
    (x + width + dx, y + dy),
    (x + width + dx, y + height + dy),
    (x + width, y + height),
    close: true,
    fill: shade.side,
    stroke: edge,
  )
}

/// Barre homogène.
#let bar(origin, length, height: 0.8) = prism(origin, length, height, bar-shade)

/// Masse cubique.
#let mass(origin, side) = prism(origin, side, side, mass-shade)

/// Appui triangulaire dont la pointe est en `apex`.
#let pivot(apex, size: 0.6) = {
  import cetz.draw: *
  let (x, y) = apex
  line(
    (x, y),
    (x - size / 2, y - size),
    (x + size / 2, y - size),
    close: true,
    fill: palette.gold.fill.darken(10%),
    stroke: (paint: palette.gold.line, thickness: 1.2pt, join: "round"),
  )
}

/// Centre de masse.
#let com(pos, radius: 0.13) = {
  import cetz.draw: *
  circle(pos, radius: radius, fill: palette.blue.text, stroke: none)
}
