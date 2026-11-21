#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Interprétation géométrique de la norme du produit vectoriel : c'est l'aire
// du parallélogramme formé par A et B, soit base ‖A‖ × hauteur ‖B‖·|sin θ|.
// Mêmes vecteurs (mêmes normes) dans les trois cas, seul l'angle change :
// l'aire est maximale à angle droit.

#let (len-a, len-b) = (2.6, 2.6)
// (titre, angle θ)
#let cases = (
  ([$theta < 90 degree$], 35deg),
  ([$theta = 90 degree$ : aire maximale], 90deg),
  ([$theta > 90 degree$], 145deg),
)

#let equation = text(size: 15pt)[$
  norm(arrow(C)) = norm(arrow(A)) dot norm(arrow(B)) dot abs(sin theta)
  = #text(fill: palette.green.text)[aire du parallélogramme]
$]

#let panel(title, angle) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let o = (0, 0)
  let a = (len-a, 0)
  let b = polar(len-b, angle)

  // Parallélogramme : son aire vaut ‖C‖
  line(o, a, add(a, b), b, close: true, fill: palette.green.fill, stroke: (
    paint: palette.green.line,
    thickness: 0.8pt,
    dash: "dashed",
  ))
  // Étiquette ‖C‖ (l'aire), placée dans la partie libre du parallélogramme :
  // à droite de la hauteur (θ < 90°), ou à droite de l'angle θ (θ > 90°)
  let (bx, by) = b
  let x-label = if angle == 90deg { len-a / 2 } else if angle < 90deg {
    (bx + len-a + bx / 2) / 2
  } else { (len-a + bx) / 2 + 0.7 }
  content((x-label, by / 2), text(size: 13pt, fill: palette.green.text, $norm(arrow(C))$))

  // Hauteur ‖B‖·|sin θ| (le pied tombe hors de A si θ > 90°)
  let foot = (b.at(0), 0)
  let guide = (paint: ink.transparentize(40%), thickness: 0.7pt, dash: "dotted")
  if b.at(0) < 0 { line(o, foot, stroke: guide) }
  if calc.abs(b.at(0)) > 0.01 {
    line(b, foot, stroke: guide)
    let q = 0.15
    let s = if b.at(0) < 0 { 1 } else { -1 }
    line((foot.at(0), q), (foot.at(0) + s * q, q), (foot.at(0) + s * q, 0), stroke: 0.6pt + ink)
  }

  // Angle θ
  let r = 0.38
  let arc = range(0, 21).map(i => polar(r, angle * i / 20))
  line(o, ..arc, close: true, fill: palette.gold.fill, stroke: none)
  line(..arc, stroke: 0.8pt + palette.gold.line)
  content(polar(r + 0.22, angle / 2), text(size: 11pt, fill: palette.gold.text)[$theta$])

  // Vecteurs
  let vector(to, shade, label, anchor) = {
    line(o, to, stroke: 2.4pt + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.1))
    content(to, anchor: anchor, padding: 0.12, text(size: 13pt, fill: shade.text, label))
  }
  vector(a, palette.blue, $arrow(A)$, "north")
  vector(b, palette.red, $arrow(B)$, if angle > 90deg { "south-east" } else { "south-west" })
  circle(o, radius: 0.06, fill: ink, stroke: none)

  // Titre, et même hauteur pour tous (la largeur suit le dessin)
  content(((calc.min(0, b.at(0)) + calc.max(len-a, len-a + b.at(0))) / 2, 3.25), anchor: "south", text(
    size: 12pt,
    weight: "semibold",
    fill: ink,
    title,
  ))
  line((0, -0.55), (0, 3.7), stroke: none)
})

#align(center, equation)
#v(0.3em)
#grid(
  columns: 3,
  column-gutter: 1.5em,
  ..cases.map(((title, angle)) => panel(title, angle)),
)
