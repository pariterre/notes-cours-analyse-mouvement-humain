#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Travail d'une force : la force F, appliquée à l'objet, se déplace avec lui
// de A à B (déplacement u). L'angle θ entre F et u intervient dans le calcul
// (W = F · u = ‖F‖ ‖u‖ cos θ).

#let (box-w, box-h) = (2.2, 1.6)
#let travel = 5.0 // déplacement de A à B
#let f-angle = -25deg // la force pousse vers l'avant et un peu vers le bas
#let f-len = 1.7

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  // u (déplacement) en bleu, F (force quelconque) en gris foncé
  let (force, disp) = (palette.neutral, palette.blue)
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))

  // Sol
  line((-2.0, 0), (travel + box-w + 0.6, 0), stroke: 1pt + ink)
  for i in range(int((travel + box-w + 2.6) / 0.3)) {
    let x = -1.9 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Objet en A (estompé) et en B
  let a = (0, box-h / 2) // point d'application de la force (face arrière)
  let b = (travel, box-h / 2)
  for (corner, alpha) in (((0, 0), 60%), ((travel, 0), 0%)) {
    rect(corner, add(corner, (box-w, box-h)), radius: 0.05, fill: palette.blue.fill.transparentize(alpha), stroke: 1.2pt + palette.blue.line.transparentize(alpha))
  }

  // Force appliquée au même point de l'objet, en A puis en B
  for (p, alpha) in ((a, 60%), (b, 0%)) {
    let tail = add(p, polar(-f-len, f-angle))
    line(tail, p, stroke: 2.6pt + force.line.transparentize(alpha), mark: (
      end: "stealth",
      fill: force.line.transparentize(alpha),
      stroke: force.line.transparentize(alpha),
      scale: 1.2,
    ))
    content(tail, anchor: "south-east", padding: 0.05, text(size: 13pt, fill: force.text.transparentize(alpha))[$arrow(F)$])
  }

  // Déplacement u, de A à B
  line(a, b, stroke: 2.4pt + disp.line, mark: (end: "stealth", fill: disp.line, stroke: disp.line, scale: 1.2))
  content(((a.at(0) + b.at(0)) / 2 + box-w / 2, a.at(1)), anchor: "south", padding: 0.12, text(size: 13pt, fill: disp.text)[$arrow(u)$])

  // Angle θ entre F et u, en B : prolongement pointillé de F et de u dans
  // l'objet, et l'arc entre les deux
  let r = 1.0
  let ext = (paint: ink.transparentize(40%), thickness: 0.7pt, dash: "dotted")
  line(b, add(b, polar(r + 0.3, f-angle)), stroke: ext)
  line(b, add(b, (r + 0.3, 0)), stroke: ext)
  let arc = range(0, 21).map(i => add(b, polar(r, f-angle * i / 20)))
  line(..arc, stroke: 1pt + ink)
  content(add(b, polar(r + 0.25, f-angle / 2)), text(size: 12pt, fill: ink)[$theta$])

  // Points A et B
  for (p, name) in ((a, $A$), (b, $B$)) {
    circle(p, radius: 0.08, fill: ink, stroke: 1pt + white)
    content(p, anchor: "north-west", padding: 0.12, text(size: 13pt, weight: "bold", fill: ink, name))
  }
})
