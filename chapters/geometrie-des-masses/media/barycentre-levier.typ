#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"
#import "levier-commun.typ": bar, com, depth, mass, pivot


#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  // Les côtés des cubes (1.3 et 1.0) donnent un rapport de masses
  // d'environ 2.2 : l'équilibre impose donc OB = 2.2 OA.
  let (side-a, side-b) = (1.3, 1.0)
  let (xa, xo, xb) = (1, 3.35, 8.5)
  let height = 0.45
  let y = 0.6

  pivot((xo, y))
  bar((0, y), 9.3, height: height)
  com((xo, y + height / 2), radius: 0.09)

  // Les masses reposent au milieu de la profondeur de la barre
  let top = y + height + depth.at(1) / 2
  let shift = depth.at(0) / 2
  mass((xa - side-a / 2 + shift, top), side-a)
  mass((xb - side-b / 2 + shift, top), side-b)

  let label(pos, anchor, body) = content(pos, anchor: anchor, text(
    size: 12pt,
    body,
  ))
  label((xa + 0.4, top + side-a + 0.4), "south", $m_A$)
  label((xb + 0.4, top + side-b + 0.4), "south", $m_B$)
  label((xa, y - 0.15), "north", $A$)
  label((xb, y - 0.15), "north", $B$)
  label((xo + 0.45, y - 0.3), "west", $O$)
})
