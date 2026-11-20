#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Impulsion d'une force constante F appliquée pendant Δt : aire sous la courbe
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (f, dt) = (3, 2.6) // hauteur de la force et durée (unités du dessin)
  let (x-max, y-max) = (6, 4)
  let force = palette.red
  let time = palette.green

  // Aire sous la courbe = impulsion
  rect((0, 0), (dt, f), fill: palette.gold.fill, stroke: none)
  line((0, f), (dt, f), (dt, 0), stroke: 1.5pt + palette.gold.line)
  content((dt / 2, f / 2), align(center, text(weight: "semibold")[
    Impulsion \ $[#unit[N s]]$
  ]))

  // Axes
  let axis(to, shade) = line((0, 0), to, stroke: 1.5pt + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
  ))
  axis((x-max, 0), time)
  axis((0, y-max), force)
  content((x-max, 0), anchor: "north-east", padding: 0.15, text(
    fill: time.text,
  )[Temps $[#unit[s]]$])
  content((0, y-max), anchor: "south", padding: 0.1, text(
    fill: force.text,
  )[Force $[#unit[N]]$])

  // Valeur de la force et durée d'application
  content((0, f), anchor: "east", padding: 0.15, text(fill: force.text)[$F$])
  line((0, -0.45), (dt, -0.45), stroke: 1pt + time.line, mark: (
    start: "stealth",
    end: "stealth",
    fill: time.line,
    stroke: time.line,
    scale: 0.7,
  ))
  content((dt / 2, -0.45), anchor: "north", padding: 0.1, text(
    fill: time.text,
  )[$Delta t$])
})
