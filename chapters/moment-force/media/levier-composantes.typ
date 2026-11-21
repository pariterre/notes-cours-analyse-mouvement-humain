#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Composantes d'un levier inter-appui : une personne appuie (force motrice)
// sur l'extrémité longue d'une barre posée sur un point d'appui pour soulever
// une charge (résistance) posée à l'autre extrémité.

#let bar-y = 1.5
#let (x-load, x-hand) = (-2.3, 4.6) // points d'application de la résistance et de la force

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let arrow-mark(shade) = (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.3)

  // Sol
  line((-3.6, 0), (6.6, 0), stroke: 1pt + ink)
  for i in range(40) {
    let x = -3.4 + i * 0.25
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Point d'appui
  line((-0.45, 0), (0.45, 0), (0, bar-y - 0.08), close: true, fill: palette.gold.fill, stroke: 1.2pt + palette.gold.line)

  // Barre
  rect((x-load - 0.6, bar-y - 0.08), (x-hand + 0.35, bar-y + 0.08), radius: 0.04, fill: palette.neutral.line.lighten(30%), stroke: 0.8pt + palette.neutral.line)

  // Charge
  rect((x-load - 0.55, bar-y + 0.08), (x-load + 0.55, bar-y + 1.15), radius: 0.05, fill: palette.neutral.fill.darken(10%), stroke: 1pt + palette.neutral.line)
  content((x-load, bar-y + 0.62), text(size: 11pt, fill: ink, weight: "semibold")[charge])

  // Personnage en bâtons : appuie sur l'extrémité de la barre
  let stick = (paint: ink, thickness: 2.6pt, cap: "round", join: "round")
  let (hip, shoulder, hand) = ((5.65, 1.7), (5.3, 2.85), (x-hand + 0.05, bar-y + 0.13))
  line((5.35, 0.02), (5.55, 0.85), hip, stroke: stick) // jambe avant
  line((6.05, 0.02), (5.85, 0.85), hip, stroke: stick) // jambe arrière
  line(hip, shoulder, stroke: stick) // tronc
  line(shoulder, (4.85, 2.2), hand, stroke: stick) // bras
  circle((5.2, 3.27), radius: 0.3, fill: white, stroke: stick)

  // Forces
  line((x-load, bar-y - 0.08), (x-load, 0.3), stroke: 2.6pt + palette.blue.line, mark: arrow-mark(palette.blue))
  content((x-load, 0.55), anchor: "east", padding: 0.15, text(size: 12pt, fill: palette.blue.text, weight: "semibold")[résistance])
  line((x-hand - 0.25, bar-y + 1.45), (x-hand - 0.25, bar-y + 0.15), stroke: 2.6pt + palette.red.line, mark: arrow-mark(palette.red))
  content((x-hand - 0.25, bar-y + 1.45), anchor: "south-east", padding: 0.1, text(size: 12pt, fill: palette.red.text, weight: "semibold")[force motrice])

  // Bras de levier : cotes sous le sol, reliées par des repères pointillés
  let dim-y = -0.7
  let guide = (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted")
  for x in (x-load, 0, x-hand - 0.25) { line((x, if x == 0 { 0 } else { bar-y - 0.1 }), (x, dim-y - 0.15), stroke: guide) }
  let dim(x0, x1, shade, label) = {
    line((x0, dim-y), (x1, dim-y), stroke: 1.2pt + shade.line, mark: (
      start: "stealth",
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
      scale: 0.7,
    ))
    for x in (x0, x1) { line((x, dim-y - 0.12), (x, dim-y + 0.12), stroke: 0.8pt + shade.line) }
    content(((x0 + x1) / 2, dim-y), anchor: "north", padding: 0.1, text(size: 11pt, fill: shade.text, align(center, label)))
  }
  dim(x-load, -0.02, palette.blue, [bras de résistance])
  dim(0.02, x-hand - 0.25, palette.red, [bras de force])

  content((0.3, 0.75), anchor: "west", text(size: 12pt, fill: palette.gold.text, weight: "semibold")[point d'appui])
})
