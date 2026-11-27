#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"
#import "sarcomere.typ": actin-length, bare-zone, myosin-half, sarcomere


// Relation force-longueur active d'un sarcomère, découpée en trois zones :
// la force augmente (raccourci), reste maximale (longueur optimale), puis
// diminue (étiré). Sous chaque zone, un sarcomère à cette longueur explique la
// force par le nombre de ponts actomyosine possibles.
//
// La courbe découle de la géométrie du sarcomère (sarcomere.typ) : plateau
// tant que toutes les têtes de myosine font face à l'actine, force nulle
// quand l'actine ne recouvre plus la myosine.

#let rising = palette.blue
#let plateau = palette.green
#let falling = palette.gold

// Bornes des zones (demi-longueur du sarcomère)
// Montée en deux temps (Gordon, Huxley et Julian, 1966) : d'abord douce
// tant que seule l'actine se croise au centre, puis raide dès que la myosine
// bute sur les stries Z et se comprime, jusqu'à une force nulle.
#let h-abut = myosin-half // la myosine bute sur les stries Z
#let h-min = 0.8 * myosin-half // myosine comprimée : force nulle
#let h-opt-start = actin-length // l'actine ne se croise plus au centre
#let h-opt-end = actin-length + bare-zone // toutes les têtes font encore face à l'actine
#let h-max = actin-length + myosin-half // plus aucun recouvrement : force nulle

// Force relative (0 à 1) selon la demi-longueur h du sarcomère
#let force(h) = {
  let pts = (
    (h-min, 0),
    (h-abut, 0.8),
    (h-opt-start, 1),
    (h-opt-end, 1),
    (h-max, 0),
  )
  if h <= pts.first().at(0) or h >= pts.last().at(0) { return 0 }
  for i in range(pts.len() - 1) {
    let ((h0, f0), (h1, f1)) = (pts.at(i), pts.at(i + 1))
    if h <= h1 { return f0 + (f1 - f0) * (h - h0) / (h1 - h0) }
  }
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Repère : x en demi-longueur de sarcomère, y en force relative
  let (h0, h1) = (h-min - 0.2, h-max + 0.25)
  let (kx, ky) = (5, 3.2) // échelles (cm par unité)
  let p(h, f) = ((h - h0) * kx, f * ky)
  let width = (h1 - h0) * kx

  // Zones colorées
  let zones = (
    (h0, h-opt-start, rising, [La force augmente]),
    (h-opt-start, h-opt-end, plateau, [Force maximale]),
    (h-opt-end, h1, falling, [La force diminue]),
  )
  for (a, b, shade, title) in zones {
    rect(p(a, 0), p(b, 1.12), fill: shade.fill, stroke: none)
  }
  for (a, b, shade, title) in zones {
    content(p((a + b) / 2, 1.12), anchor: "south", padding: 0.08, text(
      size: 8.5pt,
      fill: shade.text,
      weight: "semibold",
      title,
    ))
  }

  // Courbe force-longueur
  let curve = range(0, 201).map(i => {
    let h = h0 + i / 200 * (h1 - h0)
    p(h, force(h))
  })
  line(..curve, stroke: 1.8pt + palette.dark.fill)

  // Axes
  let axis-mark = (end: "stealth", fill: black)
  line(p(h0, 0), (width + 0.4, 0), stroke: 1.2pt + black, mark: axis-mark)
  line(p(h0, 0), (0, 1.12 * ky + 0.9), stroke: 1.2pt + black, mark: axis-mark)
  content(
    (width + 0.4, 0 - 0.6),
    anchor: "south-east",
    padding: 0.12,
  )[Longueur du sarcomère]
  content((0, 1.12 * ky + 0.9), anchor: "east", padding: 0.12)[Force]
  content(
    p((h-opt-start + h-opt-end) / 2, 0),
    anchor: "north",
    padding: 0.12,
  )[$L_"opt"$]

  // Sarcomères représentatifs sous chaque zone
  let samples = (
    (
      (h-min + h-abut) / 2,
      rising,
      [Très raccourci],
      [La myosine bute sur les stries Z et se comprime : très peu de ponts.],
    ),
    (
      (h-abut + h-opt-start) / 2,
      rising,
      [Raccourci],
      [L'actine se croise au centre et gêne une partie des ponts.],
    ),
    (
      (h-opt-start + h-opt-end) / 2,
      plateau,
      [Longueur optimale],
      [Toutes les têtes de myosine font face à l'actine : nombre de ponts maximal.],
    ),
    (
      h-max - 0.8,
      falling,
      [Étiré],
      [L'actine ne recouvre plus qu'une partie de la myosine : moins de ponts.],
    ),
  )
  let factor = 0.5
  let columns = range(4).map(i => (2 * i + 1) * width / 8)
  let (y-title, y-sarcomere, y-text) = (-1.2, -2.3, -3.2)
  for ((h, shade, title, body), cx) in samples.zip(columns) {
    // Point sur la courbe relié à son sarcomère
    let point = p(h, force(h))
    line(point, (cx, y-title + 0.25), stroke: (
      paint: shade.line,
      thickness: 0.8pt,
      dash: "dashed",
    ))
    circle(point, radius: 0.09, fill: shade.line, stroke: none)

    content((cx, y-title), anchor: "south", text(
      size: 9pt,
      fill: shade.text,
      weight: "semibold",
      title,
    ))
    sarcomere((cx, y-sarcomere), h, factor: factor)
    content((cx, y-text), anchor: "north", box(width: 3.3cm, align(center, text(
      size: 8.5pt,
      body,
    ))))
  }
})
