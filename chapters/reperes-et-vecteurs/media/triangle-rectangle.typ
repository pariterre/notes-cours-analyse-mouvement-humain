#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Triangle rectangle en C : l'hypoténuse AB est le vecteur, les côtés de
// l'angle droit sont ses composantes (mêmes couleurs que la figure du
// vecteur AB : x en rouge, y en vert).

#let a = (0, 0)
#let c = (5.2, 0)
#let b = (5.2, 3.0)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let hyp = palette.gold
  let adj = palette.red
  let opp = palette.green
  let side(from, to, shade) = line(from, to, stroke: (paint: shade.line, thickness: 3pt, cap: "round"))

  // Angle droit en C
  let s = 0.35
  line((c.at(0) - s, 0), (c.at(0) - s, s), (c.at(0), s), stroke: 0.8pt + palette.neutral.text)

  side(a, c, adj)
  side(c, b, opp)
  side(a, b, hyp)

  // Sommets
  for (p, label, anchor) in ((a, $A$, "east"), (b, $B$, "south-west"), (c, $C$, "north-west")) {
    circle(p, radius: 0.07, fill: palette.dark.line, stroke: none)
    content(p, anchor: anchor, padding: 0.15, text(size: 13pt, label))
  }

  // Noms des côtés, alignés sur chaque côté
  let angle = calc.atan2(b.at(0) - a.at(0), b.at(1) - a.at(1))
  content(
    ((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2),
    anchor: "south",
    padding: 0.15,
    angle: angle,
    text(size: 12pt, fill: hyp.text)[Hypoténuse],
  )
  content(((a.at(0) + c.at(0)) / 2, 0), anchor: "north", padding: 0.15, text(
    size: 12pt,
    fill: adj.text,
  )[Côté adjacent])
  content(
    (c.at(0), b.at(1) / 2),
    anchor: "north",
    padding: 0.15,
    angle: 90deg,
    text(size: 12pt, fill: opp.text)[Côté opposé],
  )
})
