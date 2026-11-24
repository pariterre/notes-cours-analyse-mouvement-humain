#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Variation de la vitesse angulaire avec le moment d'inertie pendant une
// acrobatie : le moment cinétique (I ω) est conservé en l'air, donc la vitesse
// angulaire est inversement proportionnelle au moment d'inertie.
//   décollage proche de l'extension (I = 12) → groupé (I = 4, ω × 3) → tendu
// Valeurs en unités arbitraires (cf. la figure des moments d'inertie).

#let sigma = 12 // moment cinétique conservé (I ω)
// Moment d'inertie : paliers reliés par des transitions douces
// (début, fin, valeur) des paliers
#let plateaus = ((0, 1.6, 12), (3.2, 6.6, 4), (8.2, 10.5, 10))
#let inertia(t) = {
  for (i, (t0, t1, value)) in plateaus.enumerate() {
    if t <= t1 { return value }
    if i + 1 < plateaus.len() {
      let (n0, _, next) = plateaus.at(i + 1)
      if t < n0 {
        let u = (t - t1) / (n0 - t1)
        return value + (next - value) * (1 - calc.cos(u * calc.pi)) / 2
      }
    }
  }
  plateaus.last().at(2)
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (t-max, sx) = (10.5, 1.0)
  let height = 4.5
  let (i-max, w-max) = (13, 3.25)
  let pi(v) = v / i-max * height
  let pw(v) = v / w-max * height
  let arrow-mark(shade) = (end: "stealth", fill: shade, stroke: shade)

  // Phases
  for t in (1.6, 3.2, 6.6, 8.2) {
    line((t * sx, 0), (t * sx, height + 0.3), stroke: (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted"))
  }
  for (t0, t1, body) in ((0, 1.6, [extension]), (3.2, 6.6, [groupé]), (8.2, t-max, [tendu])) {
    content(((t0 + t1) / 2 * sx, height + 0.3), anchor: "south", text(size: 11pt, fill: ink, style: "italic", body))
  }

  // Axes : I à gauche (rouge), ω à droite (vert)
  line((0, 0), (t-max * sx + 0.3, 0), stroke: 0.8pt + ink, mark: arrow-mark(ink))
  content((t-max * sx + 0.3, 0), anchor: "north-east", padding: 0.12, text(size: 11pt, fill: ink)[temps (#unit[s])])
  line((0, 0), (0, height + 0.6), stroke: 1.2pt + palette.red.line, mark: arrow-mark(palette.red.line))
  content((0, height + 0.6), anchor: "south", padding: 0.1, text(size: 12pt, fill: palette.red.text)[$I$ (#unit[kg m^2])])
  line((t-max * sx, 0), (t-max * sx, height + 0.6), stroke: 1.2pt + palette.green.line, mark: arrow-mark(palette.green.line))
  content((t-max * sx, height + 0.6), anchor: "south", padding: 0.1, text(size: 12pt, fill: palette.green.text)[$omega$ (#unit[rad / s])])

  // Courbes
  let ts = range(0, 211).map(k => k / 20)
  line(..ts.map(t => (t * sx, pi(inertia(t)))), stroke: (paint: palette.red.line, thickness: 2.4pt, join: "round"))
  line(..ts.map(t => (t * sx, pw(sigma / inertia(t)))), stroke: (paint: palette.green.line, thickness: 2.4pt, join: "round"))

  // Valeurs des paliers
  for (t0, t1, value) in plateaus {
    let x = (t0 + t1) / 2 * sx
    content((x, pi(value)), anchor: "south", padding: 0.08, text(size: 10pt, fill: palette.red.text)[$I = #value$])
    let w = calc.round(sigma / value, digits: 1)
    content((x, pw(sigma / value)), anchor: "south", padding: 0.08, text(size: 10pt, fill: palette.green.text)[$omega = #w$])
  }

  // Ce qui est conservé
  content((4.9 * sx, 2.35), box(
    fill: palette.gold.fill,
    stroke: 1pt + palette.gold.line,
    inset: 5pt,
    radius: 3pt,
    text(size: 11pt, fill: palette.gold.text)[$#moment-cinetique.symbol = I omega = "constante"$],
  ))
})
