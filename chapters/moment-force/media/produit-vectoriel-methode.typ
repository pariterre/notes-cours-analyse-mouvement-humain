#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Moyen mnémotechnique du produit vectoriel C = A ∧ B :
//   - écrire A et B en deux colonnes, barrer la ligne des x,
//   - recopier x et y en dessous (5 lignes),
//   - chaque composante de C se lit sur une croix reliant deux lignes
//     voisines : produit en descendant moins produit en montant.

#let rows = ("x", "y", "z", "x", "y")
// (première ligne de la paire, composante obtenue, couleur)
#let components = (
  (1, "x", palette.red),
  (2, "y", palette.green),
  (3, "z", palette.blue),
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let dy = 0.85
  let (col-a, col-b) = (0, 1.7)
  let y-of(i) = -i * dy
  let entry(name, vec) = eval("$" + name + "_" + vec + "$")

  // En-têtes et colonnes
  content((col-a, 0.95), text(size: 14pt, fill: ink, $arrow(A)$))
  content(((col-a + col-b) / 2, 0.95), text(size: 14pt, fill: ink, $and$))
  content((col-b, 0.95), text(size: 14pt, fill: ink, $arrow(B)$))
  for x in (col-a, col-b) {
    rect((x - 0.5, 0.45), (x + 0.5, y-of(4) - 0.4), radius: 0.2, stroke: none, fill: palette.neutral.fill)
  }

  // Composantes : première ligne barrée, deux dernières recopiées (estompées)
  for (i, name) in rows.enumerate() {
    let shade = if i == 0 { ink.transparentize(55%) } else if i >= 3 { ink.transparentize(30%) } else { ink }
    for (x, v) in ((col-a, "A"), (col-b, "B")) {
      content((x, y-of(i)), text(size: 14pt, fill: shade, entry(name, v)))
    }
  }
  line((col-a - 0.45, y-of(0)), (col-b + 0.45, y-of(0)), stroke: 1.5pt + ink.transparentize(30%))
  // Repère « recopiées » à gauche, la droite étant prise par les résultats
  content((col-a - 1.05, (y-of(3) + y-of(4)) / 2), anchor: "east", text(
    size: 10pt,
    fill: ink,
    style: "italic",
  )[recopiées])
  line((col-a - 1.0, y-of(3) + 0.25), (col-a - 1.0, y-of(4) - 0.25), stroke: 0.8pt + ink.transparentize(40%))

  // Une croix par composante, entre deux lignes voisines : produit en
  // descendant moins produit en montant
  let gap = 0.42
  for (i, comp, shade) in components {
    let (y0, y1) = (y-of(i), y-of(i + 1))
    let stroke = (paint: shade.line, thickness: 2pt, cap: "round")
    line((col-a + gap, y0 - 0.1), (col-b - gap, y1 + 0.1), stroke: stroke)
    // Produit en montant (soustrait) : pointillé
    line((col-a + gap, y1 + 0.1), (col-b - gap, y0 - 0.1), stroke: (..stroke, dash: "dashed"))
  }

  // Résultat, à la hauteur de chaque croix
  let x-res = 3.0
  for (i, comp, shade) in components {
    let (a, b) = (rows.at(i), rows.at(i + 1))
    let y = (y-of(i) + y-of(i + 1)) / 2
    content((x-res, y), anchor: "west", text(size: 14pt, fill: shade.text)[
      $#entry(comp, "C") = #entry(a, "A") dot #entry(b, "B") - #entry(b, "A") dot #entry(a, "B")$
    ])
  }
})
