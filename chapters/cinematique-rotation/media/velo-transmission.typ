#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Transmission d'un vélo (vue de droite, le vélo avance vers la droite).
// 1 unité = 0.1 m. Roue arrière R = 0.35 m, pignon r = 0.03 m (sur l'axe de
// la roue), plateau r = 0.1 m entraîné à 90 tr/min.

#let wheel-r = 3.5
#let pignon-r = 0.3
#let plateau-r = 1.0
#let plateau-c = (4.2, -0.6)

// Le vélo entier est dessiné, mais seule la fenêtre `view` est montrée
// (x min, x max, y min, y max, en unités du dessin). Pour montrer plus ou
// moins du vélo, il suffit de changer ces valeurs.
#let view = (-4.2, 7.7, -3.95, 5.0)
// Étendue totale du dessin (doit contenir tout ce qui est dessiné)
#let extent = (-5, 14, -4.4, 5.4)

#let drawing = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let metal = palette.neutral.line
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let arc(c, r, from, to, n: 40) = range(0, n + 1).map(i => add(c, polar(
    r,
    from + (to - from) * i / n,
  )))

  // Engrenage : contour en dents
  let gear(c, r, teeth, shade) = {
    let pts = range(teeth * 4).map(i => {
      let a = 360deg * i / (teeth * 4)
      let rr = if calc.rem(i, 4) < 2 { r + 0.06 } else { r - 0.04 }
      add(c, polar(rr, a))
    })
    line(..pts, close: true, fill: shade.fill, stroke: 1pt + shade.line)
    circle(c, radius: 0.12, fill: white, stroke: 1pt + shade.line)
  }

  // Cadre invisible fixant l'étendue du dessin (pour le recadrage)
  rect((extent.at(0), extent.at(2)), (extent.at(1), extent.at(3)), stroke: none)

  // Sol
  line((-5, -wheel-r), (14, -wheel-r), stroke: 1pt + ink)
  for i in range(80) {
    let x = -4.9 + i * 0.25
    line((x, -wheel-r), (x - 0.25, -wheel-r - 0.25), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Roue (rayons, jante, pneu)
  let wheel(c) = {
    for k in range(18) {
      line(
        add(c, polar(0.35, k * 20deg)),
        add(c, polar(wheel-r - 0.25, k * 20deg + 30deg)),
        stroke: 0.5pt + metal.lighten(30%),
      )
    }
    circle(c, radius: wheel-r - 0.2, stroke: 2pt + metal.lighten(20%))
    circle(c, radius: wheel-r - 0.08, stroke: 6pt + palette.dark.fill)
  }
  let front = (9.8, 0)
  wheel(front)

  // Cadre
  let frame-stroke = (
    paint: metal.lighten(45%),
    thickness: 7pt,
    cap: "round",
    join: "round",
  )
  let seat = (3.3, 3.4) // haut du tube de selle
  let (head-bottom, head-top) = ((8.95, 2.1), (8.6, 3.4)) // douille de direction
  line((0, 0), plateau-c, stroke: frame-stroke) // base
  line((0, 0), seat, stroke: frame-stroke) // hauban
  line(plateau-c, seat, stroke: frame-stroke) // tube de selle
  line(seat, head-top, stroke: frame-stroke) // tube horizontal
  line(plateau-c, head-bottom, stroke: frame-stroke) // tube oblique
  line(head-bottom, head-top, stroke: (..frame-stroke, thickness: 9pt)) // douille
  line(head-bottom, (9.35, 0.9), front, stroke: (
    ..frame-stroke,
    thickness: 5pt,
  )) // fourche
  circle(front, radius: 0.12, fill: white, stroke: 1pt + metal)

  // Selle et tige de selle
  let saddle = (2.95, 4.6)
  line(seat, saddle, stroke: (paint: metal, thickness: 4pt, cap: "round"))
  line((2.2, 4.72), (3.75, 4.68), stroke: (
    paint: palette.dark.fill,
    thickness: 7pt,
    cap: "round",
  ))

  // Potence et cintre
  line(head-top, (8.5, 3.75), (9.4, 3.85), stroke: (
    paint: metal,
    thickness: 4pt,
    cap: "round",
    join: "round",
  ))
  line(
    (9.4, 3.85),
    (10.0, 3.75),
    (10.2, 3.3),
    (10.0, 2.85),
    (9.65, 2.85),
    stroke: (
      paint: palette.dark.fill,
      thickness: 4.5pt,
      cap: "round",
      join: "round",
    ),
  )

  // Roue arrière
  wheel((0, 0))

  // Chaîne : tangentes extérieures entre pignon et plateau, et enroulements
  let (dx, dy) = (plateau-c.at(0), plateau-c.at(1))
  let d = calc.sqrt(dx * dx + dy * dy)
  let beta = calc.atan2(dx, dy)
  let alpha = calc.acos((pignon-r - plateau-r) / d)
  let chain-r-p = pignon-r + 0.02
  let chain-r-c = plateau-r + 0.02
  let chain = (
    ..arc((0, 0), chain-r-p, beta - alpha + 360deg, beta + alpha),
    ..arc(plateau-c, chain-r-c, beta + alpha, beta - alpha),
  )
  line(..chain, close: true, stroke: (
    paint: palette.dark.fill,
    thickness: 3.5pt,
    join: "round",
  ))
  line(..chain, close: true, stroke: (
    paint: white,
    thickness: 1.2pt,
    dash: "densely-dotted",
  ))

  gear((0, 0), pignon-r, 11, palette.green)
  gear(plateau-c, plateau-r, 36, palette.red)

  // Manivelle et pédale
  let pedal = add(plateau-c, polar(1.7, -55deg))
  line(plateau-c, pedal, stroke: (paint: metal, thickness: 5pt, cap: "round"))
  rect(
    add(pedal, (-0.35, -0.08)),
    add(pedal, (0.35, 0.08)),
    fill: palette.dark.fill,
    stroke: none,
    radius: 0.04,
  )

  // Rayons et valeurs
  let radius-line(c, r, a, shade) = line(
    c,
    add(c, polar(r, a)),
    stroke: 1.6pt + shade.line,
    mark: (
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
      scale: 0.8,
    ),
  )
  let label(at, anchor, shade, body) = content(at, anchor: anchor, box(
    fill: white,
    stroke: 1.2pt + shade.line,
    inset: (x: 5pt, y: 4pt),
    radius: 3pt,
    // Bornes réelles du texte : les indices (« pignon ») restent dans la boîte
    text(size: 15pt, fill: shade.text, top-edge: "bounds", bottom-edge: "bounds", body),
  ))
  radius-line((0, 0), wheel-r - 0.1, 120deg, palette.blue)
  label(
    add(add((0, 0), polar(wheel-r * 0.55, 120deg)), (-0.15, 0)),
    "east",
    palette.blue,
  )[$R = #qty[0.35][m]$]

  radius-line((0, 0), pignon-r, 225deg, palette.green)
  line(polar(0.25, 250deg), (-0.4, -1.5), stroke: 0.8pt + palette.green.line)
  label((-0.4, -1.5), "north", palette.green)[$r_"pignon" = #qty[0.03][m]$]

  radius-line(plateau-c, plateau-r, 120deg, palette.red)
  label(
    add(plateau-c, (0.1, -1.6)),
    "north",
    palette.red,
  )[$r_"plateau" = #qty[0.1][m]$]

  // Rotation du plateau (sens horaire : le vélo avance vers la droite)
  let r-rot = 1.55
  let rot = arc(plateau-c, r-rot, 85deg, 10deg)
  line(..rot, stroke: (paint: palette.red.line, thickness: 2.5pt, cap: "round"))
  let tip = add(plateau-c, polar(r-rot, 0deg))
  let back = add(plateau-c, polar(r-rot, 13deg))
  let side = polar(0.2, 13deg)
  line(
    tip,
    add(back, side),
    add(back, side.map(c => -c)),
    close: true,
    fill: palette.red.line,
    stroke: none,
  )
  label(
    add(plateau-c, (0.4, 1.75)),
    "south",
    palette.red,
  )[$omega_"plateau" = 90 "tr/min"$]
})

// Recadrage sur la fenêtre `view`
#{
  let (x0, x1, y0, y1) = view
  box(
    width: (x1 - x0) * 1cm,
    height: (y1 - y0) * 1cm,
    clip: true,
    place(
      top + left,
      dx: (extent.at(0) - x0) * 1cm,
      dy: (y1 - extent.at(3)) * 1cm,
      drawing,
    ),
  )
}
