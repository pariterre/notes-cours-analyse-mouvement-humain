#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Plongeur en haut de la tour de 10 m : la hauteur est mesurée à partir de
// la surface de l'eau (référence de l'énergie potentielle de pesanteur).
// Échelle : 1 unité = 2 m (le plongeur est agrandi pour être visible).

#let s = 0.5 // unités par mètre
#let tower-h = 10

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let y-top = tower-h * s
  let (x-edge, x-tower) = (0, 1.6) // bord du plongeoir, pied de la tour

  // Bassin
  let water = palette.blue
  rect((-3.4, -1.0), (2.6, 0), fill: water.fill, stroke: none)
  for k in range(6) {
    let x = -3.2 + k * 1.0
    bezier((x, 0), (x + 1.0, 0), (x + 0.25, 0.12), (x + 0.75, -0.12), stroke: 1.2pt + water.line)
  }
  content((0.6, -0.5), text(size: 10pt, fill: water.text, style: "italic")[eau])

  // Tour et plateforme
  let concrete = (fill: palette.neutral.fill.darken(10%), stroke: 1pt + palette.neutral.line)
  rect((x-tower, -1.0), (x-tower + 0.8, y-top + 0.2), ..concrete)
  rect((x-edge, y-top - 0.25), (x-tower + 0.8, y-top), ..concrete)

  // Plongeur au bord, face à l'eau, sur la pointe des pieds, genoux un peu
  // fléchis, penché vers l'avant (flexion du tronc et des hanches), bras
  // tendus vers l'avant
  let diver-size = 1.75 * s * 2.2
  let pose = (
    // Tout le corps légèrement basculé vers l'avant : le bassin reste
    // au-dessus des pieds
    global: (pitch: 12deg),
    trunk: 28deg,
    head: 10deg,
    hip-r: 15deg,
    hip-l: 15deg,
    knee-r: 25deg,
    knee-l: 25deg,
    ankle-r: -25deg,
    ankle-l: -25deg,
    shoulder-r: 150deg,
    shoulder-l: 150deg,
    elbow-r: 5deg,
    elbow-l: 5deg,
  )
  // Les orteils (point le plus bas) reposent sur le plongeoir
  let p = mannequin-points(pose: pose, size: diver-size)
  let lowest = calc.min(..("heel-r", "heel-l", "toe-r", "toe-l").map(k => p.at(k).at(2)))
  mannequin(
    size: diver-size,
    // Orteils au bord du plongeoir. Le plongeur regarde vers la gauche
    // (azimut 90°) : l'avant du corps (x) est vers la gauche à l'écran
    origin: (x-edge + 0.05 + calc.max(p.toe-r.at(0), p.toe-l.at(0)), y-top - lowest),
    view: (azimuth: 90deg),
    pose: pose,
    name: "plongeur",
  )
  content((x-edge + 0.95, y-top + 1.3), anchor: "west", text(size: 12pt, fill: ink)[$m = #qty[60][kg]$])

  // Hauteur au-dessus de la surface de l'eau
  let x-dim = -1.3
  line((x-dim, 0), (x-dim, y-top), stroke: 1.2pt + palette.red.line, mark: (
    start: "stealth",
    end: "stealth",
    fill: palette.red.line,
    stroke: palette.red.line,
  ))
  line((x-dim - 0.2, y-top), (x-edge, y-top), stroke: (paint: ink.transparentize(40%), thickness: 0.6pt, dash: "dotted"))
  content((x-dim, y-top / 2), anchor: "east", padding: 0.15, text(size: 13pt, fill: palette.red.text)[$h = #qty[10][m]$])

  // Référence
  content((x-dim, 0), anchor: "north-east", padding: (top: 0.15, right: 0.1), text(
    size: 10pt,
    fill: ink,
    style: "italic",
  )[référence : $h = 0$])
})
