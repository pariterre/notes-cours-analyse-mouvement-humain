#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Le vecteur AB dans la base (O, i, j), avec ses composantes en x et en y.

#let (xa, ya) = (1.8, 1.6)
#let (xb, yb) = (6.2, 3.8)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (x-max, y-max) = (7.6, 5.0)
  let vec-shade = palette.gold
  let x-shade = palette.red
  let y-shade = palette.green

  // Axes et vecteurs unitaires
  let axis-stroke = 0.9pt + ink
  line((-0.3, 0), (x-max, 0), stroke: axis-stroke, mark: (
    end: "stealth",
    fill: ink,
    stroke: ink,
  ))
  line((0, -0.3), (0, y-max), stroke: axis-stroke, mark: (
    end: "stealth",
    fill: ink,
    stroke: ink,
  ))
  for (to, label, anchor) in (
    ((1, 0), $arrow(i)$, "north"),
    ((0, 1), $arrow(j)$, "east"),
  ) {
    line(
      (0, 0),
      to,
      stroke: 2pt + palette.dark.line,
      mark: (
        end: "stealth",
        fill: palette.dark.line,
        stroke: palette.dark.line,
        scale: 1.2,
      ),
    )
    content(to, anchor: anchor, padding: 0.15, text(size: 11pt, label))
  }
  content((0, 0), anchor: "north-east", padding: 0.12, text(
    size: 11pt,
    fill: ink,
  )[O])

  // Droite (d) portant le vecteur
  let slope = (yb - ya) / (xb - xa)
  let y-at(x) = ya + slope * (x - xa)
  line((0.2, y-at(0.2)), (x-max - 0.3, y-at(x-max - 0.3)), stroke: 0.8pt + ink)
  content(
    (x-max - 0.3, y-at(x-max - 0.3)),
    anchor: "south-east",
    padding: 0.12,
    text(
      size: 10pt,
      fill: ink,
    )[$d$],
  )

  // Projections en pointillés
  let dotted(paint) = (paint: paint, thickness: 0.9pt, dash: "dotted")
  line((xa, ya), (xa, 0), stroke: dotted(x-shade.line))
  line((xb, yb), (xb, 0), stroke: dotted(x-shade.line))
  line((xa, ya), (0, ya), stroke: dotted(y-shade.line))
  line((xb, yb), (0, yb), stroke: dotted(y-shade.line))

  // Graduations
  let tick-label(pos, anchor, body, shade) = content(
    pos,
    anchor: anchor,
    padding: 0.15,
    text(
      size: 11pt,
      fill: shade.text,
      body,
    ),
  )
  tick-label((xa, 0), "north", $x_A$, x-shade)
  tick-label((xb, 0), "north", $x_B$, x-shade)
  tick-label((0, ya), "east", $y_A$, y-shade)
  tick-label((0, yb), "east", $y_B$, y-shade)

  // Composantes du vecteur
  let comp-stroke(shade) = (paint: shade.line, thickness: 3pt)
  let comp-mark(shade) = (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.3,
  )
  line(
    (xa, 0),
    (xb, 0),
    stroke: comp-stroke(x-shade),
    mark: comp-mark(x-shade),
    name: "cx",
  )
  content("cx.mid", anchor: "south", padding: 0.12, text(
    size: 11pt,
    fill: x-shade.text,
    $x_B - x_A$,
  ))
  line(
    (0, ya),
    (0, yb),
    stroke: comp-stroke(y-shade),
    mark: comp-mark(y-shade),
    name: "cy",
  )
  content("cy.mid", anchor: "west", padding: 0.15, text(
    size: 11pt,
    fill: y-shade.text,
    $y_B - y_A$,
  ))

  // Vecteur AB
  line(
    (xa, ya),
    (xb, yb),
    stroke: (paint: vec-shade.line, thickness: 3.2pt),
    mark: (
      end: "stealth",
      fill: vec-shade.line,
      stroke: vec-shade.line,
      scale: 1.5,
    ),
    name: "ab",
  )
  content("ab.mid", anchor: "south-east", padding: 0.15, text(
    size: 12pt,
    fill: vec-shade.text,
    $arrow(A B)$,
  ))
  for (p, label) in (((xa, ya), $A$), ((xb, yb), $B$)) {
    circle(p, radius: 0.07, fill: palette.dark.line, stroke: none)
    content(p, anchor: "south-east", padding: 0.12, text(size: 12pt, label))
  }
})
