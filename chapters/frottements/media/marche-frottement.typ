#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Marche, phase de poussée : le pied arrière pousse le sol vers l'arrière;
// en réaction, le frottement (statique) du sol sur le pied est dirigé vers
// l'avant et propulse la personne. Sans ce frottement (sur la glace), le pied
// glisserait vers l'arrière.
// Frottement en rouge, comme dans les autres figures du chapitre.

#let size = 4.0
#let view = (azimuth: -90deg) // regarde vers la droite

// Poussée : jambe droite en arrière, sur la pointe du pied; jambe gauche en
// avant; bras opposés aux jambes
#let pose = (
  global: (pitch: 6deg),
  hip-r: -18deg,
  knee-r: 8deg,
  ankle-r: -28deg,
  hip-l: 28deg,
  knee-l: 35deg,
  ankle-l: 5deg,
  shoulder-r: 30deg,
  shoulder-l: -30deg,
  elbow-r: 30deg,
  elbow-l: 20deg,
  trunk: 5deg,
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let p = mannequin-points(pose: pose, size: size)
  // Pointe du pied arrière posée au sol, à l'origine du dessin
  let toe = p.toe-r
  let origin = (-toe.at(0), -toe.at(2))

  // Sol
  line((-3.6, 0), (3.8, 0), stroke: 1pt + ink)
  for i in range(25) {
    let x = -3.5 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  mannequin(size: size, origin: origin, view: view, pose: pose, name: "m")

  // Forces au contact du pied arrière, juste sous le sol : de part et
  // d'autre du point de contact, dans des sens opposés
  let f-len = 1.4
  let y = -0.75 // assez bas pour que les étiquettes (deux lignes) restent sous le sol
  line((0, 0), (0, y), stroke: (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted"))
  line((0, y), (-f-len, y), stroke: 2.6pt + palette.neutral.line, mark: (
    end: "stealth",
    fill: palette.neutral.line,
    stroke: palette.neutral.line,
    scale: 1.2,
  ))
  content((-f-len, y), anchor: "east", padding: 0.12, text(size: 11pt, fill: palette.neutral.text, align(right)[poussée du pied \ sur le sol]))
  line((0, y), (f-len, y), stroke: 2.6pt + palette.red.line, mark: (
    end: "stealth",
    fill: palette.red.line,
    stroke: palette.red.line,
    scale: 1.2,
  ))
  content((f-len, y), anchor: "west", padding: 0.12, text(size: 11pt, fill: palette.red.text, align(left)[frottement du sol \ sur le pied]))
  circle((0, 0), radius: 0.07, fill: ink, stroke: 1pt + white)

  // Sens de la marche
  line((2.2, 3.6), (3.4, 3.6), stroke: 1.2pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
  content((2.8, 3.6), anchor: "south", padding: 0.1, text(size: 10pt, fill: ink, style: "italic")[sens de la marche])
})
