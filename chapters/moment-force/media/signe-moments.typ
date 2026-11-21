#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Signe du moment de chaque force autour de O : on imagine dans quel sens
// l'objet tournerait. Sens direct (de x vers y) = positif (bleu), sens
// horaire = négatif (rouge). Le signe est calculé : r × F avec r = OP.

// (nom, point d'application P, direction de F, la force tire (sinon pousse))
#let forces = (
  ($arrow(F_1)$, (-2.3, -0.9), (0.35, 1), false),
  ($arrow(F_2)$, (-2.4, 0.75), (1, 0), false),
  ($arrow(F_3)$, (0, 1.05), (0, -1), false), // passe par O : moment nul
  ($arrow(F_4)$, (1.4, 0.9), (-1, -1), false),
  ($arrow(F_5)$, (1.3, -0.7), (-0.7, 1), false),
  ($arrow(F_6)$, (-1.2, -1.1), (0.3, -1), true),
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let unit(d) = {
    let n = calc.sqrt(d.at(0) * d.at(0) + d.at(1) * d.at(1))
    d.map(c => c / n)
  }
  let f-len = 1.6

  // Petite flèche circulaire : sens direct (ccw) ou horaire
  // Arc court centré en `c`, dont le milieu est à l'angle `center-angle`
  let rotation(c, ccw, shade, radius: 0.4, center-angle: 90deg, span: 80deg) = {
    let sgn = if ccw { 1 } else { -1 }
    let a0 = center-angle - sgn * span / 2
    let arc = range(0, 25).map(i => add(c, polar(radius, a0 + sgn * span * i / 24)))
    line(..arc.slice(0, 21), stroke: (paint: shade.line, thickness: 1.5pt, cap: "round"))
    let (tip, back) = (arc.last(), arc.at(19))
    let (dx, dy) = (tip.at(0) - back.at(0), tip.at(1) - back.at(1))
    let n = calc.sqrt(dx * dx + dy * dy)
    let w = (-dy / n * 0.09, dx / n * 0.09)
    line(tip, add(back, w), add(back, w.map(c => -c)), close: true, fill: shade.line, stroke: none)
  }

  // Objet : contour passant par les points d'application
  let p(i) = forces.at(i).at(1)
  hobby(p(2), p(1), (-2.9, -0.1), p(0), p(5), p(4), p(3), close: true, fill: palette.neutral.fill.darken(12%), stroke: 1pt + palette.neutral.line)
  circle((0, 0), radius: 0.07, fill: ink, stroke: none)
  content((0, 0), anchor: "north-west", padding: 0.08, text(size: 13pt, weight: "bold", fill: ink)[$O$])

  for (name, at, dir, pull) in forces {
    let u = unit(dir)
    let moment = at.at(0) * u.at(1) - at.at(1) * u.at(0) // composante z de OP × F
    let shade = if moment > 0 { palette.blue } else { palette.red }
    let zero = calc.abs(moment) < 1e-6

    // Force : elle pousse (pointe sur l'objet) ou tire (part de l'objet)
    let (from, to) = if pull { (at, add(at, u.map(c => c * f-len))) } else { (add(at, u.map(c => -c * f-len)), at) }
    line(from, to, stroke: 1.8pt + ink, mark: (end: "stealth", fill: ink, stroke: ink, scale: 1.1))
    content(if pull { to } else { from }, anchor: if (if pull { u } else { u.map(c => -c) }).at(1) > 0 { "south" } else { "north" }, padding: 0.08, text(size: 13pt, fill: ink, name))

    // Sens de rotation induit : petite flèche circulaire autour du milieu de
    // la force; aucune si la droite d'action passe par O (pointillé jusqu'à O)
    if zero {
      line(at, (0, 0), stroke: (paint: ink.transparentize(40%), thickness: 0.8pt, dash: "dashed"))
    } else {
      // Arc centré sur la force, qui la croise au milieu de l'arc
      let mid = ((from.at(0) + to.at(0)) / 2, (from.at(1) + to.at(1)) / 2)
      // L'arc est tourné vers O (comme le contour de l'objet) : son centre est
      // sur la droite entre le milieu de la force et O
      // F1 et F6 : arc perpendiculaire à la force (centre en arrière sur la
      // force), plus lisible là où la force pointe presque vers O
      let perpendicular = name in ($arrow(F_1)$, $arrow(F_6)$)
      // Le centre est toujours du côté de l'objet : l'arc reste concave vers lui
      let toward-object = if pull { u.map(c => -c) } else { u }
      let to-o = if perpendicular { toward-object } else { unit(mid.map(c => -c)) }
      let radius = 0.6
      let center = add(mid, to-o.map(c => radius * c))
      rotation(center, moment > 0, shade, radius: radius, center-angle: calc.atan2(-to-o.at(0), -to-o.at(1)))
    }
  }

  // Repère et sens positif
  let o = (-5.6, -2.6)
  for (to, label, anchor) in ((add(o, (1.1, 0)), $x$, "west"), (add(o, (0, 1.1)), $y$, "south")) {
    line(o, to, stroke: 1pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
    content(to, anchor: anchor, padding: 0.1, text(size: 12pt, fill: ink, label))
  }
  rotation(add(o, (0.45, 0.45)), true, palette.blue, radius: 0.45, center-angle: 45deg, span: 110deg)
  content(add(o, (0.55, 0.55)), text(size: 11pt, fill: palette.blue.text, weight: "bold")[+])
})
