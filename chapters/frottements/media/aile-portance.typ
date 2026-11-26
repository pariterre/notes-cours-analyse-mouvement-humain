#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Portance d'une aile (profil NACA 2412) : l'air s'écoule plus vite sur le
// dessus (extrados; lignes de courant resserrées, basse pression) que sur le
// dessous (intrados; lignes plus espacées, pression plus élevée). La
// différence de pression donne la portance (perpendiculaire à l'écoulement);
// la traînée est dans le sens de l'écoulement. Couleurs : portance en gris,
// traînée en rouge (comme la figure portance/traînée).
// Remarque : l'explication « les deux filets d'air arrivent en même temps au
// bord de fuite » est un mythe; seule la différence de vitesse et de pression
// est illustrée ici.

#let chord = 6.0
// Profil NACA 4 chiffres : cambrure m, position p, épaisseur t (en fraction de corde)
#let (m, p, t) = (0.02, 0.4, 0.12)
#let thickness(u) = 5 * t * chord * (0.2969 * calc.sqrt(u) - 0.1260 * u - 0.3516 * u * u + 0.2843 * calc.pow(u, 3) - 0.1015 * calc.pow(u, 4))
#let camber(u) = chord * if u < p { m / (p * p) * (2 * p * u - u * u) } else { m / calc.pow(1 - p, 2) * ((1 - 2 * p) + 2 * p * u - u * u) }
#let upper(u) = (u * chord, camber(u) + thickness(u))
#let lower(u) = (u * chord, camber(u) - thickness(u))
// Points le long de la corde, resserrés près du bord d'attaque (arrondi)
#let us = range(0, 61).map(i => calc.pow(i / 60, 2))

/// Ligne de courant : horizontale loin de l'aile, elle s'écarte doucement
/// en passant au-dessus (ou au-dessous) de l'aile. `bulge` : écart maximal.
#let streamline(base, bulge) = range(0, 121).map(i => {
  let x = -2.5 + (chord + 5.0) * i / 120
  (x, base + bulge * calc.exp(-calc.pow((x - chord * 0.32) / (chord * 0.4), 2)))
})

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let flow = palette.blue

  // Lignes de courant : resserrées au-dessus (plus rapide), espacées en dessous
  // (ordonnée loin de l'aile, écart en passant l'aile)
  for (base, bulge) in ((0.5, 0.55), (0.95, 0.4), (1.45, 0.25), (-0.75, -0.12), (-1.35, -0.1), (-1.95, -0.08)) {
    line(..streamline(base, bulge), stroke: (paint: flow.line.lighten(30%), thickness: 1pt))
  }
  // Écoulement de l'air, venant de la gauche
  for y in (0.5, -0.75) {
    line((-2.5, y), (-1.6, y), stroke: 1.4pt + flow.line, mark: (end: "stealth", fill: flow.line, stroke: flow.line))
  }
  content((-2.5, 2.0), anchor: "west", text(size: 11pt, fill: flow.text, style: "italic")[écoulement de l'air])

  // Aile
  line(..us.map(upper), ..us.rev().map(lower), close: true, fill: palette.neutral.fill.darken(8%), stroke: 1.2pt + palette.neutral.line)

  // Pression : basse au-dessus (−), plus élevée en dessous (+)
  for u in (0.2, 0.45, 0.7) {
    let (x, y) = upper(u)
    // Entre la surface et la première ligne de courant
    content((x, y + 0.2), text(size: 14pt, weight: "bold", fill: flow.text)[−])
    let (xl, yl) = lower(u)
    content((xl, yl - 0.25), text(size: 13pt, weight: "bold", fill: palette.red.text)[+])
  }
  content((chord + 2.7, 1.2), anchor: "west", text(size: 11pt, fill: flow.text)[extrados : plus rapide, \ basse pression])
  content((chord + 2.7, -1.2), anchor: "west", text(size: 11pt, fill: palette.red.text)[intrados : plus lent, \ pression plus élevée])

  // Forces aérodynamiques
  let center = (chord * 0.3, camber(0.3))
  // Mêmes couleurs que la figure portance/traînée : portance (perpendiculaire
  // à l'écoulement) en gris, traînée (s'oppose au déplacement) en rouge
  line(center, (center.at(0), center.at(1) + 2.6), stroke: 3pt + palette.neutral.line, mark: (
    end: "stealth",
    fill: palette.neutral.line,
    stroke: palette.neutral.line,
    scale: 1.3,
  ))
  content((center.at(0), center.at(1) + 2.6), anchor: "south", padding: 0.1, text(size: 12pt, weight: "semibold", fill: palette.neutral.text)[portance])
  // Traînée dessinée au bord de fuite (dans le sens de l'écoulement) pour ne
  // pas surcharger l'aile
  let tail = (chord, 0)
  line(tail, (chord + 1.3, 0), stroke: 2.4pt + palette.red.line, mark: (
    end: "stealth",
    fill: palette.red.line,
    stroke: palette.red.line,
  ))
  content((chord + 1.3, 0), anchor: "west", padding: 0.08, text(size: 11pt, fill: palette.red.text)[traînée])
})
