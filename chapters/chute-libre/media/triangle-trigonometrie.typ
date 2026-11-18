#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Triangle rectangle en C, angle θ en A. Mêmes couleurs que la
// décomposition de la vitesse : adjacent (vert) ↔ v_x, opposé (rouge) ↔ v_y,
// hypoténuse (or) ↔ v_i.

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (a, b, c) = ((0, 0), (6, 3.6), (6, 0))
  let theta = calc.atan2(6, 3.6)

  // Remplissage léger
  line(a, b, c, close: true, fill: palette.neutral.fill, stroke: none)

  // Angle θ
  let r = 1.5
  let arc-pts = range(0, 21).map(i => {
    let t = theta * i / 20
    (r * calc.cos(t), r * calc.sin(t))
  })
  line(a, ..arc-pts, close: true, fill: palette.gold.fill, stroke: none)
  line(..arc-pts, stroke: 0.8pt + palette.gold.line)
  content(((r + 0.35) * calc.cos(theta / 2), (r + 0.35) * calc.sin(theta / 2)), text(size: 13pt, fill: ink, $θ$))

  // Angle droit
  let q = 0.4
  line((6 - q, 0), (6 - q, q), (6, q), stroke: 0.8pt + ink)

  // Côtés
  let side(from, to, shade) = line(from, to, stroke: (paint: shade.line, thickness: 3pt, cap: "round"))
  side(a, c, palette.green)
  side(c, b, palette.red)
  side(a, b, palette.gold)

  content((3, 0), anchor: "north", padding: 0.2, text(size: 12pt, fill: palette.green.text, weight: "semibold")[côté adjacent])
  content((6, 1.8), anchor: "south", padding: 0.2, angle: -90deg, text(
    size: 12pt,
    fill: palette.red.text,
    weight: "semibold",
  )[côté opposé])
  content((3, 1.8), anchor: "south", padding: 0.15, angle: theta, text(
    size: 12pt,
    fill: palette.gold.text,
    weight: "semibold",
  )[hypoténuse])

  // Sommets
  for (p, name, anchor) in ((a, $A$, "east"), (b, $B$, "south-west"), (c, $C$, "north-west")) {
    circle(p, radius: 0.07, fill: ink, stroke: none)
    content(p, anchor: anchor, padding: 0.15, text(size: 14pt, fill: ink, name))
  }
})
