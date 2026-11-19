#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Séquence d'images d'une éolienne de Cap-Chat (d'après une vidéo à 25 Hz
// dont on ne garde qu'une image sur trois). Le bout d'une pale est marqué en
// rouge; il tourne dans le sens direct d'environ 40° entre deux images
// représentées, et revient à sa position de départ à la dernière image.

#let n-frames = 10
#let start = -70deg
#let step = 40deg

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (w, h) = (1.5, 2.5)
  let gap = 0.08
  let blade = 0.66
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let structure = palette.neutral.line.lighten(10%)

  for i in range(n-frames) {
    let x0 = i * (w + gap)
    let hub = (x0 + w / 2, 1.65)

    // Ciel et sol
    rect((x0, 0), (x0 + w, h), fill: palette.blue.fill, stroke: none)
    rect((x0, 0), (x0 + w, 0.18), fill: palette.green.fill.darken(8%), stroke: none)

    // Mât (légèrement conique) et nacelle
    line(
      (hub.at(0) - 0.07, 0.18),
      (hub.at(0) + 0.07, 0.18),
      (hub.at(0) + 0.035, hub.at(1)),
      (hub.at(0) - 0.035, hub.at(1)),
      close: true,
      fill: structure.lighten(35%),
      stroke: 0.5pt + structure,
    )

    // Pales : la première porte le repère rouge
    let a = start + i * step
    for k in range(3) {
      let b = a + k * 120deg
      let n = polar(1, b + 90deg)
      let root = polar(0.1, b)
      let tip = polar(blade, b)
      line(
        add(hub, add(root, n.map(c => 0.06 * c))),
        add(hub, add(tip, n.map(c => 0.015 * c))),
        add(hub, add(tip, n.map(c => -0.015 * c))),
        add(hub, add(root, n.map(c => -0.03 * c))),
        close: true,
        fill: white,
        stroke: 0.6pt + structure,
      )
    }
    circle(hub, radius: 0.08, fill: white, stroke: 0.6pt + structure)
    circle(add(hub, polar(blade - 0.03, a)), radius: 0.075, fill: palette.red.line, stroke: 0.8pt + white)

    rect((x0, 0), (x0 + w, h), stroke: 0.5pt + palette.neutral.line)
  }
})
