#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Force de 5 N décomposée en F_x = 4 N et F_y = 3 N (1 N = 1 unité)
#cetz.canvas(length: 0.9cm, {
  import cetz.draw: *

  let (fx, fy) = (4, 3)
  let angle = calc.atan2(fx, fy) // (pas `theta` : masquerait θ en mode math)

  let vector(to, shade, width: 2pt) = line(
    (0, 0),
    to,
    stroke: (paint: shade.line, thickness: width, cap: "round"),
    mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.3),
  )

  // Parallélogramme (rectangle) de construction
  let guide = (paint: palette.neutral.line, thickness: 0.7pt, dash: "dashed")
  line((fx, 0), (fx, fy), stroke: guide)
  line((0, fy), (fx, fy), stroke: guide)

  // Angle θ entre l'horizontale et la force
  arc(
    (0, 0),
    start: 0deg,
    stop: angle,
    radius: 1.3,
    anchor: "origin",
    mode: "PIE",
    fill: palette.blue.fill,
    stroke: 1pt + palette.blue.line,
  )
  // Valeur de l'angle, juste à l'extérieur du secteur
  let label-r = 1.4
  content(
    (label-r * calc.cos(angle / 2), label-r * calc.sin(angle / 2)),
    anchor: "west",
    text(fill: palette.blue.text)[$theta approx #to-degree(36.9)$],
  )

  // Composantes puis force résultante
  vector((fx, 0), palette.red)
  vector((0, fy), palette.green)
  vector((fx, fy), palette.gold, width: 2.5pt)

  content((fx, 0), anchor: "north", padding: 0.15, text(fill: palette.red.text)[
    $F_x = #qty[4][N]$
  ])
  content((0, fy), anchor: "east", padding: 0.15, text(fill: palette.green.text)[
    $F_y = #qty[3][N]$
  ])
  content((fx, fy), anchor: "south-west", padding: 0.1, text(fill: palette.gold.text)[
    $norm(arrow(F)) = #qty[5][N]$
  ])
})
