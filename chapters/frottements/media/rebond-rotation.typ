#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Rebond d'une balle qui tourne sur elle-même. Au contact, le point bas de
// la balle glisse sur le sol; le frottement s'oppose à ce glissement et
// modifie la vitesse de la balle.
// - Vue de côté (la balle avance vers la droite) :
//   rotation avant (lifté) : le point bas recule, le frottement pousse la
//   balle vers l'avant : rebond plus rasant (angle avec le sol plus petit);
//   rotation arrière (coupé) : le frottement freine la balle : rebond plus
//   relevé (angle avec le sol plus grand).
// - Vue de dessus (la balle avance vers le haut, rotation autour de l'axe du
//   déplacement) : la balle est déviée du côté vers lequel tourne le dessus.
// Trajectoire en bleu (déplacement), rebond sans rotation en pointillé gris,
// rotation en rouge (comme pour l'effet Magnus).

#let ball-r = 0.32
#let path-len = 2.6

#let arrow-stroke(paint, width) = (stroke: width + paint, mark: (end: "stealth", fill: paint, stroke: paint))

/// Vue de côté : `angle` = angle de rebond avec le sol; `spin` = 1 (avant) ou -1 (arrière)
#let side-view(angle, spin) = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let flow = palette.blue
  let ray(a, l) = (l * calc.cos(a), l * calc.sin(a))

  // Sol
  line((-2.3, 0), (2.5, 0), stroke: 1pt + ink)
  for i in range(16) {
    let x = -2.2 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Arrivée (à 45°) et rebond sans rotation (symétrique, en pointillé)
  let ball = ray(135deg, path-len)
  line(ball, (0, 0), stroke: 1.8pt + flow.line)
  line(ray(135deg, 1.4), ray(135deg, 1.2), ..arrow-stroke(flow.line, 1.8pt))
  line((0, 0), ray(45deg, path-len), stroke: (paint: ink.transparentize(30%), thickness: 1pt, dash: "dashed"))

  // Rebond réel
  line((0, 0), ray(angle, path-len), ..arrow-stroke(flow.line, 1.8pt))
  let arc = range(0, 21).map(i => ray(angle * i / 20, 0.75))
  line(..arc, stroke: 1pt + flow.line)

  // Balle et sa rotation (horaire = vers l'avant pour une balle allant à droite)
  circle(ball, radius: ball-r, fill: palette.neutral.fill, stroke: 1pt + palette.neutral.line)
  let (from, to) = if spin > 0 { (150deg, 30deg) } else { (30deg, 150deg) }
  let rot = range(0, 21).map(i => {
    let a = from + (to - from) * i / 20
    (ball.at(0) + 0.55 * calc.cos(a), ball.at(1) + 0.55 * calc.sin(a))
  })
  line(..rot, ..arrow-stroke(palette.red.line, 1.4pt))
})

/// Vue de dessus : `side` = -1 (rotation et déviation vers la gauche) ou 1 (droite)
#let top-view(side) = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let flow = palette.blue

  // Arrivée, point de rebond, rebond sans rotation (tout droit, en pointillé)
  let ball = (0, -1.9)
  line(ball, (0, 0), stroke: 1.8pt + flow.line)
  line((0, -1.1), (0, -0.9), ..arrow-stroke(flow.line, 1.8pt))
  line((0, 0), (0, 2.2), stroke: (paint: ink.transparentize(30%), thickness: 1pt, dash: "dashed"))
  // Rebond réel, dévié
  line((0, 0), (side * 1.1, 2.0), ..arrow-stroke(flow.line, 1.8pt))
  // Point de rebond
  let s = 0.12
  line((-s, -s), (s, s), stroke: 1pt + ink)
  line((-s, s), (s, -s), stroke: 1pt + ink)
  content((-side * 0.2, 0), anchor: if side > 0 { "east" } else { "west" }, text(size: 9pt, fill: ink, style: "italic")[rebond])

  // Balle, rotation autour de l'axe du déplacement : le dessus de la balle
  // va vers `side` (arc d'ellipse en perspective)
  circle(ball, radius: ball-r, fill: palette.neutral.fill, stroke: 1pt + palette.neutral.line)
  let (from, to) = if side > 0 { (200deg, 340deg) } else { (340deg, 200deg) }
  let rot = range(0, 21).map(i => {
    let a = from + (to - from) * i / 20
    (ball.at(0) + 0.6 * calc.cos(a), ball.at(1) + 0.12 + 0.16 * calc.sin(a))
  })
  line(..rot, ..arrow-stroke(palette.red.line, 1.4pt))
  // Ligne d'horizon (bas du dessin) pour aligner les deux rangées
  line((-1.6, -2.5), (1.6, -2.5), stroke: none)
})

#let label(body) = align(center, text(size: 10.5pt, fill: palette.neutral.text, body))
#let row-title(body) = align(center, text(size: 11pt, weight: "semibold", fill: palette.neutral.text, body))

#grid(
  columns: 2,
  column-gutter: 1.2cm,
  row-gutter: 6pt,
  align: center + bottom,
  grid.cell(colspan: 2, row-title[Vue de côté (la balle avance vers la droite)]),
  side-view(25deg, 1), side-view(68deg, -1),
  label[*Rotation avant* \ angle de rebond plus petit], label[*Rotation arrière* \ angle de rebond plus grand],
  grid.cell(colspan: 2, inset: (top: 12pt), row-title[Vue de dessus (la balle avance vers le haut)]),
  top-view(-1), top-view(1),
  label[*Rotation vers la gauche* \ déviation vers la gauche], label[*Rotation vers la droite* \ déviation vers la droite],
)
