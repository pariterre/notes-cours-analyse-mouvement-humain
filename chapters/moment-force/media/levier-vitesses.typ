#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Cinématique d'un levier inter-appui : en tournant autour de O, les deux
// extrémités se déplacent en même temps; leurs vitesses sont proportionnelles
// aux bras de levier (V1 / V2 = L1 / L2). Les pointes des deux vitesses sont
// alignées avec O (triangles semblables).

#let (l1, l2) = (3.0, 1.2)
#let v-scale = 0.65 // longueur dessinée de la vitesse par unité de bras

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (v1, v2) = (l1 * v-scale, l2 * v-scale)
  let vec(from, to, shade) = line(from, to, stroke: 3pt + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.3,
  ))

  // Droite passant par O et les pointes des vitesses
  line((-l1, -v1), (l2, v2), stroke: (
    paint: ink.transparentize(40%),
    thickness: 0.8pt,
    dash: "dashed",
  ))

  // Barre
  line((-l1, 0), (0, 0), stroke: (paint: palette.blue.line, thickness: 4pt, cap: "round"))
  line((0, 0), (l2, 0), stroke: (paint: palette.red.line, thickness: 4pt, cap: "round"))
  line((-0.3, -0.55), (0.3, -0.55), (0, -0.06), close: true, fill: palette.gold.fill, stroke: 1.2pt + palette.gold.line)
  circle((0, 0), radius: 0.08, fill: ink, stroke: 1pt + white)
  content((0.12, -0.05), anchor: "north-west", padding: 0.18, text(size: 13pt, weight: "bold", fill: ink)[$O$])

  // Vitesses des extrémités
  vec((-l1, 0), (-l1, -v1), palette.blue)
  content((-l1, -v1), anchor: "north", padding: 0.1, text(size: 14pt, fill: palette.blue.text)[$arrow(V_1)$])
  vec((l2, 0), (l2, v2), palette.red)
  content((l2, v2), anchor: "west", padding: 0.15, text(size: 14pt, fill: palette.red.text)[$arrow(V_2)$])

  // Bras de levier
  let dim-y = 0.55
  for (x0, x1, shade, label) in ((-l1, 0, palette.blue, $L_1$), (0, l2, palette.red, $L_2$)) {
    line((x0, dim-y), (x1, dim-y), stroke: 1pt + shade.line, mark: (
      start: "stealth",
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
      scale: 0.7,
    ))
    for x in (x0, x1) { line((x, dim-y - 0.12), (x, dim-y + 0.12), stroke: 0.8pt + shade.line) }
    content(((x0 + x1) / 2, dim-y), anchor: "south", padding: 0.1, text(size: 14pt, fill: shade.text, label))
  }

  // Relation
  content((-l1 / 2 + 0.6, -v1 + 0.2), anchor: "west", text(size: 14pt)[$
    #text(fill: palette.blue.text)[$V_1$] / #text(fill: palette.red.text)[$V_2$]
    = #text(fill: palette.blue.text)[$L_1$] / #text(fill: palette.red.text)[$L_2$]
  $])
})
