#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Signe du travail selon l'angle θ entre la force F et le déplacement u
// (W = ‖F‖ ‖u‖ cos θ). Cercle centré au point d'application :
//   - la projection de F sur u vaut ‖F‖ cos θ;
//   - de 0° à 90°, cos θ > 0 : travail positif (moteur);
//   - à 90°, cos θ = 0 : travail nul;
//   - de 90° à 180°, cos θ < 0 : travail négatif (résistant).
// Couleurs : travail positif en vert, négatif en rouge; u (déplacement) en
// bleu et F (force quelconque) en gris foncé, comme dans la figure du bloc.

#let r = 3.0
#let f-angle = 25deg // θ ; nom distinct, sinon `theta` masque le symbole en math

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (force, disp) = (palette.neutral, palette.blue)
  let (moteur, resistant) = (palette.green, palette.red)
  let polar(radius, a) = (radius * calc.cos(a), radius * calc.sin(a))
  let arc(radius, from, to) = range(0, 41).map(i => polar(radius, from + (to - from) * i / 40))

  // Demi-cercle coloré selon le signe du travail
  line((0, 0), ..arc(r, 0deg, 90deg), close: true, fill: moteur.fill, stroke: none)
  line((0, 0), ..arc(r, 90deg, 180deg), close: true, fill: resistant.fill, stroke: none)
  line(..arc(r, 0deg, 90deg), stroke: 2.4pt + moteur.line)
  line(..arc(r, 90deg, 180deg), stroke: 2.4pt + resistant.line)
  content(polar(r * 0.62, 58deg), text(size: 10.5pt, fill: moteur.text, weight: "semibold", align(center)[travail \ positif \ (moteur)]))
  content(polar(r * 0.62, 122deg), text(size: 10.5pt, fill: resistant.text, weight: "semibold", align(center)[travail \ négatif \ (résistant)]))

  // Limite entre travail positif et négatif (θ = 90°)
  line((0, 0), (0, r), stroke: 1pt + ink.transparentize(60%))

  // Axe du déplacement
  line((-r, 0), (r, 0), stroke: (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted"))

  // Valeurs particulières du cosinus
  for (a, label, anchor) in (
    (0deg, [$cos theta = 1$], "west"),
    (90deg, [$cos theta = 0$ : travail nul], "south"),
    (180deg, [$cos theta = -1$], "east"),
  ) {
    circle(polar(r, a), radius: 0.09, fill: ink, stroke: 1pt + white)
    content(polar(r, a), anchor: anchor, padding: 0.15, text(size: 12pt, fill: ink, label))
  }

  // Angle θ entre F et u
  line((0, 0), ..arc(0.7, 0deg, f-angle), close: true, fill: white, stroke: 0.8pt + ink)
  content(polar(0.95, f-angle / 2), text(size: 12pt, fill: ink)[$theta$])

  // Projection de F sur u : ‖F‖ cos θ
  let tip = polar(r, f-angle)
  line(tip, (tip.at(0), 0), stroke: (paint: force.line, thickness: 0.8pt, dash: "dashed"))
  line((0, -0.35), (tip.at(0), -0.35), stroke: 1.4pt + force.line, mark: (
    start: "bar",
    end: "bar",
    stroke: force.line,
    scale: 0.6,
  ))
  content((tip.at(0) / 2, -0.35), anchor: "north", padding: 0.22, text(size: 12pt, fill: force.text)[$norm(arrow(F)) cos theta$])

  // Déplacement u et force F (depuis le point d'application)
  line((0, 0), (r * 0.55, 0), stroke: 2.6pt + disp.line, mark: (end: "stealth", fill: disp.line, stroke: disp.line, scale: 1.2))
  content((r * 0.55, 0), anchor: "south-west", padding: 0.05, text(size: 13pt, fill: disp.text)[$arrow(u)$])
  line((0, 0), tip, stroke: 2.6pt + force.line, mark: (end: "stealth", fill: force.line, stroke: force.line, scale: 1.2))
  // Nom sous la flèche, à l'intérieur du cercle (loin de l'arc et du texte)
  content(polar(r * 0.72, f-angle), anchor: "north-west", padding: 0.1, text(size: 13pt, fill: force.text)[$arrow(F)$])
  circle((0, 0), radius: 0.08, fill: ink, stroke: 1pt + white)
})
