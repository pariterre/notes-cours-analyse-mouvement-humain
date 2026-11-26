#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Force de frottement en fonction de la force de traction :
//   - phase statique : l'objet ne bouge pas, le frottement compense
//     exactement la traction (droite y = x) jusqu'au seuil μ_s ‖W‖;
//   - phase de glissement : le frottement chute puis reste constant à
//     μ_d ‖W‖; la traction en surplus accélère l'objet de plus en plus.
// Frottement en rouge, comme dans la figure de la loi de Coulomb.

#let (static-max, kinetic) = (2.6, 1.9) // μ_s ‖W‖ et μ_d ‖W‖ (unités du dessin)
#let x-max = 8.0

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let friction = palette.red
  let sym = coefficient-cinetique.symbol
  let arrow-mark = (end: "stealth", fill: ink, stroke: ink)

  // Zone statique (l'objet ne bouge pas)
  rect((0, 0), (static-max, 4.2), fill: palette.neutral.fill, stroke: none)
  content((static-max / 2, 4.2), anchor: "north", padding: 0.12, text(size: 11pt, fill: ink, weight: "semibold", align(center)[frottement \ statique]))
  content(((static-max + x-max) / 2 + 0.3, 4.2), anchor: "north", padding: 0.12, text(size: 11pt, fill: ink, weight: "semibold")[frottement #coefficient-cinetique.name (glissement)])

  // Axes
  line((0, 0), (x-max + 0.4, 0), stroke: 0.9pt + ink, mark: arrow-mark)
  line((0, 0), (0, 4.6), stroke: 0.9pt + ink, mark: arrow-mark)
  content((x-max + 0.4, 0), anchor: "north-east", padding: 0.12, text(size: 11pt, fill: ink)[force de traction (#unit[N])])
  content((0, 4.6), anchor: "south-west", padding: 0.08, text(size: 11pt, fill: friction.text)[force de frottement (#unit[N])])

  // Seuils sur l'axe vertical
  let guide = (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dashed")
  line((0, static-max), (static-max, static-max), stroke: guide)
  line((0, kinetic), (x-max, kinetic), stroke: guide)
  content((0, static-max), anchor: "east", padding: 0.12, text(size: 12pt, fill: friction.text)[$mu_s norm(arrow(W))$])
  content((0, kinetic), anchor: "east", padding: 0.12, text(size: 12pt, fill: friction.text)[$mu_#sym norm(arrow(W))$])

  // Courbe : droite (frottement = traction), chute verticale au seuil (le
  // glissement commence pour cette valeur de traction), puis palier
  line(
    (0, 0),
    (static-max, static-max),
    (static-max, kinetic),
    (x-max, kinetic),
    stroke: (paint: friction.line, thickness: 2.6pt, join: "round", cap: "round"),
  )

  content(((static-max + x-max) / 2 + 0.3, kinetic), anchor: "north", padding: 0.2, text(size: 11pt, fill: ink, style: "italic")[accélération de plus en plus grande])
})
