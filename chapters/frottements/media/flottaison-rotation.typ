#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Flottaison du corps humain. Allongé à la surface, le centre de masse (où
// s'applique le poids, vers le bassin) et le centre de volume (où s'applique
// la poussée d'Archimède, plus près du thorax à cause de l'air des poumons)
// ne sont pas alignés verticalement : le couple fait tourner le corps (les
// jambes s'enfoncent) jusqu'à ce que les deux forces soient sur la même
// verticale (équilibre des moments).
// Poids en gris, poussée d'Archimède en bleu (comme la figure des cubes),
// rotation en rouge. L'eau est dessinée par-dessus le corps (partie immergée
// teintée).

#let size = 4.2
#let buoyancy-shift = 0.09 // centre de volume, vers la tête (fraction de la taille)
#let force-len = 1.2

#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let water = palette.blue
  let vec(from, to, paint) = line(from, to, stroke: 2.4pt + paint, mark: (end: "stealth", fill: paint, stroke: paint, scale: 1.1))

  // --- Allongé sur le dos, tête à droite (regarde vers la gauche, basculé
  // vers l'arrière de 90°) : écran x = −X, écran y = Z
  let lying = (global: (pitch: -90deg), shoulder-r: 8deg, shoulder-l: 8deg, head: -10deg)
  let p = mannequin-points(pose: lying, size: size)
  let screen(q) = (-q.at(0), q.at(2))
  let com = screen(p.com)
  // Centre de masse juste sous la surface (y = 0)
  let origin-a = (-1.6 - com.at(0), -0.12 - com.at(1))
  let at-a(q) = (origin-a.at(0) + screen(q).at(0), origin-a.at(1) + screen(q).at(1))
  mannequin(size: size, origin: origin-a, view: (azimuth: 90deg), pose: lying, name: "a")

  // --- Après rotation : corps incliné (jambes enfoncées), visage à la
  // surface; même orientation que le corps allongé, basculé de 55° seulement
  let tilted = (global: (pitch: -55deg), hip-r: 10deg, hip-l: 10deg, knee-r: 15deg, knee-l: 15deg, shoulder-r: 15deg, shoulder-l: 15deg, elbow-r: 15deg, elbow-l: 15deg, head: -15deg)
  let q = mannequin-points(pose: tilted, size: size)
  // Visage juste à la surface
  let origin-b = (6.0 - screen(q.com-head).at(0), 0.05 - screen(q.com-head).at(1))
  let at-b(r) = (origin-b.at(0) + screen(r).at(0), origin-b.at(1) + screen(r).at(1))
  mannequin(size: size, origin: origin-b, view: (azimuth: 90deg), pose: tilted, name: "b")

  // Eau (par-dessus les corps : la partie immergée est teintée)
  let (left, right, bottom) = (-4.4, 7.0, -3.4)
  rect((left, bottom), (right, 0), fill: water.line.transparentize(85%), stroke: none)
  line((left, 0), (right, 0), stroke: 1.2pt + water.line)

  // Forces, allongé : poids au centre de masse, poussée au centre de volume
  let com-a = at-a(p.com)
  let cob-a = (com-a.at(0) + buoyancy-shift * size, com-a.at(1))
  vec(com-a, (com-a.at(0), com-a.at(1) - force-len), palette.neutral.line)
  content((com-a.at(0), com-a.at(1) - force-len), anchor: "north", padding: 0.1, text(size: 12pt, fill: palette.neutral.text)[$arrow(W)$])
  vec(cob-a, (cob-a.at(0), cob-a.at(1) + force-len), water.line)
  content((cob-a.at(0), cob-a.at(1) + force-len), anchor: "south", padding: 0.1, text(size: 12pt, fill: water.text)[$arrow(P)_A$])
  circle(com-a, radius: 0.06, fill: ink, stroke: 0.8pt + white)
  circle(cob-a, radius: 0.06, fill: water.line, stroke: 0.8pt + white)

  // Rotation (sens antihoraire : la tête monte, les jambes s'enfoncent)
  let c = ((com-a.at(0) + cob-a.at(0)) / 2, com-a.at(1))
  let arc = range(0, 31).map(i => {
    let a = 20deg + 140deg * i / 30
    (c.at(0) + 1.25 * calc.cos(a), c.at(1) + 0.15 + 0.75 * calc.sin(a))
  })
  line(..arc, stroke: 2pt + palette.red.line, mark: (end: "stealth", fill: palette.red.line, stroke: palette.red.line))

  // Transition
  line((0.95, -0.9), (2.05, -0.9), stroke: 1.4pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
  content((1.5, -1.05), anchor: "north", text(size: 10pt, fill: ink, style: "italic", align(center)[rotation \ jusqu'à \ l'équilibre]))

  // Forces après rotation : sur la même verticale (équilibre des moments)
  let com-b = at-b(q.com)
  let cob-b = (com-b.at(0), com-b.at(1) + buoyancy-shift * size)
  vec(com-b, (com-b.at(0), com-b.at(1) - force-len), palette.neutral.line)
  content((com-b.at(0) + 0.15, com-b.at(1) - force-len + 0.15), anchor: "west", text(size: 12pt, fill: palette.neutral.text)[$arrow(W)$])
  vec(cob-b, (cob-b.at(0), cob-b.at(1) + force-len), water.line)
  content((cob-b.at(0) + 0.15, cob-b.at(1) + force-len - 0.1), anchor: "west", text(size: 12pt, fill: water.text)[$arrow(P)_A$])
  circle(com-b, radius: 0.06, fill: ink, stroke: 0.8pt + white)
  circle(cob-b, radius: 0.06, fill: water.line, stroke: 0.8pt + white)

  // Légende des points
  content((left + 0.1, bottom + 0.55), anchor: "west", text(size: 9.5pt, fill: ink)[#box(std.circle(radius: 2.5pt, fill: ink)) centre de masse #h(10pt) #box(std.circle(radius: 2.5pt, fill: water.line)) centre de volume])
})
