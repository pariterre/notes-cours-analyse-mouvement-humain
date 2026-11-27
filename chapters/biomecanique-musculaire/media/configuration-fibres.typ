#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Muscle fusiforme (fibres parallèles à l'axe du muscle) et muscle penné
// (fibres obliques, angle de pennation α). La section physiologique
// (perpendiculaire aux fibres) est plus grande pour le muscle penné : plus de
// force. Le raccourcissement se fait selon la direction des fibres.

#let muscle = palette.red
#let tendon = 2.4pt + palette.dark.fill
#let fibre = 0.7pt + muscle.line
#let section = palette.green
#let shortening = palette.blue

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (width, height) = (1.6, 3.6) // dimensions du muscle (unités du dessin)
  let double-arrow = (start: "stealth", end: "stealth", fill: section.line, scale: 0.8)
  let arrow = (end: "stealth", fill: shortening.line, scale: 0.8)

  // --- Muscle fusiforme
  rect((0, 0), (width, height), fill: muscle.fill, stroke: none)
  let n = 6
  for i in range(1, n) {
    let x = i * width / n
    line((x, 0), (x, height), stroke: fibre)
  }
  line((0, 0), (0, height), stroke: fibre)
  line((width, 0), (width, height), stroke: fibre)
  line((-0.05, 0), (width + 0.05, 0), stroke: tendon)
  line((-0.05, height), (width + 0.05, height), stroke: tendon)

  // Section physiologique (perpendiculaire aux fibres)
  line((-0.15, height / 2), (width + 0.15, height / 2), stroke: 1.6pt + section.line, mark: double-arrow)
  // Raccourcissement (selon les fibres)
  line((width + 0.35, 0.05), (width + 0.35, 0.75), stroke: 1.6pt + shortening.line, mark: arrow)

  content((width / 2, -0.4), anchor: "north", text(weight: "semibold")[Muscle fusiforme])

  // --- Muscle penné
  let x0 = 4.2
  let rise = 1.0 // décalage vertical entre les deux aponévroses
  let left(y) = (x0, y)
  let right(y) = (x0 + width, y + rise)
  line(left(0), left(height), right(height), right(0), close: true, fill: muscle.fill, stroke: none)
  let m = 10
  for i in range(m + 1) {
    let y = i * height / m
    line(left(y), right(y), stroke: fibre)
  }
  line(left(-0.05), left(height + 0.05), stroke: tendon)
  line(right(-0.05), right(height + 0.05), stroke: tendon)

  // Angle de pennation α, entre l'axe du muscle et les fibres
  let pennation = calc.atan2(rise, width) // angle depuis la verticale
  line(left(height), left(height + 1.1), stroke: 0.7pt + palette.neutral.text)
  arc(left(height), start: 90deg, stop: 90deg - pennation, radius: 0.6, anchor: "origin", stroke: 0.7pt + palette.neutral.text)
  content((x0 + 0.42, height + 0.75), anchor: "south-west", padding: 0.02)[$alpha$]

  // Section physiologique : perpendiculaire aux fibres, d'une aponévrose à l'autre
  let t = width // paramètre le long de la normale (1, -width/rise)
  line(left(height), (x0 + t, height - t * width / rise), stroke: 1.6pt + section.line, mark: double-arrow)
  // Raccourcissement : l'aponévrose est tirée selon la direction des fibres
  let dir = (width, rise).map(v => v / calc.sqrt(width * width + rise * rise))
  let (ax, ay) = (x0 + width + 0.45, rise - 0.25)
  line((ax, ay), (ax - 0.75 * dir.at(0), ay - 0.75 * dir.at(1)), stroke: 1.6pt + shortening.line, mark: arrow)

  content((x0 + width / 2, -0.4), anchor: "north", text(weight: "semibold")[Muscle penné])

  // --- Légende
  let ly = -1.3
  line((0, ly), (1.1, ly), stroke: 1.6pt + section.line, mark: double-arrow)
  content((1.25, ly), anchor: "west", text(size: 9pt)[Section physiologique (force)])
  line((0, ly - 0.5), (1.1, ly - 0.5), stroke: 1.6pt + shortening.line, mark: arrow)
  content((1.25, ly - 0.5), anchor: "west", text(size: 9pt)[Raccourcissement (déplacement)])
})
