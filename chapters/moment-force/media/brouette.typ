#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Équilibre d'une brouette (levier inter-résistant) : le pivot est l'axe de
// la roue C, la résistance est le poids P appliqué en G (à la distance a de
// C) et la force motrice F est appliquée aux poignées M (à la distance b).
// L'avantage mécanique vaut b / a.

#let purple = (fill: rgb("#f1e4f7"), line: rgb("#7b1fa2"), text: rgb("#561571"))
#let wheel-r = 0.85
#let c = (0, wheel-r) // axe de la roue
// Le bac suit l'inclinaison des brancards (qui montent vers les poignées)
#let tilt = calc.atan2(3.6, 1.45 - wheel-r)
#let tray-pivot = (2.2, 1.5)
#let rot((x, y)) = {
  let (dx, dy) = (x - tray-pivot.at(0), y - tray-pivot.at(1))
  (tray-pivot.at(0) + dx * calc.cos(tilt) - dy * calc.sin(tilt), tray-pivot.at(1) + dx * calc.sin(tilt) + dy * calc.cos(tilt))
}
#let g = rot((1.9, 2.15)) // centre de masse de la charge
#let m = (5.6, 2.4) // poignées

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let force(from, to, shade, label, side) = {
    line(from, to, stroke: 2.8pt + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.3))
    content(to, anchor: side, padding: 0.1, text(size: 14pt, fill: shade.text, label))
  }

  // Sol
  line((-1.3, 0), (6.4, 0), stroke: 1pt + ink)
  for i in range(31) {
    let x = -1.2 + i * 0.25
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Bac
  line(..((0.35, 2.95), (4.1, 2.95), (3.4, 1.55), (1.0, 1.55)).map(rot), close: true, fill: palette.green.fill, stroke: 1.2pt + palette.green.line)
  // Brancards (de l'axe aux poignées) et béquille
  let frame = (paint: palette.neutral.text, thickness: 4pt, cap: "round", join: "round")
  line(c, (3.6, 1.45), m, stroke: frame)
  // Béquille levée : seules la roue et les poignées portent la brouette
  line((3.0, 1.32), (3.3, 0.45), (3.7, 0.45), stroke: (..frame, thickness: 2.5pt))
  // Roue
  circle(c, radius: wheel-r, stroke: 5pt + palette.dark.fill)
  for k in range(8) {
    line(c, (c.at(0) + 0.72 * calc.cos(k * 45deg), c.at(1) + 0.72 * calc.sin(k * 45deg)), stroke: 0.6pt + palette.neutral.line)
  }
  circle(c, radius: 0.13, fill: palette.gold.line, stroke: 1pt + white)

  // Forces
  force((0, 0), (0, 2.6), purple, $arrow(R)$, "south")
  force(g, (g.at(0), 0.35), palette.blue, $arrow(P)$, "north-west")
  force(m, (m.at(0), m.at(1) + 1.2), palette.red, $arrow(F)$, "south")
  circle(g, radius: 0.08, fill: palette.blue.line, stroke: 1pt + white)

  // Points
  content(c, anchor: "north-west", padding: 0.16, text(size: 13pt, weight: "bold", fill: palette.gold.text)[$C$])
  content(g, anchor: "south-west", padding: 0.12, text(size: 13pt, weight: "bold", fill: ink)[$G$])
  content(m, anchor: "north-west", padding: 0.12, text(size: 13pt, weight: "bold", fill: ink)[$M$])

  // Distances a (C à P) et b (C à F)
  let guide = (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted")
  for x in (0, g.at(0), m.at(0)) { line((x, if x == g.at(0) { 0.35 } else { 0 }), (x, -1.35), stroke: guide) }
  let dim(x1, y, shade, label) = {
    line((0, y), (x1, y), stroke: 1pt + shade.line, mark: (start: "stealth", end: "stealth", fill: shade.line, stroke: shade.line, scale: 0.7))
    content((x1 / 2, y), anchor: "south", padding: 0.08, text(size: 13pt, fill: shade.text, label))
  }
  dim(g.at(0), -0.6, palette.blue, $a$)
  dim(m.at(0), -1.2, palette.red, $b$)
})
