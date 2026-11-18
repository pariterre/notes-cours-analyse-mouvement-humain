#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Position, vitesse et accélération : on passe de l'une à la suivante par
// dérivation (vers la droite) et à la précédente par intégration (vers la
// gauche). Couleurs des grandeurs communes aux figures du chapitre.
#let quantities = (
  ([Position], palette.blue),
  ([Vitesse], palette.green),
  ([Accélération], palette.gold),
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (w, h, gap) = (3.0, 1.1, 2.4)
  let node-center(i) = (i * (w + gap), 0)

  for (i, (name, shade)) in quantities.enumerate() {
    let (cx, cy) = node-center(i)
    rect(
      (cx - w / 2 + 0.06, cy - h / 2 - 0.06),
      (cx + w / 2 + 0.06, cy + h / 2 - 0.06),
      radius: 0.2,
      fill: palette.shadow,
      stroke: none,
    )
    rect(
      (cx - w / 2, cy - h / 2),
      (cx + w / 2, cy + h / 2),
      radius: 0.2,
      fill: shade.fill,
      stroke: 1.2pt + shade.line,
    )
    content((cx, cy), text(
      size: 12pt,
      weight: "semibold",
      fill: shade.text,
      name,
    ))
  }

  let ink = palette.neutral.text
  for i in range(quantities.len() - 1) {
    let x0 = node-center(i).at(0) + w / 2 + 0.2
    let x1 = node-center(i + 1).at(0) - w / 2 - 0.2
    let arrow-style(paint) = (
      stroke: (paint: paint, thickness: 1.8pt),
      mark: (end: "stealth", fill: paint, stroke: paint, scale: 1.3),
    )
    line((x0, 0.25), (x1, 0.25), ..arrow-style(palette.dark.line))
    content(((x0 + x1) / 2, 0.45), anchor: "south", padding: 0.12, text(
      size: 10pt,
      fill: ink,
      align(center)[dérivation $(d / (d t))$],
    ))
    line((x1, -0.25), (x0, -0.25), ..arrow-style(ink.lighten(30%)))
    content(((x0 + x1) / 2, -0.5), anchor: "north", padding: 0.12, text(
      size: 10pt,
      fill: ink,
      align(center)[intégration $(integral d t)$],
    ))
  }
})
