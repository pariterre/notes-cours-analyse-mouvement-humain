#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Cône de frottement (loi de Coulomb) : la réaction du sol R reste dans le
// cône tant que l'objet ne glisse pas (frottement statique). À la limite, elle
// touche le bord du cône : ‖R_t‖ = μ ‖R_n‖, et le demi-angle θ du cône vérifie
// tan θ = μ. Mêmes couleurs que la figure de la loi de Coulomb.

#let mu-value = 0.6 // μ (pas `mu` : masquerait le symbole en math)
#let rn-len = 4.4 // hauteur du cône = norme de la réaction normale
#let squash = 0.28 // aplatissement des ellipses (perspective)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let radius = mu-value * rn-len
  let top = (0, rn-len)
  let vec(from, to, shade, width: 2.6pt) = line(from, to, stroke: width + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.2,
  ))

  // Sol et point de contact (sommet du cône)
  line((-radius - 0.8, 0), (radius + 0.8, 0), stroke: 1pt + ink)
  for i in range(int((2 * radius + 1.6) / 0.3)) {
    let x = -radius - 0.7 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Cône : deux génératrices et l'ellipse du haut (arrière en pointillé)
  let cone = (paint: palette.gold.line, thickness: 1.2pt)
  line((-radius, rn-len), (0, 0), (radius, rn-len), stroke: cone)
  let ellipse(from, to, dashed) = line(
    ..range(41).map(i => {
      let a = from + (to - from) * i / 40
      (radius * calc.cos(a), rn-len + radius * squash * calc.sin(a))
    }),
    stroke: (..cone, dash: if dashed { "dashed" } else { none }),
  )
  ellipse(0deg, 180deg, true) // arrière
  ellipse(180deg, 360deg, false) // avant
  // Intérieur du cône légèrement teinté
  line((0, 0), (radius, rn-len), ..range(41).map(i => {
    let a = 360deg * i / 40
    (radius * calc.cos(a), rn-len + radius * squash * calc.sin(a))
  }), (-radius, rn-len), close: true, fill: palette.gold.fill.transparentize(55%), stroke: none)

  // Demi-angle θ du cône : tan θ = μ
  // Direction du bord du cône depuis l'horizontale (calc.atan2 prend (x, y))
  let edge-angle = calc.atan2(radius, rn-len)
  let arc = range(0, 21).map(i => {
    let a = 90deg - (90deg - edge-angle) * i / 20
    (0.9 * calc.cos(a), 0.9 * calc.sin(a))
  })
  line(..arc, stroke: 0.8pt + ink)
  content((1.15 * calc.cos((90deg + edge-angle) / 2), 1.15 * calc.sin((90deg + edge-angle) / 2)), text(size: 12pt, fill: ink)[$theta$])

  // Réaction normale
  vec((0, 0), top, palette.neutral)
  content((0, rn-len / 2), anchor: "east", padding: 0.12, text(size: 13pt, fill: palette.neutral.text)[$arrow(R)_n$])

  // Cas statique : réaction à l'intérieur du cône
  let r-static = (0.45 * radius, rn-len)
  vec((0, 0), r-static, (line: palette.gold.line.lighten(35%)), width: 1.8pt)
  // Nom le long du vecteur, entre lui et le bord du cône
  content((r-static.at(0) * 0.62, rn-len * 0.62), anchor: "west", padding: 0.12, text(size: 11pt, fill: palette.gold.text.lighten(20%), style: "italic")[statique])

  // Limite (glissement) : frottement maximal, réaction sur le bord du cône
  let edge = (radius, rn-len)
  vec(top, edge, palette.red)
  // Au-dessus de l'ellipse du haut, pour ne pas encombrer le cône
  content((radius / 2, rn-len + radius * squash), anchor: "south", padding: 0.15, text(size: 13pt, fill: palette.red.text)[$norm(arrow(R)_t) = mu norm(arrow(R)_n)$])
  vec((0, 0), edge, palette.gold, width: 3pt)
  content(edge, anchor: "west", padding: 0.15, text(size: 13pt, fill: palette.gold.text)[$arrow(R)$ (glissement)])

  circle((0, 0), radius: 0.08, fill: ink, stroke: 1pt + white)
})
