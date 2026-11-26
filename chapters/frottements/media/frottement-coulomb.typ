#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Loi de Coulomb : un objet posé au sol, tiré par une force F. Le sol exerce
// une réaction R, décomposée en une composante normale R_n (opposée au
// poids) et une composante tangentielle R_t (le frottement, opposé au
// mouvement), avec ‖R_t‖ = μ ‖R_n‖.
// Couleurs du chapitre précédent : le frottement s'oppose au déplacement
// (travail négatif, rouge); la composante normale ne travaille pas (gris);
// la réaction totale, résultat de la construction, en or.

#let mu = 0.45
#let w-len = 2.4 // longueur dessinée du poids (et de la réaction normale)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (box-w, box-h) = (3.2, 1.4)
  let vec(from, to, shade, width: 2.6pt) = line(from, to, stroke: width + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.2,
  ))

  // Sol
  line((-2.0, 0), (box-w + 2.6, 0), stroke: 1pt + ink)
  for i in range(26) {
    let x = -1.9 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Objet
  rect((0, 0), (box-w, box-h), radius: 0.05, fill: palette.blue.fill, stroke: 1.2pt + palette.blue.line)
  let g = (box-w * 0.72, box-h / 2) // centre de masse

  // Poids, depuis le centre de masse
  vec(g, (g.at(0), g.at(1) - w-len), (line: palette.dark.line))
  content((g.at(0), g.at(1) - w-len), anchor: "west", padding: 0.12, text(size: 13pt)[$arrow(W)$])
  circle(g, radius: 0.07, fill: ink, stroke: 1pt + white)

  // Force de traction
  vec((box-w, box-h / 2), (box-w + 1.6, box-h / 2), palette.neutral)
  content((box-w + 1.6, box-h / 2), anchor: "south-east", padding: 0.1, text(size: 13pt, fill: palette.neutral.text)[$arrow(F)$])

  // Réaction du sol au point de contact, et ses composantes
  let c = (box-w * 0.42, 0)
  let rn = (c.at(0), w-len)
  let rt = (c.at(0) - mu * w-len, 0)
  let r = (rt.at(0), rn.at(1))
  let guide = (paint: ink.transparentize(45%), thickness: 0.7pt, dash: "dashed")
  line(rn, r, rt, stroke: guide)
  vec(c, rn, palette.neutral)
  content(rn, anchor: "south-west", padding: 0.08, text(size: 13pt, fill: palette.neutral.text)[$arrow(R)_n_arrow(W)$])
  vec(c, rt, palette.red)
  content(rt, anchor: "north-east", padding: 0.12, text(size: 13pt, fill: palette.red.text)[$arrow(R)_t_arrow(W)$])
  vec(c, r, palette.gold, width: 3pt)
  content(r, anchor: "south-east", padding: 0.08, text(size: 13pt, fill: palette.gold.text)[$arrow(R)$])
  circle(c, radius: 0.07, fill: ink, stroke: 1pt + white)
})
