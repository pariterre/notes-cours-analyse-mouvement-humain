#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Distance parcourue versus déplacement sur une piste d'athlétisme.
// Coordonnées en mètres (1 unité de dessin = 10 m).
// Couloir de course : lignes droites de x = 56 à x = 125 m, virages de
// rayon 35 m centrés en y = 45 m. De A (60, 10) à B (80, 80) en passant par
// le virage : 65 + π·35 + 45 ≈ 220 m; déplacement ‖AB‖ = √(20² + 70²) ≈ 72.8 m.

#let (x-start, x-end, cy, lane-r) = (50, 125, 45, 35)
#let a = (60, 10)
#let b = (80, 80)

#let s(p) = p.map(c => c / 10)

// Contour d'un « stade » (deux droites et deux demi-cercles) de rayon r
#let stadium(r, steps: 40) = {
  let right = range(steps + 1).map(i => {
    let t = -90deg + 180deg * i / steps
    (x-end + r * calc.cos(t), cy + r * calc.sin(t))
  })
  let left = range(steps + 1).map(i => {
    let t = 90deg + 180deg * i / steps
    (x-start + r * calc.cos(t), cy + r * calc.sin(t))
  })
  right + left
}

// Échelle choisie pour que la figure soit à peine réduite dans la page :
// le texte garde ainsi sa taille réelle.
#cetz.canvas(length: 0.62cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let x-shade = palette.red
  let y-shade = palette.green
  let path-shade = palette.blue

  // Piste (couloir ocre) et terrain intérieur (vert)
  line(
    ..stadium(43).map(s),
    close: true,
    fill: rgb("#e8b4a0"),
    stroke: 0.8pt + rgb("#b0705a"),
  )
  line(
    ..stadium(27).map(s),
    close: true,
    fill: palette.green.fill,
    stroke: 0.8pt + rgb("#b0705a"),
  )

  // Axes
  let axis-stroke = 0.8pt + ink
  line((0, 0), (17.6, 0), stroke: axis-stroke, mark: (
    end: "stealth",
    fill: ink,
    stroke: ink,
  ))
  line((0, 0), (0, 9.3), stroke: axis-stroke, mark: (
    end: "stealth",
    fill: ink,
    stroke: ink,
  ))
  content((17.6, 0), anchor: "north-east", padding: 0.12, text(
    size: 11pt,
    fill: ink,
    [$x$ (#unit[m])],
  ))
  content((0, 9.3), anchor: "north-west", padding: 0.12, text(
    size: 11pt,
    fill: ink,
    [$y$ (#unit[m])],
  ))
  content((0, 0), anchor: "north-east", padding: 0.12, text(
    size: 11pt,
    fill: ink,
  )[O])

  // Projections de A et B sur les axes
  let dashed(shade) = (paint: shade.line, thickness: 1pt, dash: "dashed")
  for p in (a, b) {
    line(s(p), s((p.at(0), 0)), stroke: dashed(x-shade))
    line(s(p), s((0, p.at(1))), stroke: dashed(y-shade))
  }
  let component(from, to, shade, label, anchor) = {
    line(
      s(from),
      s(to),
      stroke: (paint: shade.line, thickness: 2.4pt),
      mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.2),
      name: "c",
    )
    content("c.mid", anchor: anchor, padding: 0.15, text(
      size: 10pt,
      fill: shade.text,
      label,
    ))
  }
  component((a.at(0), 0), (b.at(0), 0), x-shade, qty[20][m], "north")
  component((0, a.at(1)), (0, b.at(1)), y-shade, qty[70][m], "east")
  // Graduations poussées vers l'extérieur pour laisser la place à « 20 m »
  for (v, anchor) in ((a.at(0), "north-east"), (b.at(0), "north-west")) {
    content(s((v, 0)), anchor: anchor, padding: 0.45, text(
      size: 10pt,
      fill: x-shade.text,
    )[#v])
  }
  for v in (a.at(1), b.at(1)) {
    content(s((0, v)), anchor: "east", padding: 0.55, text(
      size: 10pt,
      fill: y-shade.text,
    )[#v])
  }

  // Distance parcourue : de A jusqu'au virage, le virage, puis jusqu'à B
  let turn = range(41).map(i => {
    let t = -90deg + 180deg * i / 40
    (x-end + lane-r * calc.cos(t), cy + lane-r * calc.sin(t))
  })
  line(
    ..(a, ..turn, b).map(s),
    stroke: (paint: path-shade.line, thickness: 3pt, join: "round"),
    mark: (
      end: "stealth",
      fill: path-shade.line,
      stroke: path-shade.line,
      scale: 1.4,
    ),
  )
  content(s((x-end + lane-r, cy)), anchor: "west", padding: 1.0, text(
    size: 10pt,
    fill: path-shade.text,
    weight: "semibold",
    align(center)[distance \ parcourue \ #sym.approx #qty[220][m]],
  ))

  // Déplacement AB
  line(
    s(a),
    s(b),
    stroke: (paint: palette.dark.line, thickness: 2.6pt),
    mark: (
      end: "stealth",
      fill: palette.dark.line,
      stroke: palette.dark.line,
      scale: 1.5,
    ),
    name: "ab",
  )
  content("ab.mid", anchor: "west", padding: 0.2, text(
    size: 11pt,
    $arrow(A B)$,
  ))

  for (p, label, anchor) in ((a, $A$, "north-west"), (b, $B$, "south-west")) {
    circle(s(p), radius: 0.09, fill: palette.dark.line, stroke: 1pt + white)
    content(s(p), anchor: anchor, padding: 0.12, text(
      size: 12pt,
      weight: "bold",
      label,
    ))
  }
})
