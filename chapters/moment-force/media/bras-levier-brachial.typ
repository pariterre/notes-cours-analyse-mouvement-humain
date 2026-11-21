#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Effet du bras de levier sur la force musculaire (levier inter-moteur) :
// deux personnes tiennent le même cube, avant-bras à l'horizontale. Seul le
// point d'insertion du brachial change (24 mm ou 44 mm du coude); le bras de
// levier résistant est de 30 cm. Échelle : 1 unité = 10 cm (tout est à l'échelle).

#let resistance-arm = 3.0 // 30 cm

#let subject(insertion-mm) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let d = insertion-mm / 100 // en unités (10 cm)
  let elbow = (0, 0)
  let hand = (resistance-arm, 0)
  let stick = (paint: ink, thickness: 2.6pt, cap: "round", join: "round")

  // Personnage en bâtons, debout, regard vers la droite
  // Proportions réelles (bras et avant-bras ≈ 30 cm) : on ne montre que le
  // haut du corps, coupé aux hanches
  circle((-0.75, 4.75), radius: 1.0, fill: white, stroke: stick) // tête
  line((-0.75, 3.75), (-0.75, 3.2), stroke: stick) // cou
  line((-0.75, 3.2), (-0.9, -2.4), stroke: stick) // tronc
  let shoulder = (-0.76, 3.0) // sur le tronc
  line(shoulder, elbow, hand, stroke: stick) // bras (humérus) et avant-bras
  // Origine du brachial : sur l'humérus, aux 3/5 de l'épaule vers le coude
  let origin = (shoulder.at(0) * 0.42, shoulder.at(1) * 0.42)

  // Brachial : de l'humérus à l'insertion sur l'avant-bras
  line(origin, (d, 0.02), stroke: (paint: palette.red.line.lighten(55%), thickness: 6pt, cap: "round"))

  // Cube tenu dans la main
  let side = 1.0 // cube de 10 cm de côté (énoncé de l'exercice)
  rect((hand.at(0) - side / 2, 0.05), (hand.at(0) + side / 2, 0.05 + side), fill: palette.green.fill, stroke: 1pt + palette.green.line)

  // Forces : force musculaire le long du muscle, poids du cube
  let (mx, my) = (origin.at(0) - d, origin.at(1))
  let n = calc.sqrt(mx * mx + my * my)
  let u = (mx / n, my / n)
  line((d, 0), (d + 1.5 * u.at(0), 1.5 * u.at(1)), stroke: 2.6pt + palette.red.line, mark: (
    end: "stealth",
    fill: palette.red.line,
    stroke: palette.red.line,
    scale: 1.2,
  ))
  content((d + 1.5 * u.at(0), 1.5 * u.at(1)), anchor: "south-west", padding: 0.05, text(size: 13pt, fill: palette.red.text)[$arrow(F)$])
  let c = (hand.at(0), 0.05 + side / 2)
  line(c, (hand.at(0), -1.6), stroke: 2.6pt + palette.blue.line, mark: (
    end: "stealth",
    fill: palette.blue.line,
    stroke: palette.blue.line,
    scale: 1.2,
  ))
  content((hand.at(0), -1.6), anchor: "north", padding: 0.1, text(size: 13pt, fill: palette.blue.text)[$arrow(P)$])

  // Coude (pivot)
  circle(elbow, radius: 0.12, fill: palette.gold.line, stroke: 1pt + white)

  // Bras de levier
  let guide = (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted")
  for x in (0, d) { line((x, 0), (x, -0.95), stroke: guide) }
  // Étiquette à droite pour la petite cote, au-dessus du milieu pour la grande
  let dim(x1, y, shade, label, beside: false) = {
    line((0, y), (x1, y), stroke: 1pt + shade.line, mark: (start: "stealth", end: "stealth", fill: shade.line, stroke: shade.line, scale: 0.5))
    if beside {
      content((x1, y), anchor: "west", padding: 0.1, text(size: 11pt, fill: shade.text, label))
    } else {
      content((x1 / 2, y), anchor: "north", padding: 0.08, text(size: 11pt, fill: shade.text, label))
    }
  }
  dim(d, -0.4, palette.red, qty[#insertion-mm][mm], beside: true)
  dim(resistance-arm, -0.85, palette.blue, qty[30][cm])
})

#grid(
  columns: 2,
  column-gutter: 3em,
  subject(24), subject(44),
)
