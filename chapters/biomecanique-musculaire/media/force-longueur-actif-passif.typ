#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Relations force-longueur du muscle : composante active (fibres, en U
// inversé autour de L_0), composante passive (tissus conjonctifs, exponentielle
// avec l'étirement) et leur somme. La courbe totale est calculée comme la
// somme des deux autres.

#let active-color = palette.green
#let passive-color = palette.blue
#let total-color = palette.dark.fill

// Longueur relative (L / L_0) et force relative (force active maximale = 1)
#let (l-min, l-max) = (0.35, 1.75)
#let f-max = 1.7 // haut des axes
#let active(l) = calc.exp(-calc.pow((l - 1) / 0.38, 2))
#let passive(l) = calc.max(0, 0.02 * (calc.exp(5 * (l - 0.8)) - 1))
#let total(l) = active(l) + passive(l)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (width, height) = (4, 2.8) // taille d'un graphique
  let gap = 1.4

  let panel(x0, title, curves, labels: ()) = {
    let p(l, f) = (x0 + (l - l-min) / (l-max - l-min) * width, f / f-max * height)

    // Repère d'équilibre L_0
    line(p(1, 0), p(1, f-max * 0.92), stroke: (paint: palette.neutral.text, thickness: 0.7pt, dash: "dashed"))
    content(p(1, 0), anchor: "north", padding: 0.12)[$L_0$]

    // Courbes (coupées au haut des axes)
    for (f, stroke) in curves {
      let pts = range(0, 141)
        .map(i => l-min + i / 140 * (l-max - l-min))
        .filter(l => f(l) <= f-max * 0.97)
        .map(l => p(l, f(l)))
      line(..pts, stroke: stroke)
    }
    for (at, anchor, body) in labels {
      content(p(..at), anchor: anchor, padding: 0.06, text(size: 9pt, body))
    }

    // Axes
    let axis-mark = (end: "stealth", fill: black)
    line(p(l-min, 0), (x0 + width + 0.3, 0), stroke: 1.2pt + black, mark: axis-mark)
    line(p(l-min, 0), (x0, height + 0.3), stroke: 1.2pt + black, mark: axis-mark)
    content((x0 + width + 0.3, 0), anchor: "north-east", padding: 0.12)[Longueur]
    content((x0, height + 0.3), anchor: "east", padding: 0.1)[Force]
    content((x0 + width / 2, height + 0.55), anchor: "south", title)
  }

  let active-stroke = 1.8pt + active-color.line
  let passive-stroke = 1.8pt + passive-color.line
  let step = width + gap

  panel(0, text(weight: "semibold", fill: active-color.text)[Actif], ((active, active-stroke),))
  panel(step, text(weight: "semibold", fill: passive-color.text)[Passif], ((passive, passive-stroke),))
  panel(
    2 * step,
    text(weight: "semibold")[
      #text(fill: active-color.text)[Actif] + #text(fill: passive-color.text)[passif]
    ],
    (
      (active, (paint: active-color.line, thickness: 1.2pt, dash: "dashed")),
      (passive, (paint: passive-color.line, thickness: 1.2pt, dash: "dashed")),
      (total, 2pt + total-color),
    ),
    labels: (
      ((1.3, 1.05), "south", text(fill: total-color)[Total]),
    ),
  )
})
