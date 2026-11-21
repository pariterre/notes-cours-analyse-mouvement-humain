#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Avantage mécanique ou cinématique selon le genre de levier.
// Chaque levier est dessiné par la position (de 0 à 1 le long de la barre)
// du point d'appui A, de la force motrice F et de la résistance R :
//   - bras de force plus court que bras de résistance → avantage cinématique
//   - bras égaux → aucun avantage
//   - bras de force plus long → avantage mécanique

/// Petit schéma de levier.
/// - a, f, r (float): positions de A, F et R le long de la barre (0 à 1).
/// - f-up (bool): la force motrice tire vers le haut (sinon vers le bas).
#let lever(a, f, r, f-up: false) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let len = 2.6
  let x(t) = t * len
  let arrow(t, up, shade, label) = {
    let (from, to) = if up { ((x(t), 0), (x(t), 0.75)) } else {
      ((x(t), 0), (x(t), -0.75))
    }
    line(from, to, stroke: 1.8pt + shade.line, mark: (
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
    ))
    content(
      to,
      anchor: if up { "south" } else { "north" },
      padding: 0.06,
      text(
        size: 10pt,
        weight: "bold",
        fill: shade.text,
        label,
      ),
    )
  }

  line((0, 0), (len, 0), stroke: (paint: ink, thickness: 2pt, cap: "round"))
  // Point d'appui sous la barre
  line(
    (x(a) - 0.17, -0.3),
    (x(a) + 0.17, -0.3),
    (x(a), -0.03),
    close: true,
    fill: palette.gold.fill,
    stroke: 1pt + palette.gold.line,
  )
  content((x(a), -0.3), anchor: "north", padding: 0.04, text(
    size: 10pt,
    weight: "bold",
    fill: palette.gold.text,
  )[A])
  arrow(f, f-up, palette.red, [F])
  arrow(r, false, palette.blue, [R])
})

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  align: horizon,
  [Genre de levier], [Cinématique \ (vitesse)], [Aucun], [Mécanique \ (force)],
  [inter-appui], lever(0.3, 0, 1), lever(0.5, 0, 1), lever(0.75, 0, 1),
  [inter-moteur], lever(0, 0.35, 1, f-up: true), [], [],
  [inter-résistant], [], [], lever(0, 1, 0.45, f-up: true),
)
