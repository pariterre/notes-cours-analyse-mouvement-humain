#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Outils communs aux kinogrammes de salto avant (avec et sans élan) :
//   - en haut : le salto complet, avec les phases nommées et l'appel encadré;
//   - en bas : le détail de l'appel, centré, relié au cadre du haut par un
//     agrandissement (trapèze). Chaque image du détail a la couleur de son
//     instant dans le salto complet.
// Le mannequin regarde vers la droite; `pitch` > 0 le fait basculer vers
// l'avant (salto avant). Les images anciennes sont estompées.

#let size = 3.0
#let view = (azimuth: -90deg)

// Pose avec les pieds à plat : la cheville compense l'inclinaison du tibia
#let grounded(hip, knee, trunk, lean, shoulder, elbow: 10deg) = (
  global: (pitch: lean),
  hip-r: hip,
  hip-l: hip,
  knee-r: knee,
  knee-l: knee,
  ankle-r: knee - hip + lean,
  ankle-l: knee - hip + lean,
  trunk: trunk,
  shoulder-r: shoulder,
  shoulder-l: shoulder,
  elbow-r: elbow,
  elbow-l: elbow,
)

// Pose en l'air (rotation `pitch` du corps entier)
#let airborne(pitch, hip, knee, shoulder, elbow) = (
  global: (pitch: pitch),
  hip-r: hip,
  hip-l: hip,
  knee-r: knee,
  knee-l: knee,
  shoulder-r: shoulder,
  shoulder-l: shoulder,
  elbow-r: elbow,
  elbow-l: elbow,
)

// Foulée de course (jambes et bras opposés)
#let running(front) = {
  let (a, b) = if front == "r" { ("r", "l") } else { ("l", "r") }
  (
    global: (pitch: 10deg),
    trunk: 5deg,
    ("hip-" + a): 55deg,
    ("knee-" + a): 75deg,
    ("hip-" + b): -15deg,
    ("knee-" + b): 25deg,
    ("ankle-" + b): -10deg,
    ("shoulder-" + a): -35deg,
    ("shoulder-" + b): 45deg,
    ("elbow-" + a): 70deg,
    ("elbow-" + b): 80deg,
  )
}

// Placement : au sol (pieds en x) ou en l'air (centre de masse en (x, y))
#let place-feet(x) = (kind: "feet", x: x)
#let place-com(x, y) = (kind: "com", x: x, y: y)

// Point le plus bas des pieds (pour poser le mannequin sur le sol)
#let _lowest(p) = calc.min(..("heel-r", "heel-l", "toe-r", "toe-l").map(k => p.at(k).at(2)))

/// Centre de masse (x, hauteur) d'une pose posée au sol en `x`.
#let com-on-ground(pose, x) = {
  let p = mannequin-points(pose: pose, size: size)
  (x + p.com.at(0), p.com.at(2) - _lowest(p))
}

/// Images de la phase aérienne : le centre de masse suit une parabole entre
/// `start` (décollage) et `end` (réception), à intervalles de temps égaux;
/// `apex` : hauteur ajoutée au milieu du vol. `adjust` : petits décalages
/// verticaux, image par image (le schéma n'a pas à être exact).
#let flight(poses, start, end, apex, adjust: ()) = {
  let n = poses.len()
  poses.enumerate().map(((k, pose)) => {
    let t = (k + 1) / (n + 1)
    let x = start.at(0) + (end.at(0) - start.at(0)) * t
    let y = start.at(1) + (end.at(1) - start.at(1)) * t + 4 * apex * t * (1 - t) + adjust.at(k, default: 0)
    (pose, place-com(x, y))
  })
}

/// Paramètres de `grounded` interpolés : `from` (u = 0) à `to` (u = 1).
#let grounded-between(from, to, u) = grounded(..from.zip(to).map(((a, b)) => a + (b - a) * u))

#let _row(frames, y0, id, color-of) = {
  import cetz.draw: *
  let (x-min, x-max) = (frames.first().at(1).x - 1.0, frames.last().at(1).x + 1.2)
  line((x-min, y0), (x-max, y0), stroke: 1pt + palette.neutral.line)
  for (i, (pose, place)) in frames.enumerate() {
    let p = mannequin-points(pose: pose, size: size)
    // Au sol : le point le plus bas des pieds touche le sol (avec
    // l'inclinaison du corps, les pieds ne restent pas d'eux-mêmes au sol)
    let origin = if place.kind == "feet" { (place.x, y0 - _lowest(p)) } else {
      (place.x - p.com.at(0), y0 + place.y - p.com.at(2))
    }
    mannequin(size: size, origin: origin, view: view, pose: pose, color: color-of(i), name: id + "-" + str(i))
  }
}

/// Kinogramme complet.
/// - salto (array): images (pose, placement) du salto complet.
/// - appel (array): indices (première, dernière) des images de l'appel.
/// - detail (array): poses du détail de l'appel (pieds au sol).
/// - phases (array): (première image, dernière image, nom) des autres phases,
///   indiquées sous le sol.
/// - detail-spacing (float): écart entre les images du détail.
#let salto-kinogram(salto, appel: (2, 3), detail: (), phases: (), detail-spacing: 1.35) = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let n = salto.len()
  // Couleur liée au temps : `t` de 0 (première image) à n - 1 (dernière)
  let time-color(t) = rgb("#5c6bc0").lighten(55% * (1 - t / (n - 1)))

  // Salto complet
  _row(salto, 0, "salto", time-color)
  let (first, last) = appel
  let (ax0, ax1, ay) = (salto.at(first).at(1).x - 0.7, salto.at(last).at(1).x + 0.7, 3.6)
  let zoom = (paint: palette.gold.line, thickness: 1.2pt, dash: "dashed")
  rect((ax0, -0.15), (ax1, ay), radius: 0.15, stroke: zoom)
  content(((ax0 + ax1) / 2, ay), anchor: "south", padding: 0.08, text(
    size: 11pt,
    fill: palette.gold.text,
    weight: "semibold",
  )[appel])

  // Autres phases, sous le sol
  // Limites : à mi-chemin entre deux images voisines (petit écart), pour que
  // deux phases consécutives ne se chevauchent jamais
  let x-of(i) = salto.at(i).at(1).x
  for (i0, i1, body) in phases {
    let x0 = if i0 > 0 { (x-of(i0 - 1) + x-of(i0)) / 2 + 0.06 } else { x-of(i0) - 0.75 }
    let x1 = if i1 < n - 1 { (x-of(i1) + x-of(i1 + 1)) / 2 - 0.06 } else { x-of(i1) + 0.75 }
    let y = -0.35
    line((x0, y + 0.12), (x0, y), (x1, y), (x1, y + 0.12), stroke: 0.8pt + ink)
    content(((x0 + x1) / 2, y), anchor: "north", padding: 0.08, text(size: 11pt, fill: ink, weight: "semibold", body))
  }

  // Détail de l'appel, centré sous le salto complet
  let m = detail.len()
  let spacing = detail-spacing
  let (top-x0, top-x1) = (salto.first().at(1).x - 1.0, salto.last().at(1).x + 1.2)
  let width = (m - 1) * spacing + 2.2
  let shift = (top-x0 + top-x1) / 2 - width / 2 + 1.0
  let frames = detail.enumerate().map(((i, pose)) => (pose, place-feet(shift + i * spacing)))
  let y1 = -5.8
  _row(frames, y1, "detail", i => time-color(first + (last - first) * i / (m - 1)))
  let (bx0, bx1, by) = (shift - 1.0, shift + (m - 1) * spacing + 1.2, y1 + 3.75)
  rect((bx0, y1 - 0.15), (bx1, by), radius: 0.15, stroke: zoom)
  content((bx0, by), anchor: "south-west", padding: 0.08, text(
    size: 11pt,
    fill: palette.gold.text,
    weight: "semibold",
  )[détail de l'appel])
  // Agrandissement : les coins du cadre de l'appel reliés à ceux du détail
  line((ax0, -0.15), (bx0, by), stroke: (..zoom, thickness: 0.8pt))
  line((ax1, -0.15), (bx1, by), stroke: (..zoom, thickness: 0.8pt))
})
