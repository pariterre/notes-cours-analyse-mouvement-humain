#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Barrage hydroélectrique (Manic-2) en coupe : l'eau du réservoir chute de
// 70 m dans la conduite forcée avant d'atteindre la turbine. La hauteur est
// mesurée à partir de la turbine (référence de l'énergie potentielle).
// Même présentation que la figure du plongeon (référence h = 0).
// Échelle : 1 unité = 14 m (le cube de 1 m³ est agrandi pour être visible).

#let s = 1 / 14 // unités par mètre
#let drop = 70

#cetz.canvas(length: 0.75cm, { // dessin réduit : le texte paraît plus grand
  import cetz.draw: *

  let ink = palette.neutral.text
  let water = palette.blue
  let concrete = (fill: palette.neutral.fill.darken(10%), stroke: 1pt + palette.neutral.line)
  let y-cube = drop * s // hauteur du cube au-dessus de la turbine
  let y-level = y-cube + 0.75 // surface du réservoir
  let y-bed = -0.4 // fond du réservoir
  let waves(x0, x1, y) = {
    let n = int((x1 - x0) / 0.8)
    let step = (x1 - x0) / n
    for k in range(n) {
      let x = x0 + k * step
      bezier((x, y), (x + step, y), (x + step / 4, y + 0.1), (x + 3 * step / 4, y - 0.1), stroke: 1.2pt + water.line)
    }
  }

  // Réservoir (amont)
  rect((-5.0, y-bed), (0, y-level), fill: water.fill, stroke: none)
  waves(-5.0, 0, y-level)
  content((-4.9, y-bed + 0.3), anchor: "west", text(size: 13pt, fill: water.text, style: "italic")[réservoir])

  // Barrage (coupe) et centrale au pied du barrage
  line((0, y-bed), (0, y-level + 0.5), (0.7, y-level + 0.5), (2.6, y-bed), close: true, ..concrete)
  rect((2.6, y-bed), (6.2, 1.4), ..concrete)
  content((4.4, 1.05), text(size: 12pt, fill: ink, style: "italic")[centrale])

  // Rivière en aval
  rect((6.2, y-bed), (7.8, -0.1), fill: water.fill, stroke: none)
  waves(6.2, 7.8, -0.1)

  // Conduite forcée : de la prise d'eau à la turbine
  let turbine = (3.4, 0.0)
  let intake = (0, y-cube - 1.2)
  line(intake, (1.0, intake.at(1)), (2.9, 0.0), turbine, stroke: (paint: water.line, thickness: 7pt, cap: "round", join: "round"))
  line(intake, (1.0, intake.at(1)), (2.9, 0.0), turbine, stroke: (paint: water.fill, thickness: 4pt, cap: "round", join: "round"))
  // Nom à l'extérieur du barrage, relié à la conduite
  content((3.0, 2.6), anchor: "west", text(size: 12pt, fill: water.text, style: "italic")[conduite forcée])
  line((2.95, 2.6), (1.95, 1.4), stroke: 0.6pt + water.line)

  // Turbine
  circle(turbine, radius: 0.32, fill: white, stroke: 1.2pt + ink)
  for k in range(6) {
    let a = k * 60deg
    line(turbine, (turbine.at(0) + 0.26 * calc.cos(a), turbine.at(1) + 0.26 * calc.sin(a)), stroke: 1.2pt + ink)
  }
  content(turbine, anchor: "west", padding: 0.42, text(size: 13pt, fill: ink, weight: "semibold")[turbine])

  // Un mètre cube d'eau du réservoir
  let c = (-2.6, y-cube)
  let side = 0.5
  rect((c.at(0) - side / 2, c.at(1) - side / 2), (c.at(0) + side / 2, c.at(1) + side / 2), fill: palette.gold.fill, stroke: 1.4pt + palette.gold.line)
  content((c.at(0), c.at(1) - side / 2), anchor: "north", padding: 0.1, text(size: 14pt, fill: palette.gold.text, align(center)[#qty[1][m^3] \ $m = #qty[1000][kg]$]))

  // Hauteur de chute, mesurée depuis la turbine
  let x-dim = 8.6
  let guide = (paint: ink.transparentize(45%), thickness: 0.6pt, dash: "dotted")
  line((c.at(0) + side / 2, y-cube), (x-dim + 0.2, y-cube), stroke: guide)
  line((turbine.at(0) + 0.35, 0), (x-dim + 0.2, 0), stroke: guide)
  line((x-dim, 0), (x-dim, y-cube), stroke: 1.2pt + palette.red.line, mark: (
    start: "stealth",
    end: "stealth",
    fill: palette.red.line,
    stroke: palette.red.line,
  ))
  content((x-dim, y-cube / 2), anchor: "west", padding: 0.15, text(size: 16pt, fill: palette.red.text)[$h = #qty[70][m]$])
  content((x-dim, 0), anchor: "north-west", padding: (top: 0.15, left: 0.1), text(
    size: 13pt,
    fill: ink,
    style: "italic",
  )[référence : $h = 0$])
})
