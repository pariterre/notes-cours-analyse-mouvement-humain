#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Pendule (système conservatif) : le boulet, lâché sans vitesse, passe par
// cinq positions. Sous chacune, une barre empilée donne l'énergie potentielle
// de pesanteur (rouge, proportionnelle à la hauteur) et l'énergie cinétique
// (vert, le reste); leur somme, l'énergie totale, reste constante.

#let length = 3.6
#let theta-max = 50deg
#let angles = (-50deg, -28deg, 0deg, 28deg, 50deg)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (pp, ec) = (palette.red, palette.green)
  let pivot = (0, length + 0.4)
  let ball-at(a) = (length * calc.sin(a), pivot.at(1) - length * calc.cos(a))
  let height(a) = length * (1 - calc.cos(a)) // au-dessus du point le plus bas
  let h-max = height(theta-max)

  // Support et trajectoire
  line((-0.6, pivot.at(1)), (0.6, pivot.at(1)), stroke: 2pt + ink)
  let arc = range(0, 41).map(i => ball-at(-theta-max + 2 * theta-max * i / 40))
  line(..arc, stroke: (
    paint: ink.transparentize(55%),
    thickness: 0.8pt,
    dash: "dashed",
  ))

  // Référence : point le plus bas
  let y-low = pivot.at(1) - length
  line((-3.4, y-low), (3.4, y-low), stroke: (
    paint: ink.transparentize(50%),
    thickness: 0.6pt,
    dash: "dotted",
  ))
  content((3.4, y-low), anchor: "west", padding: 0.1, text(
    size: 10pt,
    fill: ink,
    style: "italic",
  )[$h = 0$])

  // Boulet aux cinq positions : comme dans les autres figures, les positions
  // anciennes sont estompées (60 % au lâcher) et la dernière est pleine
  for (i, a) in angles.enumerate() {
    let b = ball-at(a)
    let alpha = 60% * (1 - i / (angles.len() - 1))
    // Estompé en éclaircissant (et non en rendant transparent) : le boulet
    // reste opaque et cache le fil et la trajectoire derrière lui
    line(pivot, b, stroke: 0.8pt + ink.lighten(alpha))
    // Même bleu que les objets des autres figures du chapitre
    circle(
      b,
      radius: 0.22,
      fill: palette.blue.fill.lighten(alpha),
      stroke: 1.2pt + palette.blue.line.lighten(alpha),
    )
  }
  circle(pivot, radius: 0.07, fill: ink, stroke: none)
  content(ball-at(angles.first()), anchor: "east", padding: 0.3, text(
    size: 10pt,
    fill: ink,
    style: "italic",
  )[lâcher : $v_i = 0$])

  // Barres d'énergie sous chaque position
  let (bar-w, total-h) = (0.55, 1.8)
  // Second repère que la couleur (daltonisme) : E_PP hachurée
  let hatch = tiling(size: (5pt, 5pt), place(std.line(start: (0pt, 5pt), end: (5pt, 0pt), stroke: 0.7pt + pp.line)))
  let hatched(a, b) = {
    rect(a, b, fill: pp.fill, stroke: none)
    rect(a, b, fill: hatch, stroke: 1pt + pp.line)
  }
  let y-bar = y-low - 2.4
  for a in angles {
    let x = ball-at(a).at(0)
    let h-pp = total-h * height(a) / h-max
    if h-pp > 0.001 { hatched((x - bar-w / 2, y-bar), (x + bar-w / 2, y-bar + h-pp)) }
    rect(
      (x - bar-w / 2, y-bar + h-pp),
      (x + bar-w / 2, y-bar + total-h),
      fill: ec.fill,
      stroke: 1pt + ec.line,
    )
    line(ball-at(a), (x, y-bar + total-h + 0.1), stroke: (
      paint: ink.transparentize(70%),
      thickness: 0.5pt,
      dash: "dotted",
    ))
  }
  // Énergie totale constante
  line((-3.4, y-bar + total-h), (3.4, y-bar + total-h), stroke: (
    paint: ink,
    thickness: 0.8pt,
    dash: "dashed",
  ))
  content((3.4, y-bar + total-h), anchor: "west", padding: 0.1, text(
    size: 11pt,
    fill: ink,
  )[$E_"T"$ constante])

  // Légende
  let legend(y, shade, body) = {
    if shade == pp { hatched((3.5, y - 0.15), (3.8, y + 0.15)) } else {
      rect((3.5, y - 0.15), (3.8, y + 0.15), fill: shade.fill, stroke: 1pt + shade.line)
    }
    content((3.9, y), anchor: "west", text(size: 11pt, fill: shade.text, body))
  }
  legend(y-bar + 1.1, ec, [$E_"C"$ (cinétique)])
  legend(y-bar + 0.5, pp, [$E_"PP"$ (potentielle)])
})
