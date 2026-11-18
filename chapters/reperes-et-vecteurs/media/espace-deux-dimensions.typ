#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Espace en deux dimensions vs espace en « deux fois une dimension ».
// Carte rectangulaire dont les rues sont inclinées comme à Montréal. Les
// îlots sont des rectangles de tailles variées, mais chaque rangée et chaque
// colonne garde sa largeur : cela reste un quadrillage.
// Entre A et B, les rues totalisent 5 km selon x et 3 km selon y : tout
// trajet par les rues mesure 8 km, la ligne droite √34 ≈ 5.8 km.

#let theta = -30deg // inclinaison des rues
#let rot((u, v)) = (
  u * calc.cos(theta) - v * calc.sin(theta),
  u * calc.sin(theta) + v * calc.cos(theta),
)

// Position des rues (en km, dans le repère des rues). A est en (0, 0) et
// B en (5, -3); les écarts entre ces rues somment donc à 5 et à 3.
#let u-streets = (-6.4, -5.2, -4.3, -3.1, -2.2, -1.0, 0, 1.3, 2.1, 3.3, 4.0, 5.0, 6.2, 7.0, 8.3, 9.1)
#let v-streets = (-8.4, -7.1, -6.0, -4.9, -3.0, -1.6, -1.0, 0, 1.2, 2.1, 3.0, 4.3, 5.2)

#let a = (0, 0)
#let b = (5, -3)
#let o = (-2.2, -4.9)

// Cadre de la carte (coordonnées de la page)
#let (x-min, x-max, y-min, y-max) = (-5.4, 4.4, -6.3, 1.1)

// Découpe du segment p0–p1 par le cadre (algorithme de Liang–Barsky)
#let clip(p0, p1) = {
  let (x0, y0) = p0
  let (dx, dy) = (p1.at(0) - x0, p1.at(1) - y0)
  let (t0, t1) = (0.0, 1.0)
  for (p, q) in ((-dx, x0 - x-min), (dx, x-max - x0), (-dy, y0 - y-min), (dy, y-max - y0)) {
    if p == 0 {
      if q < 0 { return none }
    } else {
      let r = q / p
      if p < 0 { t0 = calc.max(t0, r) } else { t1 = calc.min(t1, r) }
    }
  }
  if t0 > t1 { return none }
  ((x0 + t0 * dx, y0 + t0 * dy), (x0 + t1 * dx, y0 + t1 * dy))
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let direct = palette.red
  let streets-a = palette.blue
  let streets-b = palette.gold

  // Fond (îlots) et rues découpées par le cadre
  rect((x-min, y-min), (x-max, y-max), fill: palette.neutral.line.transparentize(75%), stroke: none)
  let street = (paint: white, thickness: 3.5pt, cap: "butt")
  let (far-lo, far-hi) = (-20, 20)
  for u in u-streets {
    let seg = clip(rot((u, far-lo)), rot((u, far-hi)))
    if seg != none { line(..seg, stroke: street) }
  }
  for v in v-streets {
    let seg = clip(rot((far-lo, v)), rot((far-hi, v)))
    if seg != none { line(..seg, stroke: street) }
  }
  rect((x-min, y-min), (x-max, y-max), fill: none, stroke: 0.8pt + palette.neutral.line)

  // Repère aligné sur les rues
  let axis(to, label, anchor) = {
    line(
      rot(o),
      rot(to),
      stroke: 2.4pt + palette.dark.line,
      mark: (end: "stealth", fill: palette.dark.line, stroke: palette.dark.line, scale: 1.4),
    )
    content(rot(to), anchor: anchor, padding: 0.12, text(size: 13pt, weight: "bold", label))
  }
  axis((o.at(0) + 1.4, o.at(1)), $x$, "north")
  axis((o.at(0), o.at(1) + 1.4), $y$, "south-east")
  content(rot(o), anchor: "east", padding: 0.15, text(size: 13pt, weight: "bold")[O])

  // Trajet 1 par les rues : selon -y puis selon x (les composantes)
  let corner = (a.at(0), b.at(1))
  let path-stroke(shade, dash) = (paint: shade.line, thickness: 2.4pt, dash: dash, join: "round")
  line(rot(a), rot(corner), rot(b), stroke: path-stroke(streets-a, none))
  content(rot((a.at(0), (a.at(1) + corner.at(1)) / 2)), anchor: "east", padding: 0.2, text(
    size: 11pt,
    fill: streets-a.text,
    weight: "semibold",
  )[3 km])
  content(rot(((corner.at(0) + b.at(0)) / 2, corner.at(1))), anchor: "north", padding: 0.2, text(
    size: 11pt,
    fill: streets-a.text,
    weight: "semibold",
  )[5 km])

  // Trajet 2 par les rues : en escalier (1.3 + 2.0 + 1.7 = 5 km selon x,
  // 1.0 + 0.6 + 1.4 = 3 km selon y)
  let stairs = (a, (1.3, 0), (1.3, -1.0), (3.3, -1.0), (3.3, -1.6), (5, -1.6), b)
  line(..stairs.map(rot), stroke: path-stroke(streets-b, "dotted"))

  // Déplacement en ligne droite
  line(
    rot(a),
    rot(b),
    stroke: path-stroke(direct, "dashed"),
    mark: (end: "stealth", fill: direct.line, stroke: direct.line, scale: 1.6),
  )

  // Points A et B
  for (p, label, anchor) in ((a, [A], "south-east"), (b, [B], "north-west")) {
    circle(rot(p), radius: 0.12, fill: direct.line, stroke: 1.2pt + white)
    content(rot(p), anchor: anchor, padding: 0.18, text(size: 14pt, weight: "bold", fill: direct.text, label))
  }

  // Légende, à droite de la carte
  let legend-x = x-max + 0.5
  let legend-y = y-max - 2.2
  let entries = (
    (direct, "dashed", [En ligne droite (2D) : \ $sqrt(5^2 + 3^2) approx$ 5.8 km]),
    (streets-a, none, [Par les rues (2 × 1D) : \ 3 + 5 = 8 km]),
    (streets-b, "dotted", [Autre trajet par les rues : \ 8 km aussi]),
  )
  for (k, (shade, dash, body)) in entries.enumerate() {
    let y = legend-y - k * 1.3
    line((legend-x, y), (legend-x + 0.9, y), stroke: path-stroke(shade, dash))
    content((legend-x + 1.1, y), anchor: "west", text(size: 11pt, fill: ink, body))
  }
})
