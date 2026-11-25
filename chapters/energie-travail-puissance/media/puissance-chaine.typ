#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// De la puissance métabolique à la performance. La puissance métabolique
// d'entrée (double flèche) se partage : environ trois quarts sont perdus en
// chaleur (thermorégulation, co-contractions…), le reste alimente la chaîne
// de la puissance mécanique jusqu'à la performance. Chaque étape de la chaîne
// est expliquée en dessous.

#let (w, h, tip) = (3.6, 1.8, 0.45) // largeur, hauteur et pointe des flèches
#let sep = 0.25 // écart constant entre une pointe et le bloc qui la reçoit

#let stages = (
  (
    [Puissance mécanique interne],
    palette.blue,
    [Produite par les muscles actionneurs du mouvement : forces et moments articulaires],
  ),
  (
    [Puissance mécanique externe],
    palette.green,
    [Travail mécanique externe (échangé avec l'environnement)],
  ),
  (
    [Tâche imposée : la performance],
    palette.gold,
    [_Ex._ détente verticale : élévation du centre de masse (énergie potentielle, travail du poids)],
  ),
)

// Texte centré, sans justification ni coupure de mots (le livre justifie
// et coupe les mots par défaut)
#set par(justify: false)
#set text(hyphenate: false)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let heat = palette.red
  let label(at, width, shade, body, size: 11pt) = content(at, box(width: width * 1cm, align(center, text(
    size: size,
    weight: "semibold",
    fill: shade.text,
    body,
  ))))

  // Bloc d'entrée en double flèche : une pointe (comme les autres flèches)
  // vers la perte en chaleur, une vers la chaîne mécanique. Le bloc de
  // chaleur est juste au-dessus de la chaîne, de même hauteur.
  let (hb-lo, hb-hi) = (h + 0.35, 2 * h + 0.35)
  let x-in = w * 0.75
  let x-chain = x-in + sep
  line(
    (0, 0),
    (x-in, 0),
    (x-in + tip, h / 2), // pointe vers la chaîne mécanique
    (x-in, h),
    (x-in, hb-lo),
    (x-in + tip, (hb-lo + hb-hi) / 2), // pointe vers la chaleur
    (x-in, hb-hi),
    (0, hb-hi),
    close: true,
    fill: palette.neutral.fill,
    stroke: 1.2pt + palette.neutral.line,
  )
  label((x-in / 2, hb-hi / 2), x-in - 0.2, palette.neutral)[Puissance métabolique d'entrée]

  // Perte en chaleur
  line(
    (x-chain, hb-lo),
    (x-chain + w, hb-lo),
    (x-chain + w, hb-hi),
    (x-chain, hb-hi),
    (x-chain + tip, (hb-lo + hb-hi) / 2), // reçoit la pointe du bloc d'entrée
    close: true,
    fill: heat.fill,
    stroke: 1.2pt + heat.line,
  )
  label((x-chain + w / 2 + tip / 2, (hb-lo + hb-hi) / 2), w - tip - 0.2, heat)[Perte en chaleur \ #text(weight: "regular", size: 10pt)[(≈ ¾ de l'énergie)]]
  // Explication à droite du bloc (place libre au-dessus de la chaîne)
  let y-mid = (hb-lo + hb-hi) / 2
  line((x-chain + w + 0.1, y-mid), (x-chain + w + 0.55, y-mid), stroke: 1pt + heat.line, mark: (
    start: "stealth",
    fill: heat.line,
    scale: 0.7,
  ))
  content((x-chain + w + 0.6, y-mid), anchor: "west", box(width: (w - 0.25) * 1cm, align(left, text(
    size: 10pt,
    fill: ink,
  )[Thermorégulation, co‑contractions…])))

  // Chaîne de la puissance mécanique
  let n = stages.len()
  for (i, (title, shade, note)) in stages.enumerate() {
    let x = x-chain + i * (w + sep)
    let point = if i == n - 1 { 0 } else { tip }
    line(
      (x, 0),
      (x + w, 0),
      (x + w + point, h / 2),
      (x + w, h),
      (x, h),
      (x + tip, h / 2),
      close: true,
      fill: shade.fill,
      stroke: 1.2pt + shade.line,
    )
    label((x + w / 2 + tip / 2, h / 2), w - tip - 0.2, shade, title)
    // Explication sous l'étape
    line((x + w / 2, -0.1), (x + w / 2, -0.55), stroke: 1pt + shade.line, mark: (
      start: "stealth",
      fill: shade.line,
      scale: 0.7,
    ))
    content((x + w / 2, -0.6), anchor: "north", box(width: (w - 0.25) * 1cm, align(center, text(
      size: 10pt,
      fill: ink,
      note,
    ))))
  }
})
