#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Deux façons de lire ‖M‖ = ‖OM‖ · ‖F‖ · |sin θ| sur la même situation :
//   1. bras de levier réel : d = ‖OM‖·|sin θ|, distance perpendiculaire de O
//      à la droite d'action de F  →  ‖M‖ = d · ‖F‖
//   2. force effective : F⊥ = ‖F‖·|sin θ|, composante de F perpendiculaire
//      au bras de levier (F∥ ne fait que tirer/pousser)  →  ‖M‖ = ‖OM‖ · F⊥

#let om = 3.0
#let force = 1.9
#let force-angle = 55deg // θ (nom distinct : `theta` masquerait le symbole)

#let panel(title, formula, body) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let o = (0, 0)
  let m = (om, 0)
  let u = polar(1, -force-angle) // direction de F
  let tip = add(m, u.map(c => c * force))

  // Bras de levier OM
  line(o, m, stroke: (paint: palette.neutral.line, thickness: 5pt, cap: "round"))

  body(o, m, u, tip, polar, add)

  // Angle θ entre le prolongement de OM et la force
  let r = 0.5
  let arc = range(0, 21).map(i => add(m, polar(r, -force-angle * i / 20)))
  line(add(m, (0.75, 0)), m, stroke: (paint: ink.transparentize(50%), thickness: 0.7pt, dash: "dotted"))
  line(..arc, stroke: 0.8pt + ink)
  content(add(m, polar(r + 0.22, -force-angle / 2)), text(size: 11pt, fill: ink)[$theta$])

  // Force F
  line(m, tip, stroke: 2.6pt + palette.red.line, mark: (end: "stealth", fill: palette.red.line, stroke: palette.red.line, scale: 1.2))
  content(tip, anchor: "north-west", padding: 0.08, text(size: 13pt, fill: palette.red.text)[$arrow(F)$])

  // Points
  for (p, name, anchor) in ((o, $O$, "east"), (m, $M$, "south-west")) {
    circle(p, radius: 0.08, fill: ink, stroke: 1pt + white)
    content(p, anchor: anchor, padding: 0.15, text(size: 13pt, weight: "bold", fill: ink, name))
  }

  // Titre et formule
  content((om / 2 + 0.3, 2.9), anchor: "south", text(size: 12pt, weight: "semibold", fill: ink, title))
  content((om / 2 + 0.3, -2.45), anchor: "north", text(size: 13pt, formula))
  line((0, -3.1), (0, 3.5), stroke: none) // même hauteur pour les deux
})

// 1. Bras de levier réel
#let lever = panel(
  [① Bras de levier réel],
  [$norm(arrow(M)) = #text(fill: palette.green.text)[$d$] dot norm(arrow(F))$ \
    #text(size: 11pt)[avec #text(fill: palette.green.text)[$d = norm(arrow(O M)) dot abs(sin theta)$]]],
  (o, m, u, tip, polar, add) => {
    import cetz.draw: *
    let ink = palette.neutral.text
    // Droite d'action de F, prolongée vers l'arrière
    let k = -om * u.at(0) // projection de O sur la droite : H = M + k·u
    let h = add(m, u.map(c => c * k))
    line(add(m, u.map(c => c * (k - 0.6))), add(m, u.map(c => c * (force + 0.6))), stroke: (
      paint: palette.red.line.transparentize(40%),
      thickness: 0.8pt,
      dash: "dashed",
    ))
    content(add(m, u.map(c => c * (k - 0.6))), anchor: "south", padding: 0.08, text(
      size: 9pt,
      fill: palette.red.text,
      style: "italic",
    )[droite d'action])
    // Distance perpendiculaire d
    line(o, h, stroke: (paint: palette.green.line, thickness: 2.6pt, cap: "round"))
    content(((o.at(0) + h.at(0)) / 2, (o.at(1) + h.at(1)) / 2), anchor: "south-east", padding: 0.1, text(
      size: 14pt,
      fill: palette.green.text,
      weight: "bold",
    )[$d$])
    let q = 0.22
    let v = (-u.at(1), u.at(0)) // perpendiculaire à u, vers O
    let p1 = add(h, u.map(c => c * q))
    line(p1, add(p1, v.map(c => -c * q)), add(h, v.map(c => -c * q)), stroke: 0.7pt + ink)
  },
)

// 2. Force effective
#let effective = panel(
  [② Force effective],
  [$norm(arrow(M)) = norm(arrow(O M)) dot #text(fill: palette.gold.text)[$F_perp$]$ \
    #text(size: 11pt)[avec #text(fill: palette.gold.text)[$F_perp = norm(arrow(F)) dot abs(sin theta)$]]],
  (o, m, u, tip, polar, add) => {
    import cetz.draw: *
    let ink = palette.neutral.text
    let f-par = add(m, (tip.at(0) - m.at(0), 0))
    let f-perp = add(m, (0, tip.at(1) - m.at(1)))
    let guide = (paint: ink.transparentize(50%), thickness: 0.7pt, dash: "dashed")
    line(f-par, tip, f-perp, stroke: guide)
    // Composante parallèle : ne fait que tirer sur le bras
    line(m, f-par, stroke: 2pt + palette.neutral.line, mark: (
      end: "stealth",
      fill: palette.neutral.line,
      stroke: palette.neutral.line,
    ))
    content(f-par, anchor: "south-west", padding: 0.08, text(size: 12pt, fill: palette.neutral.text)[$F_parallel$])
    // Composante perpendiculaire : fait tourner
    line(m, f-perp, stroke: 2.6pt + palette.gold.line, mark: (
      end: "stealth",
      fill: palette.gold.line,
      stroke: palette.gold.line,
      scale: 1.2,
    ))
    content(f-perp, anchor: "east", padding: 0.12, text(size: 14pt, fill: palette.gold.text, weight: "bold")[$F_perp$])
  },
)

#grid(
  columns: 2,
  column-gutter: 2.5em,
  lever, effective,
)
