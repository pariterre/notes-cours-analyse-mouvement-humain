#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Relation de Chasles : AB + BC = AC. Le second vecteur est placé au bout
// du premier; le vecteur résultant va du début du premier au bout du second.

#let a = (0, 0)
#let b = (1.7, 2.4)
#let c = (5.6, 2.9)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let vector(from, to, shade, thickness, label, anchor) = {
    line(
      from,
      to,
      stroke: (paint: shade.line, thickness: thickness),
      mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.5),
      name: "v",
    )
    content("v.mid", anchor: anchor, padding: 0.18, text(size: 12pt, fill: shade.text, label))
  }

  vector(a, b, palette.blue, 2.6pt, $arrow(A B)$, "south-east")
  vector(b, c, palette.green, 2.6pt, $arrow(B C)$, "south")
  vector(a, c, palette.gold, 3.4pt, $arrow(A C) = arrow(A B) + arrow(B C)$, "north-west")

  for (p, label, anchor) in ((a, $A$, "east"), (b, $B$, "south-east"), (c, $C$, "west")) {
    circle(p, radius: 0.07, fill: palette.dark.line, stroke: none)
    content(p, anchor: anchor, padding: 0.15, text(size: 13pt, label))
  }
})
