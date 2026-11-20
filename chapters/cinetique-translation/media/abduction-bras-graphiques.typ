#import "../../../common/lib.typ": *
#import "abduction-bras-donnees.typ": abduction-dt, abduction-mass, abduction-positions
#import "@preview/cetz:0.4.1"


// Cinématique du centre de masse des membres supérieurs pendant l'abduction
// des bras, et quantité d'accélération. Les positions sont celles du tableau
// de l'exercice (données partagées : abduction-bras-donnees.typ) ; la vitesse
// et l'accélération sont calculées par différence finie centrée (image avant
// et image après), comme décrit dans le texte.

#let dt = abduction-dt
#let positions = abduction-positions.map(float)
#let mass = abduction-mass

// Différence finie centrée ; `none` aux extrémités (pas d'image avant/après)
#let _derive(values) = values.enumerate().map(((k, _)) => {
  if k == 0 or k == values.len() - 1 or values.at(k - 1) == none or values.at(k + 1) == none {
    none
  } else {
    (values.at(k + 1) - values.at(k - 1)) / (2 * dt)
  }
})
#let velocities = _derive(positions)
#let accelerations = _derive(velocities)
#let forces = accelerations.map(a => if a == none { none } else { mass * a })

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (w, h) = (5.2, 3.2) // taille d'un graphique

  // Graphique : `values` en fonction du temps, axe vertical de y0 à y1 par pas
  let graph(origin, values, (y0, y1, step), shade, title, unit-label) = {
    let (ox, oy) = origin
    let at(t, v) = (ox + t * w, oy + (v - y0) / (y1 - y0) * h)

    // Grille légère, axes et graduations
    let n-y = int(calc.round((y1 - y0) / step))
    for i in range(n-y + 1) {
      let v = y0 + i * step
      line(at(0, v), at(1, v), stroke: 0.4pt + palette.neutral.fill.darken(15%))
      content(at(0, v), anchor: "east", padding: 0.08, text(size: 7pt)[#calc.round(v, digits: 2)])
    }
    for i in range(6) {
      let t = i * 0.2
      line(at(t, y0), (at(t, y0).at(0), at(t, y0).at(1) - 0.08), stroke: 0.6pt + black)
      content(at(t, y0), anchor: "north", padding: 0.12, text(size: 7pt)[#calc.round(t, digits: 1)])
    }
    let zero = if y0 < 0 and y1 > 0 { 0 } else { y0 }
    line(at(0, zero), at(1, zero), stroke: 0.8pt + black)
    line(at(0, y0), at(0, y1), stroke: 0.8pt + black)

    // Courbe et points calculés
    let points = values.enumerate().filter(((k, v)) => v != none).map(((k, v)) => at(k * dt, v))
    line(..points, stroke: 1.4pt + shade.line)
    for p in points { circle(p, radius: 0.045, fill: shade.line, stroke: none) }

    // Titre et unités
    content((ox + w / 2, oy + h + 0.15), anchor: "south", text(size: 9pt, weight: "semibold", fill: shade.text, title))
    content((ox - 0.95, oy + h / 2), angle: 90deg, text(size: 8pt, unit-label))
    content((ox + w / 2, oy - 0.45), anchor: "north", text(size: 8pt)[Temps $[#unit[s]]$])
  }

  let (gx, gy) = (w + 1.8, -(h + 1.8))
  graph((0, 0), positions, (0, 0.6, 0.1), palette.blue, [Position], $[#unit[m]]$)
  graph((gx, 0), velocities, (0, 1.8, 0.3), palette.green, [Vitesse], $[#unit[m / s]]$)
  graph((0, gy), accelerations, (-8, 8, 4), palette.red, [Accélération], $[#unit[m / s^2]]$)
  graph((gx, gy), forces, (-50, 50, 25), palette.gold, [Quantité d'accélération $m_"MS" a$], $[#unit[kg m / s^2]]$)
})
