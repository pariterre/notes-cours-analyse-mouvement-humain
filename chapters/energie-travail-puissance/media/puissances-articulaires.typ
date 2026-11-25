#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Outils communs aux deux figures du calcul du travail à partir des
// puissances articulaires (méthodes 2a et 2b). Les mêmes courbes de puissance
// de l'épaule (P_e) et du coude (P_c) servent aux deux méthodes.
// Couleurs : épaule en bleu, coude en violet, somme en gris foncé, travail
// (le résultat) en or.

#let purple = (fill: rgb("#f1e4f7"), line: rgb("#7b1fa2"), text: rgb("#561571"))
#let shoulder = palette.blue
#let elbow = purple

#let _bump(t, c, w) = calc.exp(-calc.pow((t - c) / w, 2))
/// Puissance de l'épaule (t de 0 à 1, unités arbitraires)
#let p-e(t) = 1.0 * _bump(t, 0.13, 0.06) + 0.75 * _bump(t, 0.33, 0.12) - 0.75 * _bump(t, 0.6, 0.06) + 0.25 * _bump(t, 0.8, 0.07)
/// Puissance du coude
#let p-c(t) = 0.6 * _bump(t, 0.28, 0.13) + 1.0 * _bump(t, 0.56, 0.04) - 1.05 * _bump(t, 0.8, 0.08)

#let (plot-w, plot-h) = (4.2, 0.9) // largeur, hauteur pour une puissance de 1

/// Un graphique (dans un canevas CeTZ), origine des axes en `at`.
/// - curves (array): (fonction, couleur, pointillé?) à tracer.
/// - area (function, none): si donnée, l'aire sous cette courbe est remplie
///   (le travail).
/// - y-label (content): nom de l'axe vertical.
#let plot(at, curves, y-label, area: none, negative: true, y-max: 1.25) = {
  import cetz.draw: *
  let ink = palette.neutral.text
  let n = 120
  let ts = range(n + 1).map(i => i / n)
  let pt(t, v) = (at.at(0) + t * plot-w, at.at(1) + v * plot-h)
  let y-lo = if negative { -1.2 } else { -0.15 }

  if area != none {
    line(pt(0, 0), ..ts.map(t => pt(t, area(t))), pt(1, 0), close: true, fill: palette.gold.fill, stroke: none)
    // Nom sous l'axe : l'aire elle-même reste dégagée
    content(pt(0.5, 0), anchor: "north", padding: 0.12, text(size: 12pt, weight: "bold", fill: palette.gold.text)[aire = travail])
  }
  // Axes
  let arrow-mark = (end: "stealth", fill: ink, stroke: ink)
  line(pt(0, 0), pt(1.08, 0), stroke: 0.8pt + ink, mark: arrow-mark)
  line(pt(0, y-lo), pt(0, y-max), stroke: 0.8pt + ink, mark: arrow-mark)
  content(pt(1.08, 0), anchor: "west", padding: 0.08, text(size: 10pt, fill: ink)[temps])
  // Nom de la grandeur centré au-dessus du graphique
  content(pt(0.5, y-max), anchor: "south", padding: 0.05, text(size: 11pt, fill: ink, y-label))
  // Courbes
  for (f, shade, dotted) in curves {
    line(..ts.map(t => pt(t, f(t))), stroke: (
      paint: shade.line,
      thickness: if dotted { 1.2pt } else { 2.2pt },
      dash: if dotted { "dotted" } else { none },
      join: "round",
    ))
  }
}

/// Lettre d'une étape (A, B, C, D) à gauche de la rangée
#let step(at, letter) = {
  import cetz.draw: *
  content(at, text(size: 16pt, weight: "bold", fill: palette.neutral.text, letter))
}
