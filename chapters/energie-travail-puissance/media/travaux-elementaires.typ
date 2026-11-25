#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Travaux élémentaires : le chemin de A à B est découpé en petits
// déplacements Δu_t; sur chacun, la force F_t (qui varie) produit un travail
// élémentaire ΔW_t = F_t · Δu_t. Chaque déplacement est coloré selon le signe
// de ce travail (calculé) : vert si positif, rouge si négatif.
// Le travail total est la somme des travaux élémentaires.

// Points du chemin (le déplacement élémentaire va du point k au point k + 1)
#let path = ((0, 0), (2.0, 1.3), (4.1, 0.5), (6.1, 1.4), (8.0, 0.3))
// Direction de la force au début de chaque déplacement
#let force-angles = (70deg, 120deg, 50deg, 110deg)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let f-len = 1.3
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))

  // Trajectoire réelle (courbe) en arrière-plan
  // En bleu, comme les déplacements des autres figures du chapitre
  hobby(..path, stroke: (paint: palette.blue.line.lighten(55%), thickness: 5pt, cap: "round"))

  // Objet déplacé : bloc bleu, estompé au départ (A), plein à l'arrivée (B);
  // dessiné sous les flèches
  let side = 0.5
  for (p, alpha) in ((path.first(), 55%), (path.last(), 0%)) {
    rect(
      (p.at(0) - side / 2, p.at(1) - side / 2),
      (p.at(0) + side / 2, p.at(1) + side / 2),
      radius: 0.04,
      fill: palette.blue.fill.lighten(alpha),
      stroke: 1.2pt + palette.blue.line.lighten(alpha),
    )
  }

  // Pointe de flèche : pleine (travail positif) ou creuse (négatif)
  let head(shade, positive) = (
    end: "stealth",
    fill: if positive { shade.line } else { white },
    stroke: 1.4pt + shade.line,
    scale: 1.7, // assez grande pour bien voir si elle est pleine ou creuse
  )

  for k in range(path.len() - 1) {
    let (p, q) = (path.at(k), path.at(k + 1))
    let du = (q.at(0) - p.at(0), q.at(1) - p.at(1))
    let f = polar(f-len, force-angles.at(k))
    let work = f.at(0) * du.at(0) + f.at(1) * du.at(1)
    let shade = if work > 0.05 { palette.green } else if work < -0.05 { palette.red } else { palette.neutral }
    // Déplacement élémentaire, coloré selon le signe du travail
    // Second repère que la couleur (daltonisme) : pointe pleine si le travail
    // est positif, creuse s'il est négatif
    line(p, q, stroke: 2.6pt + shade.line, mark: head(shade, work > 0))
    // Nom du déplacement, sous le segment (côté droit du sens de parcours)
    let n = calc.sqrt(du.at(0) * du.at(0) + du.at(1) * du.at(1))
    let below = (du.at(1) / n * 0.5, -du.at(0) / n * 0.5)
    let mid = ((p.at(0) + q.at(0)) / 2, (p.at(1) + q.at(1)) / 2)
    content(add(mid, below), text(size: 12pt, fill: shade.text)[$Delta arrow(u)_#k$])
    // Force au début du déplacement, avec son nom au bout
    line(p, add(p, f), stroke: 1.4pt + palette.neutral.line, mark: (
      end: "stealth",
      fill: palette.neutral.line,
      stroke: palette.neutral.line,
      scale: 0.8,
    ))
    content(add(p, polar(f-len + 0.35, force-angles.at(k))), text(size: 12pt, fill: palette.neutral.text)[$arrow(F)_#k$])
  }
  // Travail élémentaire (formule générale)
  content((8.85, 2.3), anchor: "west", box(
    fill: white,
    stroke: 0.8pt + palette.neutral.line,
    inset: 4pt,
    radius: 3pt,
    text(size: 11pt, fill: ink)[$Delta W_t = arrow(F)_t dot Delta arrow(u)_t$],
  ))

  // Points A et B
  for (p, name, anchor) in ((path.first(), $A$, "east"), (path.last(), $B$, "west")) {
    circle(p, radius: 0.07, fill: ink, stroke: 1pt + white)
    content(p, anchor: anchor, padding: 0.35, text(size: 14pt, weight: "bold", fill: ink, name))
  }

  // Légende
  let legend(y, shade, body, sign) = {
    line((8.9, y), (9.7, y), stroke: 2.6pt + shade.line, mark: head(shade, sign == $+$))
    content((9.85, y), anchor: "west", text(size: 11pt, fill: shade.text, body))
  }
  legend(1.6, palette.green, [$Delta W_t > 0$], $+$)
  legend(1.0, palette.red, [$Delta W_t < 0$], $-$)
})
