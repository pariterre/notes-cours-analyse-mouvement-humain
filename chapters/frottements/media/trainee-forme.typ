#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Traînée de forme : cube, boule et goutte d'eau de même surface frontale.
// La traînée passe de 100 % (cube) à 50 % (boule) puis 5 % (goutte).
// L'écoulement vient de la gauche : la goutte présente son côté arrondi à
// l'écoulement et s'effile vers l'arrière.
// Objet et surface frontale en bleu pâle (même objet), traînée en rouge
// (barres proportionnelles).

#let diameter = 1.6
// Même aire frontale : côté du carré tel que côté² = π d² / 4
#let side = diameter * calc.sqrt(calc.pi) / 2
#let row-gap = 2.4
#let bar-max = 3.2

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let object = (fill: palette.blue.fill, stroke: 1.2pt + palette.blue.line)
  let frontal = object
  let (x-shape, x-front, x-bar) = (0, 4.2, 6.2)

  // En-têtes de colonnes
  let header(x, body) = content((x, 1.6), text(size: 11pt, weight: "semibold", fill: ink, body))
  header(x-shape, [Forme])
  header(x-front, [Surface frontale])
  content((x-bar, 1.6), anchor: "west", text(size: 11pt, weight: "semibold", fill: ink)[Traînée de forme])

  // Écoulement, venant de la gauche
  let flow = palette.blue
  line((-2.4, 1.6), (-1.5, 1.6), stroke: 1.4pt + flow.line, mark: (end: "stealth", fill: flow.line, stroke: flow.line))
  content((-2.4, 1.6), anchor: "east", padding: 0.1, text(size: 10pt, fill: flow.text, style: "italic")[écoulement])

  let rows = (
    ("cube", [Cube], 100),
    ("ball", [Boule], 50),
    ("drop", [Goutte d'eau], 5),
  )
  for (i, (kind, name, drag)) in rows.enumerate() {
    let y = -i * row-gap

    // Forme vue de côté (l'écoulement arrive par la gauche)
    if kind == "cube" {
      // Cube en perspective : face avant, dessus et côté
      let (h, d) = (side / 2, 0.45)
      rect((-h, y - h), (h, y + h), ..object)
      line((-h, y + h), (-h + d, y + h + d), (h + d, y + h + d), (h, y + h), close: true, fill: palette.blue.fill.lighten(40%), stroke: object.stroke)
      line((h, y + h), (h + d, y + h + d), (h + d, y - h + d), (h, y - h), close: true, fill: palette.blue.fill.darken(10%), stroke: object.stroke)
    } else if kind == "ball" {
      circle((0, y), radius: diameter / 2, ..object)
    } else {
      // Goutte : avant arrondi (demi-cercle) puis queue effilée vers l'arrière
      let r = diameter / 2
      let tail = 2.6
      // Goutte centrée dans la colonne
      let x0 = (r - tail) / 2
      let front = range(0, 41).map(k => {
        let a = 90deg + 180deg * k / 40
        (r * calc.cos(a) + x0, y + r * calc.sin(a))
      })
      // Arrière : courbe douce de (x0, ±r) jusqu'à la pointe
      let back(sign) = range(1, 41).map(k => {
        let t = k / 40
        (x0 + tail * t, y + sign * r * (1 - t * t) * (1 - 0.3 * t))
      })
      line(..front, ..back(-1), ..back(1).rev(), close: true, ..object)
    }
    content((x-shape, y - diameter / 2 - 0.15), anchor: "north", text(size: 11pt, fill: ink, name))

    // Surface frontale (même aire pour les trois objets)
    if kind == "cube" {
      rect((x-front - side / 2, y - side / 2), (x-front + side / 2, y + side / 2), ..frontal)
    } else {
      circle((x-front, y), radius: diameter / 2, ..frontal)
    }

    // Traînée de forme : barre proportionnelle
    let len = bar-max * drag / 100
    rect((x-bar, y - 0.3), (x-bar + len, y + 0.3), fill: palette.red.fill, stroke: 1pt + palette.red.line)
    content((x-bar + len, y), anchor: "west", padding: 0.15, text(size: 12pt, weight: "semibold", fill: palette.red.text)[#drag~%])
  }
  line((x-bar, 0.8), (x-bar, -2 * row-gap - 0.8), stroke: 0.8pt + ink)
})
