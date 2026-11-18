#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Sprint d'Usain Bolt (Championnat du monde 2009) : temps intermédiaires
// tous les 20 m.
#let data = ((0, 0), (2.89, 20), (4.64, 40), (6.31, 60), (7.92, 80), (9.58, 100))

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let grid-stroke = 0.4pt + palette.neutral.line.transparentize(70%)
  let series = palette.blue
  // Échelles : 10 s sur 10 cm, 100 m sur 6 cm
  let px(t) = t
  let py(d) = d * 0.06
  let pt((t, d)) = (px(t), py(d))

  // Grille et graduations
  for d in range(0, 101, step: 20) {
    line((0, py(d)), (px(10), py(d)), stroke: grid-stroke)
    content((-0.15, py(d)), anchor: "east", text(size: 11pt, fill: ink)[#d])
  }
  for t in range(0, 11) {
    line((px(t), 0), (px(t), -0.1), stroke: 0.6pt + ink)
    content((px(t), -0.2), anchor: "north", text(size: 11pt, fill: ink)[#t])
  }
  line((0, 0), (px(10), 0), stroke: 0.8pt + ink)
  line((0, 0), (0, py(100)), stroke: 0.8pt + ink)
  content((px(5), -1.0), text(size: 12pt, fill: ink)[temps (#unit[s])])
  content((-1.15, py(50)), angle: 90deg, text(size: 12pt, fill: ink)[distance (#unit[m])])

  // Courbe et points
  line(..data.map(pt), stroke: (paint: series.line, thickness: 2pt, join: "round"))
  for p in data {
    circle(pt(p), radius: 0.1, fill: series.line, stroke: 1.5pt + white)
    if p.at(0) > 0 {
      content(pt(p), anchor: "south-east", padding: 0.12, text(size: 10.5pt, fill: series.text, qty[#p.at(0)][s]))
    }
  }
})
