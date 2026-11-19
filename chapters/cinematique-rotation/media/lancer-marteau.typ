#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Lancer du marteau vu de dessus (1 unité = 1 m). Le marteau tourne dans le
// sens horaire sur un cercle de rayon ≈ 1.9 m autour du lanceur. Lâché en
// un point, il part selon la tangente au cercle (droites pointillées).
// Lâché en 2 (tangente verticale) ou en 3, le marteau atterrit dans l'aire
// de réception (secteur de 34.92°); en 4 ou 5, il finit dans la cage.

#let hammer-r = 1.9
#let releases = (40deg, 0deg, -35deg, -65deg, -105deg, -140deg)
#let frame = (-4.6, 4.6, -7.6, 3.6) // (x min, x max, y min, y max)

// Partie visible d'une demi-droite (point, direction) dans le cadre
#let clip-ray(p, d) = {
  let (x0, x1, y0, y1) = frame
  let t-max = 100
  for (pc, dc, lo, hi) in (
    (p.at(0), d.at(0), x0, x1),
    (p.at(1), d.at(1), y0, y1),
  ) {
    if dc > 0 { t-max = calc.min(t-max, (hi - pc) / dc) }
    if dc < 0 { t-max = calc.min(t-max, (lo - pc) / dc) }
  }
  (p, (p.at(0) + t-max * d.at(0), p.at(1) + t-max * d.at(1)))
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let polar(radius, a) = (radius * calc.cos(a), radius * calc.sin(a))
  let arc(radius, from, to, n: 40) = range(0, n + 1).map(i => polar(
    radius,
    from + (to - from) * i / n,
  ))
  let (x0, x1, y0, y1) = frame

  // Aire de réception vers le bas. Le vrai secteur fait 34.92°; il est
  // élargi ici pour être bien visible (schéma, pas à l'échelle)
  let half = 60deg / 2
  let reach = (y1 - y0) // assez long pour sortir du cadre
  let left = polar(reach, -90deg - half)
  let right = polar(reach, -90deg + half)
  let bottom-left = (left.at(0) * y0 / left.at(1), y0)
  let bottom-right = (right.at(0) * y0 / right.at(1), y0)
  line(
    (0, 0),
    bottom-left,
    bottom-right,
    close: true,
    fill: palette.green.fill,
    stroke: none,
  )
  line(bottom-left, (0, 0), bottom-right, stroke: 1.2pt + palette.green.line)
  content((0, y0 + 1.3), text(
    size: 15pt,
    fill: palette.green.text,
    weight: "semibold",
    align(center)[aire de \ réception],
  ))

  // Cage de protection (ouverte vers l'aire de réception)
  // Ouverture un peu plus large que l'aire de réception : pas de chevauchement
  let cage = arc(3.0, -90deg + 35deg, 270deg - 35deg, n: 60)
  line(..cage, stroke: (paint: ink, thickness: 2.5pt, cap: "round"))
  for p in cage
    .enumerate()
    .filter(((i, _)) => calc.rem(i, 6) == 0)
    .map(((_, p)) => p) { circle(p, radius: 0.07, fill: ink, stroke: none) }
  content(polar(3.0, 135deg), anchor: "south-east", padding: 0.15, text(
    size: 15pt,
    fill: ink,
    weight: "semibold",
  )[cage])

  // Cercle de lancer
  circle((0, 0), radius: 1.07, fill: palette.neutral.fill, stroke: 1.5pt + ink)

  // Trajectoire du marteau et sens de rotation (horaire)
  circle((0, 0), radius: hammer-r, stroke: (
    paint: palette.blue.line,
    thickness: 1.2pt,
    dash: "dashed",
  ))
  let r-rot = 1.45
  line(..arc(r-rot, 155deg, 100deg), stroke: (
    paint: palette.blue.line,
    thickness: 2pt,
    cap: "round",
  ))
  let tip = polar(r-rot, 92deg)
  let back = polar(r-rot, 104deg)
  let side = polar(0.15, 104deg)
  line(
    tip,
    (back.at(0) + side.at(0), back.at(1) + side.at(1)),
    (back.at(0) - side.at(0), back.at(1) - side.at(1)),
    close: true,
    fill: palette.blue.line,
    stroke: none,
  )

  // Directions de lâcher (tangentes) et points numérotés
  for (i, a) in releases.enumerate() {
    let p = polar(hammer-r, a)
    let d = (calc.sin(a), -calc.cos(a)) // sens horaire
    let (from, to) = clip-ray(p, d)
    line(from, to, stroke: (
      paint: palette.red.line,
      thickness: 1pt,
      dash: "dashed",
    ))
  }
  for (i, a) in releases.enumerate() {
    let p = polar(hammer-r, a)
    circle(p, radius: 0.1, fill: palette.red.line, stroke: 1pt + white)
    content(polar(hammer-r - 0.38, a), text(
      size: 12pt,
      weight: "bold",
      fill: palette.red.text,
    )[#(i + 1)])
  }
})
