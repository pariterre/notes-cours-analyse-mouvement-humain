#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"
#import "sarcomere.typ": actin, myosin, sarcomere as draw-sarcomere


// Sarcomère relâché et contracté : les filaments fins d'actine (attachés aux
// stries Z) glissent le long des filaments épais de myosine, dont les têtes
// forment des ponts actomyosine. Les filaments gardent la même longueur ;
// seul leur chevauchement change.

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let sarcomere(y0, half) = draw-sarcomere((0, y0), half)

  let (y-relaxed, y-contracted) = (0, -4.2)
  let (half-relaxed, half-contracted) = (3.1, 2.25)
  sarcomere(y-relaxed, half-relaxed)
  sarcomere(y-contracted, half-contracted)

  // Longueur du sarcomère
  let span(y, half) = {
    line((-half, y), (half, y), stroke: 0.8pt + palette.neutral.text, mark: (
      start: "stealth",
      end: "stealth",
      fill: palette.neutral.text,
      scale: 0.6,
    ))
    content((0, y), anchor: "south", padding: 0.08, text(size: 9pt)[Sarcomère])
  }
  span(y-relaxed + 1.7, half-relaxed)
  span(y-contracted + 1.7, half-contracted)

  // Titres
  content((-half-relaxed - 0.5, y-relaxed), anchor: "east", text(weight: "semibold")[Relâché])
  content((-half-relaxed - 0.5, y-contracted), anchor: "east", text(weight: "semibold")[Contracté])

  // Glissement : les stries Z se rapprochent
  for side in (-1, 1) {
    line(
      (side * (half-contracted + 0.95), y-contracted),
      (side * (half-contracted + 0.38), y-contracted),
      stroke: 1.4pt + palette.neutral.text,
      mark: (end: "stealth", fill: palette.neutral.text, scale: 0.7),
    )
  }

  // Étiquettes (sur le sarcomère relâché)
  let label(target, at, anchor, body) = {
    line(at, target, stroke: 0.6pt + palette.neutral.text)
    content(at, anchor: anchor, padding: 0.08, text(size: 9pt, body))
  }
  let right = half-relaxed + 0.5
  label((half-relaxed, 1.2), (right, 1.5), "west")[Strie Z]
  label((half-relaxed - 0.5, 1), (right, 0.8), "west", text(fill: actin.text)[Actine (filament fin)])
  label((1.2, -0.5), (right, -0.2), "west", text(fill: myosin.text)[Myosine (filament épais)])
  label((1.69, -1), (right, -0.95), "west", text(fill: myosin.text)[Pont actomyosine])
})
