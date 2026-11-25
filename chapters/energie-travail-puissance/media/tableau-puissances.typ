#import "../../../common/lib.typ": *


// Exercice : dépense énergétique à partir des puissances articulaires de
// l'épaule et du coude (méthodes 2a et 2b). Les colonnes de résultats sont
// calculées ici (aires par la méthode des trapèzes) et écrites en filigrane,
// comme le tableau d'impulsion du chapitre de cinétique en translation : les
// étudiants peuvent les remplir en exercice.

#let dt = 0.1
#let p-shoulder = (0, 5, 10, 15, 19, 22, 21, 16, 12, 11, 25, 30, 0, -20, -32, -31, -26, -17, -7, 0)
#let p-elbow = (0, 25, 26, 14, 15, 19, 22, 25, 28, 7, -2, -11, -11, -4, 3, 4, 3, 2, 1, 0)

#let n = p-shoulder.len()
#let sum-p = range(n).map(i => p-shoulder.at(i) + p-elbow.at(i))
#let abs-sum = sum-p.map(calc.abs)
#let sum-abs = range(n).map(i => calc.abs(p-shoulder.at(i)) + calc.abs(p-elbow.at(i)))
// Aire (trapèze) entre l'instant précédent et l'instant courant
#let area(values, i) = if i == 0 { none } else { (values.at(i - 1) + values.at(i)) / 2 * dt }
#let total(values) = range(1, n).map(i => area(values, i)).sum()

#let fmt(x) = if x == none { [---] } else { str(calc.round(x, digits: 2)) }
// Nombre avec un nombre fixe de décimales (le temps : 0.0, 0.1, …, 1.0, …)
#let fixed(x, digits) = {
  let scaled = str(int(calc.round(x * calc.pow(10, digits))))
  while scaled.len() <= digits { scaled = "0" + scaled }
  scaled.slice(0, -digits) + "." + scaled.slice(-digits)
}
// Réponse en filigrane (même gris que dans le chapitre de cinétique)
#let answer(x) = text(fill: luma(70%), fmt(x))

#set text(size: 9.5pt)
#let header-inset = (x: 5pt, y: 6pt) // en-têtes plus aérés que les données
#set par(justify: false) // pas d'espaces étirés dans les en-têtes
#block(fill: white, table(
  // Plus de place pour les colonnes dont l'en-tête est une formule
  columns: (0.9fr, 1fr, 1fr, 1.3fr, 1fr, 1fr, 1fr, 1fr),
  align: (col, row) => if row <= 1 { center + horizon } else { right + horizon },
  inset: (x: 5pt, y: 3.5pt),
  table.header(
    // Regroupement des colonnes : données, puis les deux méthodes (comme
    // dans la figure du calcul du travail)
    table.cell(colspan: 3, inset: header-inset)[Données],
    // La grandeur additionnée est définie dans le titre de la méthode
    table.cell(colspan: 3, inset: header-inset)[Méthode 2a \ $a_k = abs(P_e + P_c)$],
    table.cell(colspan: 2, inset: header-inset)[Méthode 2b \ $b_k = abs(P_e) + abs(P_c)$],
    // Grandeur sur la première ligne, unité sur la seconde (même style que
    // la première ligne d'en-tête, qui seule est stylée par le gabarit)
    ..(
      [Temps \ [#unit[s]]],
      [$P_"épaule"$ \ [#unit[W]]],
      [$P_"coude"$ \ [#unit[W]]],
      [$P_e + P_c$ \ [#unit[W]]],
      [$a_k$ \ [#unit[W]]],
      // Aire d'un trapèze : formule donnée dans le texte, au-dessus du tableau
      [Aire \ [#unit[J]]],
      [$b_k$ \ [#unit[W]]],
      [Aire \ [#unit[J]]],
    ).map(body => table.cell(fill: table-header-color, inset: header-inset, strong(body))),
  ),
  ..range(n)
    .map(i => (
      fixed(i * dt, 1),
      str(p-shoulder.at(i)),
      str(p-elbow.at(i)),
      answer(sum-p.at(i)),
      answer(abs-sum.at(i)),
      answer(area(abs-sum, i)),
      answer(sum-abs.at(i)),
      answer(area(sum-abs, i)),
    ))
    .flatten(),
  table.cell(colspan: 4, stroke: none)[],
  [$bold(W_(2a)) =$],
  answer(total(abs-sum)),
  [$bold(W_(2b)) =$],
  answer(total(sum-abs)),
))
