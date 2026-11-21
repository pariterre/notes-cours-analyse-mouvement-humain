#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Produit vectoriel : C = A ∧ B est perpendiculaire au plan formé par A et B,
// orienté selon la règle de la main droite (on tourne de A vers B).
// Perspective cavalière : A vers l'avant-gauche, B vers la droite, C vers le haut.

#let (len-a, len-b, len-c) = (2.4, 3.2, 2.8)
// Direction à l'écran de chacun des trois axes (A, B, C)
#let screen-a = (-0.55, -0.6)
#let screen-b = (1, 0)
#let screen-c = (0, 1)

#let project((a, b, c)) = (
  a * screen-a.at(0) + b * screen-b.at(0) + c * screen-c.at(0),
  a * screen-a.at(1) + b * screen-b.at(1) + c * screen-c.at(1),
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let o = (0, 0)
  let a = project((len-a, 0, 0))
  let b = project((0, len-b, 0))
  let c = project((0, 0, len-c))

  // Plan formé par A et B
  line(o, a, project((len-a, len-b, 0)), b, close: true, fill: palette.neutral.fill, stroke: (
    paint: palette.neutral.line.transparentize(50%),
    thickness: 0.6pt,
    dash: "dashed",
  ))
  content(project((len-a * 0.6, len-b * 0.75, 0)), text(size: 11pt, fill: ink, style: "italic")[plan de $arrow(A)$ et $arrow(B)$])

  // Rotation de A vers B (règle de la main droite)
  let r = 1.1
  let arc = range(0, 31).map(i => {
    let t = 90deg * i / 30
    project((r * calc.cos(t), r * calc.sin(t), 0))
  })
  line(..arc.slice(2, 26), stroke: (paint: palette.gold.line, thickness: 2pt, cap: "round"))
  let tip = arc.at(29)
  let back = arc.at(24)
  let (dx, dy) = (tip.at(0) - back.at(0), tip.at(1) - back.at(1))
  let n = calc.sqrt(dx * dx + dy * dy)
  let side = (-dy / n * 0.14, dx / n * 0.14)
  line(
    tip,
    (back.at(0) + side.at(0), back.at(1) + side.at(1)),
    (back.at(0) - side.at(0), back.at(1) - side.at(1)),
    close: true,
    fill: palette.gold.line,
    stroke: none,
  )

  // Angles droits entre C et le plan
  let q = 0.28
  for p in (project((q, 0, 0)), project((0, q, 0))) {
    line(p, (p.at(0), p.at(1) + q), (0, q), stroke: 0.7pt + ink)
  }

  // Vecteurs
  let vector(to, shade, label, anchor) = {
    line(o, to, stroke: 2.6pt + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.3))
    content(to, anchor: anchor, padding: 0.15, text(size: 14pt, fill: shade.text, label))
  }
  vector(a, palette.red, $arrow(A)$, "north-east")
  vector(b, palette.green, $arrow(B)$, "west")
  vector(c, palette.blue, $arrow(C)$, "south")
  circle(o, radius: 0.07, fill: ink, stroke: none)
})
