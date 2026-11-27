#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Évolution des modèles musculaires, chacun tendu verticalement entre ses deux
// attaches : (A) ressort, (B) ressort amorti, (C) avec un élément élastique en
// série, (D) élément contractile, (E) modèle de Hill à trois éléments.

#let elastic = palette.blue
#let damper = palette.gold
#let contractile = palette.red
#let wire = 1.2pt + palette.dark.fill

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (bottom, top) = (0, 5) // attaches de chaque modèle

  // Fil de liaison vertical
  let link(x, a, b) = line((x, a), (x, b), stroke: wire)

  // Ressort (élément élastique) entre a et b. Même largeur et même pas de
  // dent pour tous les ressorts : seul le nombre de dents dépend de la longueur.
  let spring(x, a, b) = {
    let (w, pitch, lead) = (0.18, 0.16, 0.5) // lead : bout droit minimal
    // Pas fixe ; la longueur restante va aux bouts droits, de part et d'autre
    let n = calc.max(2, int(calc.floor((b - a - 2 * lead) / pitch)))
    let lead = (b - a - n * pitch) / 2
    let pts = range(n).map(i => (x + (if calc.even(i) { w } else { -w }), a + lead + (i + 0.5) * pitch))
    line((x, a), (x, a + lead), ..pts, (x, b - lead), (x, b), stroke: (
      paint: elastic.line,
      thickness: 1.4pt,
      join: "miter",
    ))
  }

  // Amortisseur : cylindre ouvert vers le haut, piston qui descend dedans
  let dashpot(x, a, b, w: 0.2) = {
    let c = (a + b) / 2 - 0.3 // fond du cylindre
    link(x, a, c)
    line((x - w, c + 0.6), (x - w, c), (x + w, c), (x + w, c + 0.6), fill: damper.fill, stroke: 1.4pt + damper.line)
    line((x - 0.7 * w, c + 0.3), (x + 0.7 * w, c + 0.3), stroke: 1.8pt + damper.line)
    line((x, c + 0.3), (x, b), stroke: wire)
  }

  // Élément contractile : boîte, placée entre a et b selon `position`
  // (0 : en bas, 0.5 : au milieu, 1 : en haut)
  let ce(x, a, b, w: 0.25, position: 0.5) = {
    let h = calc.min(0.35, (b - a) / 2)
    let m = a + h + position * (b - a - 2 * h)
    link(x, a, m - h)
    rect((x - w, m - h), (x + w, m + h), fill: contractile.fill, stroke: 1.4pt + contractile.line)
    link(x, m + h, b)
  }

  // Deux branches en parallèle entre a et b, écartées de ±gap
  let parallel(x, a, b, left, right, gap: 0.42) = {
    line((x - gap, a), (x + gap, a), stroke: wire)
    line((x - gap, b), (x + gap, b), stroke: wire)
    left(x - gap, a, b)
    right(x + gap, a, b)
  }

  let models = (
    (
      "A",
      [Weber\ 1846],
      x => {
        link(x, bottom, 1.2)
        spring(x, 1.2, 3.8)
        link(x, 3.8, top)
      },
    ),
    (
      "B",
      [Hill\ 1922],
      x => {
        link(x, bottom, 1.3)
        parallel(x, 1.3, 3.7, spring, dashpot)
        link(x, 3.7, top)
      },
    ),
    (
      "C",
      [Levin et Wyman\ 1927],
      x => {
        link(x, bottom, 0.8)
        parallel(x, 0.8, 2.9, spring, dashpot)
        link(x, 2.9, 3.1)
        spring(x, 3.1, top)
      },
    ),
    (
      "D",
      [Hill\ 1938],
      x => {
        link(x, bottom, 0.7)
        ce(x, 0.7, 2.0)
        spring(x, 2.0, 4.0)
        link(x, 4.0, top)
      },
    ),
    (
      "E",
      [Hill\ 1951],
      x => {
        link(x, bottom, 0.75)
        // Branche droite : un ressort de 6 dents en haut (comme D), l'élément
        // contractile attaché directement sous ce ressort
        parallel(x, 0.75, 4.25, spring, (x, a, b) => {
          ce(x, a, b - 2.1, position: 1)
          spring(x, b - 2.1, b)
        })
        link(x, 4.25, top)
      },
    ),
  )

  let spacing = 2.3
  for (i, (letter, author, draw)) in models.enumerate() {
    let x = i * spacing
    draw(x)
    content((x, bottom - 0.3), anchor: "north", text(weight: "semibold", letter))
    content((x, bottom - 0.8), anchor: "north", align(center, text(size: 8.5pt, author)))
  }

  // Légende
  let ly = -2.55
  let lx = (0, 3.3, 6.4)
  spring(lx.at(0), ly - 0.75, ly + 0.75)
  content((lx.at(0) + 0.35, ly), anchor: "west", text(size: 9pt)[Élément élastique])
  dashpot(lx.at(1), ly - 0.5, ly + 0.5)
  content((lx.at(1) + 0.35, ly), anchor: "west", text(size: 9pt)[Amortisseur])
  ce(lx.at(2), ly - 0.35, ly + 0.35)
  content((lx.at(2) + 0.4, ly), anchor: "west", text(size: 9pt)[Élément contractile])
})
