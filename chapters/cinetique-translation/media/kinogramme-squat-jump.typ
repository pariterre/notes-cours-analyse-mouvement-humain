#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "squat-jump-poses.typ": squat-pose-at
#import "@preview/cetz:0.4.1"


// Kinogramme de la phase d'impulsion d'un squat jump : le mannequin à
// intervalles de temps réguliers, de t_i à t_f (poses partagées avec la
// figure de la résultante cinétique, voir squat-jump-poses.typ). Les images
// anciennes sont estompées. Le talon reste fixe au sol.

#let size = 4.2
#let n = 6 // nombre d'images

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let slot = 2.6 // largeur d'une case (un intervalle de temps)
  let frames = range(n).map(i => {
    let u = i / (n - 1)
    let pose = squat-pose-at(u)
    let p = mannequin-points(pose: pose, size: size)
    // Talon à l'abscisse de la case, au sol
    let origin = (i * slot - p.heel-r.at(0), -calc.min(p.heel-r.at(2), p.toe-r.at(2)))
    (pose: pose, origin: origin, x: i * slot, u: u)
  })

  // Sol
  let (x-min, x-max) = (-1.2, (n - 1) * slot + 1.6)
  rect((x-min, -0.2), (x-max, 0), fill: palette.neutral.fill, stroke: none)
  line((x-min, 0), (x-max, 0), stroke: 1pt + palette.neutral.line)

  for (i, f) in frames.enumerate() {
    // Couleur liée au temps : de estompée (t_i) à pleine (t_f)
    let color = rgb("#5c6bc0").lighten(60% * (1 - f.u))
    mannequin(size: size, origin: f.origin, view: (azimuth: -90deg), pose: f.pose, color: color, name: "f" + str(i))
  }

  // Axe du temps
  let y = -0.45
  line((x-min, y), (x-max, y), stroke: 0.8pt + palette.neutral.text, mark: (end: "stealth", fill: palette.neutral.text))
  for (i, f) in frames.enumerate() {
    line((f.x + 0.4, y), (f.x + 0.4, y - 0.15), stroke: 0.8pt + palette.neutral.text)
  }
  content((frames.first().x + 0.4, y - 0.2), anchor: "north")[$t_i$]
  content((frames.last().x + 0.4, y - 0.2), anchor: "north")[$t_f$]
  content((x-max, y), anchor: "south-east", padding: 0.08, text(size: 10pt)[temps])
})
