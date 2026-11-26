#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Coup franc vu de dessus (unités : m). Le ballon, frappé avec de l'effet
// (rotation antihoraire vue de dessus), part presque droit (étape
// turbulente : couche limite turbulente, effet Magnus faible), puis, en
// ralentissant, sa trajectoire s'incurve vers la gauche (étape laminaire :
// effet Magnus plus marqué) et contourne le mur pour entrer dans le but.
// Sans rotation, il continuerait tout droit (en pointillé) et manquerait le but.
// Trajectoire en bleu (déplacement), force de Magnus en gris (comme la portance).
// Joueurs et ballon agrandis pour la lisibilité.

#let goal-y = 22.0 // ligne de but
#let goal-half = 3.66 // demi-largeur du but
#let wall-y = 9.15 // distance réglementaire du mur
#let start = (6.0, 0.0)
#let aim = 3.0 / goal-y // pente initiale (dx/dy)
#let curve = 6.0 // déviation totale due à l'effet Magnus (m)
#let laminar-y = 14.0 // début de l'étape laminaire (le ballon a ralenti)
// Trajectoire : rectiligne pendant l'étape turbulente, puis déviation
// (quadratique, sans cassure) pendant l'étape laminaire
#let bend(y) = curve * calc.pow(calc.max(y - laminar-y, 0) / (goal-y - laminar-y), 2)
#let path-x(y) = start.at(0) + aim * y - bend(y)
#let path-slope(y) = aim - 2 * curve * calc.max(y - laminar-y, 0) / calc.pow(goal-y - laminar-y, 2)

#cetz.canvas(length: 0.3cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let flow = palette.blue
  let player-fill = palette.neutral.fill.darken(10%)

  // Joueur vu de dessus : épaules (ellipse) et tête, tourné vers `facing`
  let player(at, facing: 90deg) = {
    let (x, y) = at
    let shoulders = range(0, 41).map(i => {
      let a = 360deg * i / 40
      let (u, v) = (0.65 * calc.cos(a), 0.32 * calc.sin(a))
      (x + u * calc.cos(facing - 90deg) - v * calc.sin(facing - 90deg), y + u * calc.sin(facing - 90deg) + v * calc.cos(facing - 90deg))
    })
    line(..shoulders, close: true, fill: player-fill, stroke: 0.8pt + palette.neutral.line)
    circle(at, radius: 0.3, fill: palette.neutral.fill.darken(30%), stroke: 0.8pt + palette.neutral.line)
  }
  let ball(at) = {
    circle(at, radius: 0.55, fill: white, stroke: 1pt + ink)
    circle(at, radius: 0.2, fill: ink, stroke: none)
  }

  // Ligne de but et but (filet hachuré derrière la ligne)
  line((-5.5, goal-y), (12.5, goal-y), stroke: 1pt + ink)
  rect((-goal-half, goal-y), (goal-half, goal-y + 1.6), fill: tiling(size: (4pt, 4pt), {
    place(std.line(start: (0pt, 0pt), end: (4pt, 4pt), stroke: 0.4pt + ink.transparentize(50%)))
    place(std.line(start: (0pt, 4pt), end: (4pt, 0pt), stroke: 0.4pt + ink.transparentize(50%)))
  }), stroke: 1.5pt + ink)
  content((0, goal-y + 0.8), box(fill: white, inset: 2pt, text(size: 10pt, fill: ink)[but]))

  // Gardien et mur (le mur bloque la ligne directe vers le poteau)
  player((-0.8, goal-y - 1.0), facing: -90deg)
  for x in (3.5, 4.85, 6.2) { player((x, wall-y), facing: -90deg) }
  content((2.6, wall-y), anchor: "east", text(size: 10pt, fill: ink)[mur])

  // Sans rotation : tout droit, à côté du but
  let end-straight = (start.at(0) + aim * goal-y, goal-y)
  line(start, end-straight, stroke: (paint: ink.transparentize(30%), thickness: 1.2pt, dash: "dashed"), mark: (end: "stealth", fill: ink.transparentize(30%), stroke: ink.transparentize(30%)))
  content(end-straight, anchor: "south", padding: 0.3, text(size: 10pt, fill: ink, style: "italic")[sans rotation])

  // Avec rotation : trajectoire courbe (effet Magnus)
  let pts = range(0, 61).map(i => {
    let y = goal-y * i / 60
    (path-x(y), y)
  })
  line(..pts, stroke: 2pt + flow.line, mark: (end: "stealth", fill: flow.line, stroke: flow.line))

  // Étapes
  content((path-x(7) + 0.9, 7), anchor: "west", text(size: 11pt, fill: flow.text)[étape turbulente])
  content((start.at(0) + aim * 18 + 0.8, 18), anchor: "west", text(size: 11pt, fill: flow.text)[étape laminaire])

  // Force de Magnus, perpendiculaire à la trajectoire, vers l'intérieur de la courbe
  let y-f = 18.5
  let p = (path-x(y-f), y-f)
  let slope = path-slope(y-f)
  let n = calc.norm(1, slope)
  let normal = (-1 / n, slope / n)
  let tip = (p.at(0) + 2.4 * normal.at(0), p.at(1) + 2.4 * normal.at(1))
  line(p, tip, stroke: 2pt + palette.neutral.line, mark: (end: "stealth", fill: palette.neutral.line, stroke: palette.neutral.line))
  content(tip, anchor: "east", padding: 0.2, text(size: 10pt, fill: palette.neutral.text)[force \ de Magnus])

  // Tireur et ballon, avec sa rotation (antihoraire vue de dessus)
  // Tireur dans l'axe de la frappe, derrière le ballon
  let kick-dir = calc.atan2(aim, 1)
  player((start.at(0) - 2.3 * calc.cos(kick-dir), start.at(1) - 2.3 * calc.sin(kick-dir)), facing: kick-dir)
  ball(start)
  let spin = range(0, 21).map(i => {
    let a = -40deg + 250deg * i / 20
    (start.at(0) + 1.1 * calc.cos(a), start.at(1) + 1.1 * calc.sin(a))
  })
  line(..spin, stroke: 1.2pt + palette.red.line, mark: (end: "stealth", fill: palette.red.line, stroke: palette.red.line, scale: 0.7))
  content((start.at(0) - 1.6, start.at(1)), anchor: "east", text(size: 10pt, fill: palette.red.text)[rotation])
})
