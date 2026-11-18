#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Boulet de masse m lâché en (x_i, y_i) avec une vitesse v_i faisant un
// angle θ avec l'horizontale. La vitesse se décompose en v_x_i (horizontale)
// et v_y_i (verticale); la seule force est le poids W = m g.
// Couleurs reprises dans la figure de trigonométrie qui suit :
// horizontale/adjacent en vert, verticale/opposé en rouge, v_i/hypoténuse en or.

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let theta = 40deg
  let v-len = 3.0
  let p = (2.2, 2.4) // point de lâcher (x_i, y_i)
  let (px, py) = p
  let vx = v-len * calc.cos(theta)
  let vy = v-len * calc.sin(theta)

  // Sol
  line((-0.4, 0), (11.4, 0), stroke: 0.8pt + ink)
  for i in range(24) {
    let x = -0.2 + i * 0.5
    line((x, 0), (x - 0.25, -0.25), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Trajectoire parabolique (tangente à v_i au point de lâcher)
  // y = y_i + tan(θ)·Δx − c·Δx², c choisi pour atterrir à Δx ≈ 8.4
  let c = (py + 8.4 * calc.tan(theta)) / (8.4 * 8.4)
  let traj = range(0, 85).map(i => {
    let dx = i * 0.1
    (px + dx, py + dx * calc.tan(theta) - c * dx * dx)
  }).filter(((x, y)) => y >= 0)
  line(..traj, stroke: (paint: ink.transparentize(45%), thickness: 1.2pt, dash: "dashed"))
  content(traj.at(calc.floor(traj.len() * 0.72)), anchor: "south-west", padding: 0.15, text(
    size: 10pt,
    fill: ink,
    style: "italic",
  )[trajectoire])

  // Repère x O y
  let axis(to) = line((0, 0), to, stroke: 1pt + ink, mark: (end: "stealth", fill: ink, stroke: ink, scale: 1.2))
  axis((11.6, 0))
  axis((0, 6.4))
  content((11.6, 0), anchor: "north-east", padding: 0.15, text(size: 12pt, fill: ink, $x$))
  content((0, 6.4), anchor: "north-east", padding: 0.15, text(size: 12pt, fill: ink, $y$))
  content((0, 0), anchor: "north-east", padding: 0.15, text(size: 12pt, fill: ink, $O$))

  // Position initiale : guides vers les axes
  let guide = (paint: ink.transparentize(40%), thickness: 0.7pt, dash: "dotted")
  line(p, (px, 0), stroke: guide)
  line(p, (0, py), stroke: guide)
  content((px, 0), anchor: "north", padding: 0.2, text(size: 12pt, fill: ink, $x_i$))
  content((0, py), anchor: "east", padding: 0.15, text(size: 12pt, fill: ink, $y_i$))

  // Rectangle des composantes
  let tip = (px + vx, py + vy)
  let comp-guide = (paint: ink.transparentize(50%), thickness: 0.7pt, dash: "dashed")
  line((px + vx, py), tip, (px, py + vy), stroke: comp-guide)

  // Angle θ
  let r = 0.95
  let arc-pts = range(0, 21).map(i => {
    let a = theta * i / 20
    (px + r * calc.cos(a), py + r * calc.sin(a))
  })
  line(p, ..arc-pts, close: true, fill: palette.gold.fill, stroke: none)
  line(..arc-pts, stroke: 0.8pt + palette.gold.line)
  content((px + (r + 0.3) * calc.cos(theta / 2), py + (r + 0.3) * calc.sin(theta / 2)), text(
    size: 12pt,
    fill: ink,
    $θ$,
  ))

  // Vecteurs vitesse
  let vector(to, shade, width: 2.4pt) = line(p, to, stroke: (paint: shade.line, thickness: width), mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.3,
  ))
  vector((px + vx, py), palette.green)
  vector((px, py + vy), palette.red)
  vector(tip, palette.gold, width: 2.8pt)
  content((px + vx, py), anchor: "north-west", padding: 0.12, text(size: 12pt, fill: palette.green.text, $v_x_i$))
  content((px, py + vy), anchor: "east", padding: 0.15, text(size: 12pt, fill: palette.red.text, $v_y_i$))
  content(tip, anchor: "south-west", padding: 0.12, text(size: 12pt, fill: palette.gold.text, $arrow(v_i)$))

  // Poids
  line(p, (px, py - 1.6), stroke: (paint: palette.dark.line, thickness: 2.4pt), mark: (
    end: "stealth",
    fill: palette.dark.line,
    stroke: palette.dark.line,
    scale: 1.3,
  ))
  content((px, py - 1.6), anchor: "west", padding: 0.2, text(size: 12pt, $arrow(W) = m arrow(g)$))

  // Boulet
  circle(p, radius: 0.24, fill: palette.dark.fill, stroke: 1pt + white)
  content((px - 0.24, py + 0.1), anchor: "south-east", padding: 0.05, text(size: 12pt, fill: ink, $m$))
})
