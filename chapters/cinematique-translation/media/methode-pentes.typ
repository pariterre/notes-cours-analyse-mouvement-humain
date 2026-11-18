#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Méthode des pentes : la position est faite de segments de droite; sur
// chaque segment, la pente (Δx / Δt) est constante et donne directement la
// vitesse, d'où une vitesse « en escalier ».
//   - plateau de position      → vitesse nulle
//   - montée raide / douce     → vitesse grande / petite
//   - descente                 → vitesse négative

// Points de la courbe de position : (temps en s, position en m)
// Le mouvement commence par un court temps d'immobilité
#let points = (
  (0, 0),
  (0.8, 0),
  (2.6, 1.2),
  (3.3, 3),
  (5.2, 3),
  (6.2, 2),
  (7.2, 2.5),
  (8.7, 4),
  (9.6, 0),
)

// Pente de chaque segment = vitesse sur ce segment
#let segments = range(points.len() - 1).map(i => {
  let (t0, x0) = points.at(i)
  let (t1, x1) = points.at(i + 1)
  (t0: t0, t1: t1, x0: x0, x1: x1, v: (x1 - x0) / (t1 - t0))
})

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let pos = palette.blue
  let vel = palette.green
  let (t-max, sx) = (10.2, 1.05) // 1 s = 1.05 cm
  let (pos-scale, vel-scale) = (0.95, 0.6)
  let vel-zero = -3.4 // ordonnée de l'axe du temps du graphique des vitesses

  let ppos(t, x) = (t * sx, x * pos-scale)
  let pvel(t, v) = (t * sx, vel-zero + v * vel-scale)

  // Axes
  let axes(y0, y-lo, y-hi, label) = {
    line((0, y0), (t-max * sx + 0.3, y0), stroke: 0.8pt + ink, mark: (
      end: "stealth",
      fill: ink,
      stroke: ink,
    ))
    line((0, y-lo), (0, y-hi), stroke: 0.8pt + ink, mark: (
      end: "stealth",
      fill: ink,
      stroke: ink,
    ))
    content((t-max * sx + 0.3, y0), anchor: "north-east", padding: 0.15, text(
      size: 11pt,
      fill: ink,
    )[temps (#unit[s])])
    content((-0.25, (y-lo + y-hi) / 2), angle: 90deg, anchor: "south", text(
      size: 12pt,
      fill: ink,
      label,
    ))
  }
  axes(0, 0, 4.3 * pos-scale + 0.4, [position (#unit[m])])
  axes(
    vel-zero,
    vel-zero - 3.2 * vel-scale,
    vel-zero + 2.8 * vel-scale + 0.3,
    [vitesse (#unit[m / s])],
  )

  // Repères verticaux aux changements de pente
  for (t, x) in points.slice(1) {
    line(
      ppos(t, x),
      (t * sx, vel-zero - 3.2 * vel-scale),
      stroke: (
        paint: ink.transparentize(55%),
        thickness: 0.6pt,
        dash: "dotted",
      ),
    )
  }

  // Triangle de pente sur un segment, pour montrer Δx / Δt
  let s6 = segments.at(6)
  let corner = (s6.t1, s6.x0)
  line(ppos(s6.t0, s6.x0), ppos(..corner), ppos(s6.t1, s6.x1), stroke: (
    paint: palette.gold.line,
    thickness: 1.4pt,
    dash: "dashed",
  ))
  content(
    ((s6.t0 + s6.t1) / 2 * sx, s6.x0 * pos-scale),
    anchor: "north",
    padding: 0.12,
    text(
      size: 10pt,
      fill: palette.gold.text,
      $Delta t$,
    ),
  )
  // Δx à l'intérieur du triangle : à droite passe la descente suivante
  content(
    (s6.t1 * sx, (s6.x0 + s6.x1) / 2 * pos-scale),
    anchor: "east",
    padding: 0.1,
    text(
      size: 10pt,
      fill: palette.gold.text,
      $Delta x$,
    ),
  )

  // Courbe de position
  line(..points.map(((t, x)) => ppos(t, x)), stroke: (
    paint: pos.line,
    thickness: 2.2pt,
    join: "round",
  ))
  for (t, x) in points {
    circle(ppos(t, x), radius: 0.06, fill: pos.line, stroke: none)
  }

  // Vitesse en escalier : un palier par segment
  for (k, s) in segments.enumerate() {
    line(pvel(s.t0, s.v), pvel(s.t1, s.v), stroke: (
      paint: vel.line,
      thickness: 2.2pt,
      cap: "round",
    ))
    if k + 1 < segments.len() {
      let next = segments.at(k + 1)
      line(pvel(s.t1, s.v), pvel(s.t1, next.v), stroke: (
        paint: vel.line.transparentize(50%),
        thickness: 1pt,
      ))
    }
  }

  // Lecture des segments en mots
  let note(t, x, anchor, body) = content(
    ppos(t, x),
    anchor: anchor,
    padding: 0.15,
    text(size: 10pt, fill: ink, body),
  )
  note(1.9, 0.8, "north-west", [montée douce #sym.arrow.r $v$ petite])
  note(3.1, 1.9, "west", [montée raide \ #sym.arrow.r $v$ grande])
  note(4.25, 3, "south", [plateau #sym.arrow.r $v = 0$])
  note(9.15, 2.5, "west", [descente \ #sym.arrow.r $v < 0$])
  content(
    ppos(7.1, 3.4),
    anchor: "south",
    text(size: 10pt, fill: palette.gold.text)[pente $= (Delta x) / (Delta t)$],
  )
})
