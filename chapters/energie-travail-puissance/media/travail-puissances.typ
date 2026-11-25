#import "puissances-articulaires.typ": *


// Travail des forces internes à partir des puissances articulaires : les deux
// méthodes côte à côte, à partir des mêmes puissances (rangée A).
//   Méthode 2a : intégrale de la valeur absolue de la SOMME des puissances
//     B. somme; C. valeur absolue de la somme; D. aire (travail).
//   Méthode 2b : intégrale de la somme des VALEURS ABSOLUES des puissances
//     B. valeurs absolues; C. leur somme; D. aire (travail).
// Même échelle verticale partout : on compare directement les aires.

// `total` et non `sum` : `sum` masquerait le symbole Σ en math
#let total(t) = p-e(t) + p-c(t)
#let abs-sum(t) = calc.abs(total(t))
#let abs-e(t) = calc.abs(p-e(t))
#let abs-c(t) = calc.abs(p-c(t))
#let sum-abs(t) = abs-e(t) + abs-c(t)
#let neutral = (line: palette.neutral.line)
#let y-top = 1.9 // assez haut pour |P_e| + |P_c|

#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let col-gap = 3.2
  let (x-a, x-b) = (0, plot-w + col-gap) // colonnes 2a et 2b
  let row-a = 0
  let rows = (-5.3, -8.8, -12.7) // rangées B, C, D (D plus bas : sous la partie négative de C)
  // Lettre centrée verticalement sur le graphique (de son bas à son haut)
  let letter-at(y, negative) = (
    -1.4,
    y + (y-top + if negative { -1.2 } else { -0.15 }) * plot-h / 2,
  )

  // Chaque méthode dans son propre cadre (dessiné en premier, sous les
  // graphiques), pour la distinguer du point de départ commun (A)
  let y-title = rows.at(0) + y-top * plot-h + 0.95
  for x in (x-a, x-b) {
    rect(
      (x - 0.75, rows.at(2) - 0.95),
      (x + plot-w + 1.65, y-title + 0.6),
      radius: 0.2,
      fill: palette.neutral.fill,
      stroke: 0.8pt + palette.neutral.line.transparentize(50%),
    )
  }

  // Cadre du point de départ commun (A), avec un titre comme les méthodes
  let a-top = row-a + y-top * plot-h + 1.0
  rect(
    (x-a - 0.75, row-a - 1.2 * plot-h - 0.4),
    (x-b + plot-w + 1.65, a-top + 0.55),
    radius: 0.2,
    fill: palette.neutral.fill,
    stroke: 0.8pt + palette.neutral.line.transparentize(50%),
  )
  content(((x-a + x-b + plot-w) / 2 + 0.45, a-top), text(
    size: 12pt,
    weight: "bold",
    fill: ink,
  )[Exemple de puissances articulaires (communes aux deux méthodes)])

  // A : un peu resserré vers le centre (pas aligné sur les colonnes)
  let inset = 0.35
  step(letter-at(row-a, true), [A])
  plot(
    (x-a + inset, row-a),
    ((p-e, shoulder, false),),
    [$P_e$ (#unit[W])],
    y-max: y-top,
  )
  // « + » au milieu de l'espace libre (après le mot « temps » du premier graphique)
  content(
    (((x-a + inset + plot-w + 1.05) + (x-b - inset)) / 2, row-a + 0.6),
    text(size: 20pt, weight: "bold")[+],
  )
  plot(
    (x-b - inset, row-a),
    ((p-c, elbow, false),),
    [$P_c$ (#unit[W])],
    y-max: y-top,
  )

  // Titres des deux méthodes
  content((x-a + plot-w / 2, y-title), text(
    size: 12pt,
    weight: "bold",
    fill: ink,
  )[Méthode 2a : $integral abs(sum_k P_k) dif t$])
  content((x-b + plot-w / 2, y-title), text(
    size: 12pt,
    weight: "bold",
    fill: ink,
  )[Méthode 2b : $integral sum_k abs(P_k) dif t$])

  // B
  step(letter-at(rows.at(0), true), [B])
  plot(
    (x-a, rows.at(0)),
    ((total, neutral, false),),
    [$P_e + P_c$],
    y-max: y-top,
  )
  plot(
    (x-b, rows.at(0)),
    (
      (p-e, shoulder, true),
      (p-c, elbow, true),
      (abs-e, shoulder, false),
      (abs-c, elbow, false),
    ),
    [$abs(P_e)$ et $abs(P_c)$],
    y-max: y-top,
  )

  // C
  step(letter-at(rows.at(1), true), [C])
  plot(
    (x-a, rows.at(1)),
    ((total, neutral, true), (abs-sum, neutral, false)),
    [$abs(P_e + P_c)$],
    y-max: y-top,
  )
  plot(
    (x-b, rows.at(1)),
    ((sum-abs, neutral, false),),
    [$abs(P_e) + abs(P_c)$],
    negative: false,
    y-max: y-top,
  )

  // D
  step(letter-at(rows.at(2), false), [D])
  plot(
    (x-a, rows.at(2)),
    ((abs-sum, neutral, false),),
    [$abs(P_e + P_c)$],
    area: abs-sum,
    negative: false,
    y-max: y-top,
  )
  plot(
    (x-b, rows.at(2)),
    ((sum-abs, neutral, false),),
    [$abs(P_e) + abs(P_c)$],
    area: sum-abs,
    negative: false,
    y-max: y-top,
  )
})
