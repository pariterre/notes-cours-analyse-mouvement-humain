#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Objet incliné dans un écoulement : la force aérodynamique se décompose en
// traînée (dans le sens de l'écoulement, C_x) et portance (perpendiculaire,
// C_z). Couleurs comme pour la réaction du sol (loi de Coulomb) : la
// composante qui s'oppose au déplacement en rouge, la composante
// perpendiculaire en gris, la résultante en or. Écoulement en bleu (comme la
// figure de l'aile).

#let tilt = -25deg // objet incliné (bord d'attaque relevé face à l'écoulement)
#let (drag, lift) = (2.4, 1.7)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let flow = palette.blue
  let vec(from, to, shade, width: 2.6pt) = line(from, to, stroke: width + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.2,
  ))

  // Écoulement (vitesse relative) : lignes de courant régulièrement espacées
  // en amont, qui contournent l'objet. Modèle : écoulement autour d'un
  // cylindre (ψ = Y (1 - r² / (X² + Y²)) constant le long d'une ligne), étiré
  // horizontalement (X = x / stretch) pour épouser l'objet allongé.
  // En aval, l'objet a dévié l'air vers le bas (réaction de la portance) :
  // les lignes de courant repartent légèrement vers le bas.
  let (r, stretch) = (1.2, 1.55)
  let (x-start, x-end) = (-4.6, 5.4)
  // Ordonnée de la ligne de courant b à l'abscisse x (bissection)
  let deflected(b, x) = {
    let xx = x / stretch
    let lo = calc.sqrt(calc.max(r * r - xx * xx, 0)) + 1e-6
    let hi = calc.abs(b) + r
    for _ in range(40) {
      let mid = (lo + hi) / 2
      if mid * (1 - r * r / (xx * xx + mid * mid)) < calc.abs(b) { lo = mid } else { hi = mid }
    }
    if b > 0 { lo } else { -lo }
  }
  let streamline(b) = range(0, 121).map(i => {
    let x = x-start + (x-end - x-start) * i / 120
    let y = deflected(b, x)
    if x > 0 {
      // Déviation vers le bas en aval, plus marquée près de l'objet
      y = y - 0.22 * (calc.sqrt(x * x + 1) - 1)
    }
    (x, y)
  })
  for b in (-1.5, -1.0, -0.5, 0.5, 1.0, 1.5) {
    line(..streamline(b), stroke: (paint: flow.line.lighten(30%), thickness: 1pt))
  }
  for b in (-1.0, 1.0) {
    line((x-start, b), (x-start + 0.9, b), stroke: 1.4pt + flow.line, mark: (end: "stealth", fill: flow.line, stroke: flow.line))
  }
  content((x-start, 0), anchor: "west", box(fill: white, inset: 4pt, text(size: 11pt, fill: flow.text, style: "italic", align(left)[vitesse relative \ de l'écoulement])))

  // Objet incliné (ellipse tournée)
  let ellipse = range(0, 61).map(i => {
    let a = 360deg * i / 60
    let (x, y) = (1.7 * calc.cos(a), 0.32 * calc.sin(a))
    (x * calc.cos(tilt) - y * calc.sin(tilt), x * calc.sin(tilt) + y * calc.cos(tilt))
  })
  line(..ellipse, close: true, fill: palette.neutral.fill.darken(8%), stroke: 1.2pt + palette.neutral.line)

  // Construction de la résultante
  let guide = (paint: ink.transparentize(45%), thickness: 0.7pt, dash: "dashed")
  line((drag, 0), (drag, lift), (0, lift), stroke: guide)

  vec((0, 0), (drag, 0), palette.red)
  content((drag, 0), anchor: "west", padding: 0.12, box(fill: white, inset: 4pt, radius: 2pt, text(size: 12pt, fill: palette.red.text)[traînée ($C_x$)]))
  vec((0, 0), (0, lift), palette.neutral)
  content((0, lift), anchor: "south", padding: 0.1, box(fill: white, inset: 4pt, radius: 2pt, text(size: 12pt, fill: palette.neutral.text)[portance ($C_z$)]))
  vec((0, 0), (drag, lift), palette.gold, width: 3pt)
  content((drag, lift), anchor: "south-west", padding: 0.08, box(fill: white, inset: 4pt, radius: 2pt, text(size: 12pt, weight: "semibold", fill: palette.gold.text)[résultante]))
  circle((0, 0), radius: 0.07, fill: ink, stroke: 1pt + white)
})
