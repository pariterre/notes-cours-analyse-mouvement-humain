#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Comment augmenter l'intensité d'un moment de force avec une clé :
//   ‖M‖ = ‖OM‖ · ‖F‖ · |sin θ|
// À partir d'une situation de référence, on augmente un seul des trois
// termes à la fois (chacun avec sa couleur, reprise dans l'équation).

// (titre, couleur, distance OM, norme de F, angle θ)
#let cases = (
  ([Référence], palette.red, 2.2, 1.3, 50deg),
  ([Bras de levier plus long], palette.green, 3.7, 1.3, 50deg),
  ([Force plus grande], palette.gold, 2.2, 2.0, 50deg),
  ([Force perpendiculaire], palette.blue, 2.2, 1.3, 90deg),
)

#let equation = text(size: 15pt)[$
  norm(arrow(M)_(O, arrow(F)))
  = #text(fill: palette.green.text)[$norm(arrow(O M))$]
  dot #text(fill: palette.gold.text)[$norm(arrow(F))$]
  dot #text(fill: palette.blue.text)[$abs(sin theta)$]
$]

#let panel(title, shade, om, force, angle) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let metal = palette.neutral.line
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))

  // Clé à fourche aux deux bouts : celle de gauche serre l'écrou en O,
  // celle de droite (ouverte vers la droite) est libre
  let steel = (fill: palette.neutral.fill.darken(6%), stroke: 0.8pt + metal)
  rect((0.3, -0.17), (4.25, 0.17), radius: 0.08, ..steel)
  let (jaw-r, slot) = (0.47, 0.19)
  let open = calc.asin(slot / jaw-r)
  // Tête à fourche centrée en c, ouverte vers `facing` (0deg = droite)
  let jaw(c, facing) = line(
    ..range(41).map(i => add(c, polar(jaw-r, facing + open + (360deg - 2 * open) * i / 40))),
    add(c, polar(0.05, facing + 180deg)).zip(polar(slot, facing - 90deg)).map(((a, b)) => a + b),
    add(c, polar(0.05, facing + 180deg)).zip(polar(slot, facing + 90deg)).map(((a, b)) => a + b),
    close: true,
    ..steel,
  )
  jaw((0, 0), 180deg)
  // Écrou (méplats en haut et en bas, pris dans la fourche)
  line(..range(6).map(k => polar(slot / calc.cos(30deg), k * 60deg)), close: true, fill: palette.neutral.line.lighten(40%), stroke: 0.8pt + metal)
  jaw((4.45, 0), 0deg)
  circle((0, 0), radius: 0.07, fill: ink, stroke: none)
  content((0, 0.45), anchor: "south", padding: 0.08, text(size: 12pt, weight: "bold", fill: ink)[$O$])

  // Bras de levier OM et force F en M
  let m = (om, 0)
  line((0, 0), m, stroke: (paint: palette.green.line, thickness: if shade == palette.green { 2.4pt } else { 1pt }))
  let tip = add(m, polar(force, -angle))
  line(m, tip, stroke: 2.6pt + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.2))
  content(tip, anchor: "north", padding: 0.1, text(size: 12pt, fill: shade.text)[$arrow(F)$])

  // Angle θ entre le bras de levier et la force
  let r = 0.45
  let arc = range(0, 21).map(i => add(m, polar(r, -angle * i / 20)))
  line(m, ..arc, close: true, fill: palette.blue.fill, stroke: none)
  line(..arc, stroke: 0.8pt + palette.blue.line)
  content(add(m, polar(r + 0.22, -angle / 2)), text(size: 11pt, fill: palette.blue.text)[$theta$])

  circle(m, radius: 0.08, fill: ink, stroke: 1pt + white)
  content(m, anchor: "south", padding: 0.22, text(size: 12pt, weight: "bold", fill: ink)[$M$])

  // Titre
  content((2.4, 1.25), anchor: "south", text(size: 12pt, weight: "semibold", fill: shade.text, title))
  // Cadre invisible : même taille pour tous les panneaux
  rect((-0.6, -2.05), (5.1, 1.7), stroke: none)
})

#align(center, equation)
#v(0.4em)
#grid(
  columns: 2,
  column-gutter: 1.2em,
  row-gutter: 0.8em,
  ..cases.map(((title, shade, om, force, angle)) => panel(title, shade, om, force, angle)),
)
