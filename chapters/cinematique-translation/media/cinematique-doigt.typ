#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Cinématique du doigt : il accélère (accélération constante positive),
// garde une vitesse constante, puis freine (accélération constante
// négative) jusqu'à l'arrêt. Position, vitesse et accélération sont
// alignées dans le temps.
#let (t1, t2, t3) = (1.2, 5.8, 6.8) // fin de l'accélération, début et fin du freinage
#let v-max = 1.0
#let a-up = v-max / t1
#let a-down = -v-max / (t3 - t2)

#let v-of(t) = if t < t1 { a-up * t } else if t < t2 { v-max } else if t < t3 { v-max + a-down * (t - t2) } else { 0 }
#let x-of(t) = {
  let x1 = a-up * t1 * t1 / 2
  let x2 = x1 + v-max * (t2 - t1)
  if t < t1 { a-up * t * t / 2 } else if t < t2 { x1 + v-max * (t - t1) } else if t < t3 {
    let dt = t - t2
    x2 + v-max * dt + a-down * dt * dt / 2
  } else { x2 + v-max * (t3 - t2) + a-down * (t3 - t2) * (t3 - t2) / 2 }
}
#let a-of(t) = if t < t1 { a-up } else if t < t2 { 0 } else if t < t3 { a-down } else { 0 }

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let t-max = 7.6
  let sx = 1.2
  // (fonction, couleur, nom, échelle verticale, ordonnée de l'axe, haut, bas)
  let panels = (
    (x-of, palette.blue, [position (#unit[m])], 0.42, 5.2, 2.9, 0),
    (v-of, palette.green, [vitesse (#unit[m / s])], 1.5, 2.5, 1.9, 0),
    (a-of, palette.gold, [accélération (#unit[m / s^2])], 1.7, -0.5, 1.6, -1.9),
  )

  // Phases du mouvement
  let phase-top = 9.0
  let phase-bottom = -2.6
  for t in (t1, t2, t3) {
    line((t * sx, phase-bottom), (t * sx, phase-top - 0.4), stroke: (paint: ink.transparentize(40%), thickness: 0.6pt, dash: "dashed"))
  }
  for (from, to, body) in ((0, t1, [accélère]), (t1, t2, [vitesse constante]), (t2, t3, [freine])) {
    content(((from + to) / 2 * sx, phase-top), anchor: "south", text(size: 11pt, fill: ink, style: "italic", body))
  }

  for (f, shade, label, scale, y0, hi, lo) in panels {
    line((0, y0), (t-max * sx, y0), stroke: 0.8pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
    line((0, y0 + lo - 0.2), (0, y0 + hi + 0.3), stroke: 0.8pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
    // Nom de l'axe sous l'axe, ou au-dessus si la courbe descend sous zéro
    content((t-max * sx, y0), anchor: if lo < 0 { "south-east" } else { "north-east" }, padding: 0.22, text(size: 11pt, fill: ink)[temps (#unit[s])])
    content((-0.3, y0 + (hi + lo) / 2), anchor: "east", text(size: 12pt, fill: shade.text, weight: "semibold", label))
    let pts = range(0, int(t-max * 100)).map(i => {
      let t = i / 100
      (t * sx, y0 + f(t) * scale)
    })
    line(..pts, stroke: (paint: shade.line, thickness: 2.2pt, join: "round"))
  }
})
