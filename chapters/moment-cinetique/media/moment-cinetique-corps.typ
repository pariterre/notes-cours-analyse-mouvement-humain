#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Calcul du moment cinétique du corps autour de O : somme, sur tous les
// segments k, de deux contributions (même couleur dans l'équation et sur le
// dessin) :
//   - la rotation propre du segment autour de son centre de masse : I_k ω_k
//   - le moment de sa quantité de mouvement : OG_k ∧ (m_k v_k)
// Exemple : corps en extension tournant dans le sens direct autour de O; le
// segment k est le bras droit.

#let sym = moment-cinetique.symbol
// display() : sinon le texte sous les accolades est réduit (taille indice)
#let equation = text(size: 14pt)[$
  #sym _O = sum_(k=1)^n (
    underbrace(#text(fill: palette.green.text)[$I_k omega_k$], display(#text(size: 12pt, fill: palette.green.text)[#moment-cinetique.Name]))
    + underbrace(
      #text(fill: palette.red.text)[$arrow(O G_k)$] and #text(fill: palette.gold.text)[$(m_k arrow(v_k))$],
      display(#text(size: 12pt)[moment de sa quantité de mouvement])
    )
  )
$]

#let drawing = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let unit(d) = {
    let n = calc.sqrt(d.at(0) * d.at(0) + d.at(1) * d.at(1))
    d.map(c => c / n)
  }
  let arrow-line(from, to, shade, width: 2.6pt) = line(from, to, stroke: width + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.2,
  ))
  // Petite flèche de rotation autour de c (sens direct)
  let rotation(c, radius, from, span, shade) = {
    let arc = range(0, 25).map(i => add(c, polar(radius, from + span * i / 24)))
    line(..arc.slice(0, 21), stroke: (paint: shade.line, thickness: 2pt, cap: "round"))
    let (tip, back) = (arc.last(), arc.at(19))
    let w = unit((back.at(1) - tip.at(1), tip.at(0) - back.at(0))).map(c => c * 0.11)
    line(tip, add(back, w), add(back, w.map(c => -c)), close: true, fill: shade.line, stroke: none)
  }

  // Corps en bâtons (les autres segments en gris)
  let body = (paint: palette.neutral.line.lighten(30%), thickness: 3pt, cap: "round", join: "round")
  let (neck, hip, shoulder) = ((0, 1.0), (0, -0.7), (0, 0.85))
  circle((0, 1.45), radius: 0.36, fill: white, stroke: body)
  line(neck, hip, stroke: body)
  line(hip, (0.75, -2.5), stroke: body)
  line(hip, (-0.75, -2.5), stroke: body)
  line(shoulder, (-1.45, 1.8), stroke: body)

  // Segment i : le bras droit
  let hand = (2.35, 1.45) // bras tendu sur le côté
  line(shoulder, hand, stroke: (paint: ink, thickness: 4pt, cap: "round"))
  let g = ((shoulder.at(0) + hand.at(0)) / 2, (shoulder.at(1) + hand.at(1)) / 2)

  // Centre de rotation O (centre de masse du corps)
  let o = (0, 0.1)

  // Contributions du segment k
  arrow-line(o, g, palette.red)
  content(((o.at(0) + g.at(0)) / 2, (o.at(1) + g.at(1)) / 2), anchor: "north-west", padding: 0.12, text(
    size: 13pt,
    fill: palette.red.text,
  )[$arrow(O G_k)$])
  // Le bras tourne autour de l'épaule : la vitesse de G_k est perpendiculaire
  // au bras (sens direct)
  let arm = (hand.at(0) - shoulder.at(0), hand.at(1) - shoulder.at(1))
  let v-dir = unit((-arm.at(1), arm.at(0)))
  let v-tip = add(g, v-dir.map(c => c * 1.5))
  arrow-line(g, v-tip, palette.gold)
  content(v-tip, anchor: "south-east", padding: 0.08, text(size: 13pt, fill: palette.gold.text)[$m_k arrow(v_k)$])
  rotation(g, 0.42, -40deg, 290deg, palette.green)
  content(add(g, (0.5, -0.45)), anchor: "west", text(size: 13pt, fill: palette.green.text)[$I_k omega_k$])

  // Points
  circle(g, radius: 0.08, fill: ink, stroke: 1pt + white)
  content(g, anchor: "south-west", padding: 0.45, text(size: 13pt, weight: "bold", fill: ink)[$G_k$])
  circle(o, radius: 0.1, fill: palette.gold.line, stroke: 1pt + white)
  content(o, anchor: "east", padding: 0.15, text(size: 13pt, weight: "bold", fill: ink)[$O$])
})

#align(center, equation)
#v(0.6em)
// Dessin agrandi en bloc (traits et textes compris) : l'équation, plus
// large, fixe la largeur de la figure
#align(center, scale(140%, reflow: true, drawing))
