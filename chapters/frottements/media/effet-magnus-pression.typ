#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Effet Magnus, ballon vu de dessus (même situation que le coup franc : le
// ballon avance vers le haut et tourne dans le sens antihoraire). Dans le
// repère du ballon, l'air arrive du haut. À gauche, la surface du ballon
// tourne dans le même sens que l'écoulement : l'air y est plus rapide (lignes
// resserrées, basse pression). À droite, elle s'y oppose : air plus lent
// (lignes espacées, pression plus élevée). La force de Magnus va des hautes
// vers les basses pressions, donc vers la gauche; en réaction, l'air est
// dévié vers la droite derrière le ballon.
// Mêmes conventions que la figure de l'aile : écoulement et « − » en bleu,
// « + » en rouge, force en gris; rotation en rouge comme pour le coup franc.

#let radius = 1.2
#let (y-top, y-bottom) = (4.2, -4.2)

/// Ligne de courant verticale : s'écarte en passant le ballon (`bulge`) et
/// est déviée vers la droite derrière lui (sillage)
#let streamline(base, bulge) = range(0, 121).map(i => {
  let y = y-top + (y-bottom - y-top) * i / 120
  let wake = if y < 0 { 0.45 * (1 - calc.exp(-calc.pow(y / 2.2, 2))) } else { 0 }
  (base + bulge * calc.exp(-calc.pow(y / 1.7, 2)) + wake * calc.exp(-calc.pow(base / 3.5, 2)), y)
})

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let flow = palette.blue

  // Lignes de courant : resserrées à gauche (rapide), espacées à droite (lent)
  for (base, bulge) in ((-1.6, -0.12), (-2.05, -0.09), (-2.5, -0.06), (1.65, 0.45), (2.5, 0.35), (3.35, 0.25)) {
    line(..streamline(base, bulge), stroke: (paint: flow.line.lighten(30%), thickness: 1pt))
  }
  // Vitesse relative de l'air (le ballon avance vers le haut)
  for x in (-2.05, 2.5) {
    line((x, y-top), (x, y-top - 0.9), stroke: 1.4pt + flow.line, mark: (end: "stealth", fill: flow.line, stroke: flow.line))
  }
  content((0.3, y-top - 0.45), box(fill: white, inset: 4pt, text(size: 11pt, fill: flow.text, style: "italic", align(center)[vitesse relative \ de l'air])))

  // Ballon
  circle((0, 0), radius: radius, fill: palette.neutral.fill, stroke: 1.2pt + palette.neutral.line)

  // Rotation (antihoraire vue de dessus), dessinée dans le ballon
  for start in (25deg, 205deg) {
    let spin = range(0, 31).map(i => {
      let a = start + 130deg * i / 30
      (0.82 * calc.cos(a), 0.82 * calc.sin(a))
    })
    line(..spin, stroke: 1.6pt + palette.red.line, mark: (end: "stealth", fill: palette.red.line, stroke: palette.red.line, scale: 0.7))
  }
  content((0, 0.4), text(size: 9pt, fill: palette.red.text)[rotation])

  // Pressions : basse à gauche (−), plus élevée à droite (+)
  for y in (-0.75, 0.75) {
    content((-radius - 0.22 + calc.abs(y) * 0.1, y), text(size: 13pt, weight: "bold", fill: flow.text)[−])
    content((radius + 0.3 - calc.abs(y) * 0.15, y), text(size: 12pt, weight: "bold", fill: palette.red.text)[+])
  }
  content((-2.85, 1.3), anchor: "east", text(size: 11pt, fill: flow.text, align(right)[air plus rapide, \ basse pression]))
  content((3.9, 1.3), anchor: "west", text(size: 11pt, fill: palette.red.text, align(left)[air plus lent, \ pression plus élevée]))

  // Vitesse du ballon (vers le haut, opposée à la vitesse relative de l'air)
  line((0, radius), (0, 2.7), stroke: 2.6pt + flow.line, mark: (end: "stealth", fill: flow.line, stroke: flow.line, scale: 1.2))
  content((0.1, 2.2), anchor: "west", text(size: 12pt, fill: flow.text)[$arrow(v)_"ballon"$])

  // Force de Magnus : des hautes vers les basses pressions
  line((0, 0), (-2.9, 0), stroke: 3pt + palette.neutral.line, mark: (end: "stealth", fill: palette.neutral.line, stroke: palette.neutral.line, scale: 1.2))
  content((-2.9, 0), anchor: "east", padding: 0.1, box(fill: white, inset: 3pt, text(size: 11pt, weight: "semibold", fill: palette.neutral.text, align(right)[force \ de Magnus])))
  circle((0, 0), radius: 0.07, fill: ink, stroke: 1pt + white)
})
