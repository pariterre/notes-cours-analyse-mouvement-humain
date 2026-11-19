#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Gymnaste en barre fixe : il tourne autour de la barre (axe O_z, sortant
// de la page) de la position A (à l'appui renversé, vers le haut) à la
// position B, soit +120° dans le sens direct (de x vers y).

#let (angle-a, angle-b) = (90deg, 210deg)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let scale = 1.45
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))

  // Gymnaste (mannequin vu de profil), bras tendus au-dessus de la tête, les
  // mains sur la barre; le corps s'étend de la barre dans la direction `a`.
  // Bras levés, le corps pointe vers le bas (-90deg) : on le fait donc tourner
  // de `a + 90deg` dans le plan de la page.
  let gymnast(a, color, name) = {
    let pose = (
      shoulder-r: 180deg,
      shoulder-l: 180deg,
      global: (pitch: -(a + 90deg)),
    )
    let size = 3.4
    let p = mannequin-points(pose: pose, size: size)
    // Prise : milieu des deux mains, placé sur la barre
    let mid(a, b) = a.zip(b).map(((u, v)) => (u + v) / 2)
    let grip = mid(
      mid(p.wrist-r, p.hand-r),
      mid(p.wrist-l, p.hand-l),
    )
    mannequin(
      size: size,
      origin: (-grip.at(0), -grip.at(2)),
      view: (azimuth: -90deg),
      pose: pose,
      color: color,
      name: name,
    )
  }

  // Angle balayé
  let r-arc = 1.75 * scale
  let arc(r, from, to) = range(0, 41).map(i => polar(
    r,
    from + (to - from) * i / 40,
  ))
  line(
    (0, 0),
    ..arc(r-arc, angle-a, angle-b),
    close: true,
    fill: palette.gold.fill,
    stroke: none,
  )

  gymnast(angle-a, rgb("#5c6bc0").lighten(65%), "a") // position passée : estompée
  gymnast(angle-b, rgb("#5c6bc0"), "b")

  // Flèche de rotation (pointe dessinée à la main : courbe)
  let r-arrow = 1.3 * scale
  let end = angle-b - 8deg
  line(..arc(r-arrow, angle-a + 8deg, end - 6deg), stroke: (
    paint: palette.gold.line,
    thickness: 3pt,
    cap: "round",
  ))
  let tip = polar(r-arrow, end)
  let back = polar(r-arrow, end - 9deg)
  let side = polar(0.22, end - 9deg)
  line(
    tip,
    (back.at(0) + side.at(0), back.at(1) + side.at(1)),
    (back.at(0) - side.at(0), back.at(1) - side.at(1)),
    close: true,
    fill: palette.gold.line,
    stroke: none,
  )
  // À l'extérieur de la flèche, loin de la tête du gymnaste en A
  content(polar(r-arrow - 1.2, 130deg), anchor: "east", text(
    size: 13pt,
    weight: "semibold",
    fill: palette.gold.text,
  )[$+120 degree$])

  // Barre (vue en coupe)
  circle((0, 0), radius: 0.16, fill: palette.dark.fill, stroke: 1.5pt + white)

  // Étiquettes A et B
  content(polar(3.15 * scale, angle-a), anchor: "south", text(
    size: 13pt,
    weight: "bold",
    fill: palette.blue.line.lighten(60%),
  )[A])
  content(polar(3.15 * scale, angle-b), anchor: "north-east", text(
    size: 13pt,
    weight: "bold",
    fill: palette.blue.text,
  )[B])

  // Repère : x, y et z sortant de la page
  let origin = (-3.6, 2.2)
  let axis(dir, shade, label, anchor) = {
    let to = (origin.at(0) + dir.at(0), origin.at(1) + dir.at(1))
    line(origin, to, stroke: 1.5pt + shade.line, mark: (
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
    ))
    content(to, anchor: anchor, padding: 0.12, text(
      size: 12pt,
      fill: shade.text,
      label,
    ))
  }
  axis((1.3, 0), palette.red, $x$, "west")
  axis((0, 1.3), palette.green, $y$, "south")
  circle(origin, radius: 0.13, stroke: 1pt + ink, fill: white)
  circle(origin, radius: 0.04, fill: ink, stroke: none)
  content(origin, anchor: "north-east", padding: 0.12, text(
    size: 12pt,
    fill: ink,
    $z$,
  ))
})
