#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  let wood = palette.gold
  let metal = (fill: rgb("#607d8b"), line: rgb("#263238"), text: white)

  let number(pos, k, shade) = content(pos, text(
    size: 10pt,
    fill: shade.text,
    weight: "semibold",
    str(k),
  ))

  // Manche en bois découpé en 10 éléments
  let half = 0.35
  rect(
    (0, -half),
    (10.1, half),
    radius: 0.15,
    fill: wood.fill,
    stroke: 1.2pt + wood.line,
  )
  for k in range(1, 10) {
    line((k, -half), (k, half), stroke: 0.8pt + wood.line)
  }
  for k in range(1, 11) { number((k - 0.5, 0), k, wood) }

  // Col de la tête (élément 11)
  rect((10, -0.45), (10.9, 0.45), fill: metal.fill, stroke: 1.2pt + metal.line)
  number((10.45, 0), 11, metal)

  // Tête (éléments 12 à 15) avec la panne effilée en bas
  let (left, right) = (10.9, 12.1)
  line(
    (left, 1.5),
    (right, 1.5),
    (right, -1.5),
    (right - 0.25, -2.5),
    (left + 0.25, -2.5),
    (left, -1.5),
    close: true,
    fill: metal.fill,
    stroke: (paint: metal.line, thickness: 1.2pt, join: "round"),
  )
  for y in (0.5, -0.5, -1.5) {
    line((left, y), (right, y), stroke: 0.8pt + metal.line)
  }
  let mid = (left + right) / 2
  for (k, y) in ((12, 1), (13, 0), (14, -1), (15, -2)) {
    number((mid, y), k, metal)
  }

  // Centres de rotation : bout du manche (O1) et tête (O2)
  let center(pos, label, anchor) = {
    circle(pos, radius: 0.14, fill: palette.green.line, stroke: 1pt + white)
    content(pos, anchor: anchor, padding: 0.25, text(size: 12pt, label))
  }
  center((0, 0), $O_1$, "east")
  center((right, 0), $O_2$, "west")
})
