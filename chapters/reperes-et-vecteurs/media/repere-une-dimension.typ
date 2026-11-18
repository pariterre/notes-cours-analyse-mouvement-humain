#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Repère à une dimension sur l'axe Montréal (O) – Québec (Q).
// Les voitures sont placées à leur position réelle et la longueur des
// vecteurs-vitesse est proportionnelle à leur vitesse :
//   A : à 175 km de Montréal, roule vers Montréal à 100 km/h
//   B : à Montréal, roule vers Québec à 100 km/h
//   C : à mi-chemin, recule vers Montréal à 10 km/h (elle fait face à Québec)

#let km-per-unit = 20 // échelle des positions
#let kmh-per-unit = 22 // échelle des vitesses
#let distance-mq = 250 // Montréal – Québec (km)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let x-of(km) = km / km-per-unit
  let x-q = x-of(distance-mq)

  // Silhouette de voiture; `facing` vaut 1 (vers Québec) ou -1 (vers Montréal)
  let car(x, y, facing, shade) = {
    let (len, h) = (1.1, 0.32)
    let p(dx, dy) = (x + facing * dx, y + dy)
    // Carrosserie et habitacle
    line(
      p(-len / 2, 0.08),
      p(-len / 2, h),
      p(-0.28, h),
      p(-0.18, h + 0.24),
      p(0.16, h + 0.24),
      p(0.3, h),
      p(len / 2, h - 0.04),
      p(len / 2, 0.08),
      close: true,
      fill: shade.line,
      stroke: (paint: shade.text, thickness: 0.6pt, join: "round"),
    )
    // Vitres
    line(
      p(-0.22, h + 0.02),
      p(-0.14, h + 0.18),
      p(0.13, h + 0.18),
      p(0.23, h + 0.02),
      close: true,
      fill: shade.fill,
      stroke: none,
    )
    // Roues
    for dx in (-0.3, 0.3) {
      circle(
        p(dx, 0.08),
        radius: 0.11,
        fill: palette.dark.fill,
        stroke: 0.8pt + white,
      )
    }
  }

  // Vecteur-vitesse à hauteur de la voiture, partant du pare-chocs situé
  // du côté du déplacement
  let velocity(x, y, kmh, shade, label) = {
    let dir = if kmh > 0 { 1 } else { -1 }
    let start = (x + dir * 0.65, y + 0.28)
    let end = (start.at(0) + kmh / kmh-per-unit, y + 0.28)
    line(
      start,
      end,
      stroke: (paint: shade.line, thickness: 1.8pt),
      // Pointe plus petite pour les vecteurs courts
      mark: (
        end: "stealth",
        fill: shade.line,
        stroke: shade.line,
        scale: if calc.abs(kmh) > 20 { 1.4 } else { 0.8 },
      ),
      name: "v",
    )
    content(
      ("v.start", 50%, "v.end"),
      anchor: "south",
      padding: 0.12,
      text(size: 11pt, fill: shade.text, label),
    )
  }

  // Axe O – Q
  line(
    (0, 0),
    (x-q, 0),
    stroke: (paint: ink, thickness: 0.8pt, dash: "dashed"),
  )
  circle((0, 0), radius: 0.07, fill: ink, stroke: none)
  circle((x-q, 0), radius: 0.07, fill: ink, stroke: none)
  content((0, -0.15), anchor: "north", align(center, text(
    size: 10pt,
    fill: ink,
  )[O \ Montréal]))
  content((x-q, -0.15), anchor: "north", align(center, text(
    size: 10pt,
    fill: ink,
  )[Q \ Québec]))

  // Vecteur unitaire x
  line(
    (0, 0),
    (1, 0),
    stroke: 1.6pt + palette.dark.line,
    mark: (
      end: "stealth",
      fill: palette.dark.line,
      stroke: palette.dark.line,
      scale: 1.2,
    ),
  )
  content((1, -0.12), anchor: "north", text(size: 11pt, $arrow(x)$))

  // Voitures : (position en km, voie, vitesse algébrique, sens du véhicule)
  let cars = (
    (
      km: 175,
      lane: 1.8,
      v: -100,
      facing: -1,
      shade: palette.blue,
      label: $arrow(V_A)$,
    ),
    (
      km: 0,
      lane: 1.25,
      v: 100,
      facing: 1,
      shade: palette.red,
      label: $arrow(V_B)$,
    ),
    (
      km: distance-mq / 2,
      lane: 0.35,
      v: -10,
      facing: 1,
      shade: palette.green,
      label: $arrow(V_C)$,
    ),
  )
  for c in cars {
    let x = x-of(c.km)
    // Repère de position sur l'axe (graduation sauf en O, déjà étiqueté)
    line((x, 0), (x, c.lane), stroke: (
      paint: ink.transparentize(50%),
      thickness: 0.5pt,
      dash: "dotted",
    ))
    if c.km != 0 {
      line((x, -0.08), (x, 0.08), stroke: 0.8pt + ink)
      content((x, -0.15), anchor: "north", text(size: 9pt, fill: ink)[#c.km km])
    }
    car(x, c.lane, c.facing, c.shade)
    velocity(x, c.lane, c.v, c.shade, c.label)
  }
})
