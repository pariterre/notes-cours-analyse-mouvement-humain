#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Travail du poids entre A et B : le poids est vertical et constant, donc
// seul le déplacement vertical compte. Quel que soit le chemin (sinueux ou
// direct), W = m g (h_A - h_B) = E_PP(A) - E_PP(B).

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let path-shade = palette.blue
  let (a, b) = ((0, 5.2), (3.0, 1.8))

  // Sol (référence des hauteurs)
  line((-2.2, 0), (6.4, 0), stroke: 1pt + ink)
  for i in range(29) {
    let x = -2.1 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }
  content((6.4, 0), anchor: "south-east", padding: 0.08, text(size: 10pt, fill: ink, style: "italic")[$h = 0$])

  // Deux chemins de A à B : sinueux et direct
  let wiggly = (a, (1.6, 5.0), (0.4, 3.6), (2.2, 4.2), (3.6, 3.4), (1.6, 2.6), (2.0, 0.9), (3.4, 1.0), b)
  hobby(..wiggly, stroke: (paint: path-shade.line, thickness: 2pt))
  line(a, b, stroke: (paint: path-shade.line.transparentize(30%), thickness: 1.2pt, dash: "dashed"))

  // L'objet (bloc bleu) à plusieurs instants le long du chemin, estompé au
  // départ et plein à l'arrivée; le poids, identique partout, part de son
  // centre de masse et est dessiné par-dessus le bloc
  let stops = (a, (0.4, 3.6), (3.6, 3.4), (2.0, 0.9), b)
  let side = 0.5
  for (i, p) in stops.enumerate() {
    let alpha = 55% * (1 - i / (stops.len() - 1))
    rect(
      (p.at(0) - side / 2, p.at(1) - side / 2),
      (p.at(0) + side / 2, p.at(1) + side / 2),
      radius: 0.04,
      fill: palette.blue.fill.lighten(alpha),
      stroke: 1.2pt + palette.blue.line.lighten(alpha),
    )
    // Poids estompé comme son bloc (éclairci, donc opaque)
    let w-color = palette.neutral.line.lighten(alpha)
    line(p, (p.at(0), p.at(1) - 0.9), stroke: 2pt + w-color, mark: (
      end: "stealth",
      fill: w-color,
      stroke: w-color,
    ))
  }
  content((a.at(0), a.at(1) - 0.9), anchor: "east", padding: 0.1, text(size: 13pt, fill: palette.neutral.text)[$arrow(W)$])

  // Points A et B
  for (p, name, anchor) in ((a, $A$, "south-east"), (b, $B$, "west")) {
    circle(p, radius: 0.07, fill: ink, stroke: 1pt + white)
    content(p, anchor: anchor, padding: 0.35, text(size: 14pt, weight: "bold", fill: ink, name))
  }

  // Hauteurs depuis le sol
  let guide = (paint: ink.transparentize(50%), thickness: 0.6pt, dash: "dotted")
  let dim(x, y0, y1, shade, label, side) = {
    line((x, y0), (x, y1), stroke: 1.2pt + shade.line, mark: (
      start: "stealth",
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
      scale: 0.8,
    ))
    content((x, (y0 + y1) / 2), anchor: side, padding: 0.12, text(size: 13pt, fill: shade.text, label))
  }
  line(a, (-1.4, a.at(1)), stroke: guide)
  dim(-1.2, 0, a.at(1), palette.neutral, $h_A$, "east")
  line(b, (5.2, b.at(1)), stroke: guide)
  line(a, (5.2, a.at(1)), stroke: guide)
  dim(4.6, 0, b.at(1), palette.neutral, $h_B$, "west")
  // Seule la différence de hauteur compte
  dim(5.0, b.at(1), a.at(1), palette.gold, $h_A - h_B$, "west")
  content((5.0, a.at(1) + 0.35), anchor: "south-west", text(size: 12pt, fill: palette.gold.text)[$W_arrow(W) = m g (h_A - h_B)$])
})
