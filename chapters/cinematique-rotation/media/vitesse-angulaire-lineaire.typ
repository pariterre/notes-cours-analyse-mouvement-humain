#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Relation entre vitesse angulaire et vitesse linéaire : en tournant de Δθ
// (sens direct, vitesse angulaire ω), le point passe de A à B en décrivant
// l'arc r Δθ; sa vitesse v est tangente au cercle (perpendiculaire au rayon).

#let (theta-a, theta-b) = (-25deg, 42deg)
// La vitesse calculée entre A et B (comme entre k - 1 et k + 1) est celle
// du point milieu M de l'arc (l'instant k)
#let theta-m = (theta-a + theta-b) / 2

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let r = 2.6
  let polar(radius, a) = (radius * calc.cos(a), radius * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let arc(radius, from, to, n: 40) = range(0, n + 1).map(i => polar(
    radius,
    from + (to - from) * i / n,
  ))
  // Pointe de flèche le long d'un arc (dessinée à la main)
  let arc-head(radius, a, shade) = {
    let tip = polar(radius, a)
    let back = polar(radius, a - 10deg)
    let side = polar(0.17, a - 10deg)
    line(
      tip,
      add(back, side),
      add(back, side.map(c => -c)),
      close: true,
      fill: shade,
      stroke: none,
    )
  }

  // Cercle
  circle((0, 0), radius: r, stroke: 1.2pt + ink.transparentize(30%))

  // Angle Δθ
  line(
    (0, 0),
    ..arc(1.0, theta-a, theta-b),
    close: true,
    fill: palette.gold.fill,
    stroke: none,
  )
  line(..arc(1.0, theta-a, theta-b), stroke: 0.8pt + palette.gold.line)
  content(polar(1.4, theta-a + 17deg), text(
    size: 13pt,
    fill: palette.gold.text,
  )[$Delta theta$])

  // Rayons
  let a = polar(r, theta-a)
  let b = polar(r, theta-b)
  line((0, 0), a, stroke: 2pt + palette.red.line)
  line((0, 0), b, stroke: 2pt + palette.green.line)
  content(polar(r * 0.62, theta-a), anchor: "north", padding: 0.12, text(
    size: 13pt,
    fill: palette.red.text,
  )[$r$])
  content(polar(r * 0.62, theta-b), anchor: "south-east", padding: 0.08, text(
    size: 13pt,
    fill: palette.green.text,
  )[$r$])

  // Arc parcouru
  line(..arc(r, theta-a, theta-b), stroke: (
    paint: palette.dark.line,
    thickness: 3.2pt,
    cap: "round",
  ))
  content(polar(r, theta-a + 12deg), anchor: "west", padding: 0.2, text(
    size: 13pt,
  )[$arrow(v) = r Delta theta$])

  // Tangente et vitesse au milieu M de l'arc
  let m = polar(r, theta-m)
  line((0, 0), m, stroke: (
    paint: ink.transparentize(50%),
    thickness: 0.7pt,
    dash: "dashed",
  ))
  let tangent = polar(1, theta-m + 90deg)
  line(
    add(m, tangent.map(c => -0.6 * c)),
    add(m, tangent.map(c => 2.4 * c)),
    stroke: (
      paint: ink.transparentize(40%),
      thickness: 0.7pt,
      dash: "dashed",
    ),
  )
  let v-tip = add(m, tangent.map(c => 2.0 * c))
  line(m, v-tip, stroke: 2.6pt + palette.blue.line, mark: (
    end: "stealth",
    fill: palette.blue.line,
    stroke: palette.blue.line,
    scale: 1.3,
  ))
  content(v-tip, anchor: "west", padding: 0.08, text(
    size: 13pt,
    fill: palette.blue.text,
  )[$arrow(v)$])

  // Angle droit entre le rayon et la vitesse
  let q = 0.25
  let u = polar(1, theta-m)
  let p1 = add(m, u.map(c => -q * c))
  let p3 = add(m, tangent.map(c => q * c))
  line(p1, add(p1, tangent.map(c => q * c)), p3, stroke: 0.8pt + ink)

  // Points
  circle((0, 0), radius: 0.07, fill: ink, stroke: none)
  content((0, 0), anchor: "east", padding: 0.12, text(
    size: 13pt,
    fill: ink,
  )[$O$])
  // B est décalé un peu plus haut pour dégager le cercle
  for (p, name, shade, anchor, pad) in (
    (a, $A$, palette.red, "north-west", 0.15),
    (b, $B$, palette.green, "south", 0.3),
  ) {
    circle(p, radius: 0.09, fill: shade.line, stroke: 1pt + white)
    content(p, anchor: anchor, padding: pad, text(
      size: 13pt,
      weight: "bold",
      fill: shade.text,
      name,
    ))
  }
  circle(m, radius: 0.07, fill: palette.blue.line, stroke: 1pt + white)
  content(m, anchor: "west", padding: 0.15, text(
    size: 13pt,
    weight: "bold",
    fill: palette.blue.text,
  )[$M$])

  // Sens de rotation
  let r-omega = r + 0.35
  // Plus bas que A pour laisser la place à son étiquette
  line(..arc(r-omega, -112deg, -74deg), stroke: (
    paint: ink,
    thickness: 1.8pt,
    cap: "round",
  ))
  arc-head(r-omega, -68deg, ink)
  content(polar(r-omega, -93deg), anchor: "north", padding: 0.1, text(
    size: 13pt,
    fill: ink,
  )[$omega$])
})
