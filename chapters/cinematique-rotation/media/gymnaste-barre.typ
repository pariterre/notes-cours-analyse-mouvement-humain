#import "../../../common/lib.typ": *
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

  // Silhouette simplifiée, les mains sur la barre, orientée selon `a`
  let gymnast(a, color) = {
    let n = a + 90deg
    let at(r, side: 0) = {
      let (x, y) = polar(r * scale, a)
      let (nx, ny) = polar(side * scale, n)
      (x + nx, y + ny)
    }
    let limb(from, to, width) = line(at(from), at(to), stroke: (
      paint: color,
      thickness: width,
      cap: "round",
    ))
    circle(
      at(0.62, side: 0.17),
      radius: 0.17 * scale,
      fill: color,
      stroke: none,
    ) // tête
    limb(0.05, 0.85, 4.5pt) // bras
    limb(0.85, 1.75, 14pt) // tronc
    limb(1.75, 2.85, 9pt) // jambes
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

  gymnast(angle-a, palette.blue.line.lighten(78%)) // position passée : estompée
  gymnast(angle-b, palette.blue.line)

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
