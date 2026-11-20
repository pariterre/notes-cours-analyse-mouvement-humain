#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Athlète accroupi au début d'un saut vertical, vu de profil, et forces qui
// s'exercent sur lui. Valeurs du premier athlète de l'exemple :
// R = 1336 N, W = m g = 686 N, donc R + W = 650 N (vers le haut).
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let size = 6
  let newtons = 0.0024 // longueur d'une flèche par newton
  let (reaction, weight) = (1336, 686)

  // Légèrement fléchi : cuisses et tronc penchés vers l'avant, tibias inclinés
  // vers l'avant (genoux devant les chevilles), pieds à plat, bras en arrière.
  // L'angle de cheville compense l'inclinaison du tibia (hanche - genou).
  let pose = (
    hip-r: 50deg,
    hip-l: 50deg,
    knee-r: 70deg,
    knee-l: 70deg,
    ankle-r: 20deg, // ramène le pied à plat malgré l'inclinaison du tibia
    ankle-l: 20deg,
    trunk: 25deg,
    head: -10deg,
    shoulder-r: -25deg,
    shoulder-l: -25deg,
    elbow-r: 15deg,
    elbow-l: 15deg,
  )
  // Vue de profil : la projection est (x, z). On pose les pieds sur le sol.
  let p = mannequin-points(pose: pose, size: size)
  let ground = calc.min(p.heel-r.at(2), p.toe-r.at(2))
  let origin = (0, -ground)
  let screen(q) = (q.at(0) + origin.at(0), q.at(2) + origin.at(1))

  // Sol
  rect((-2.2, -0.35), (2.6, 0), fill: palette.neutral.fill, stroke: none)
  line((-2.2, 0), (2.6, 0), stroke: 1.2pt + palette.neutral.line)

  mannequin(
    size: size,
    origin: origin,
    view: (azimuth: -90deg),
    pose: pose,
    name: "m",
  )

  // Forces
  // (pas `arrow` : masquerait arrow() en mode math)
  let force-arrow(from, length, shade, dash: none) = line(
    from,
    (from.at(0), from.at(1) + length),
    stroke: (paint: shade, thickness: 2.2pt, dash: dash),
    mark: (end: "stealth", fill: shade, stroke: shade, scale: 1.1),
  )
  let red = palette.red.line
  let gold = palette.gold.line
  let sum-color = rgb("#e65100")

  let mid = p.heel-r.zip(p.toe-r).map(((a, b)) => (a + b) / 2)
  let com = screen(p.com)
  // Les trois flèches sont côte à côte : la réaction part de l'avant du pied
  // (sous la plante), le poids et la somme partent du centre de masse
  let gap = 0.32
  let contact = (com.at(0) + gap, 0)

  // Réaction du sol, appliquée au contact des pieds
  force-arrow(contact, reaction * newtons, red)
  content(
    (contact.at(0), reaction * newtons),
    anchor: "south-west",
    padding: 0.06,
    text(
      fill: palette.red.text,
    )[$arrow(R)$],
  )

  // Poids, appliqué au centre de masse
  force-arrow(com, -weight * newtons, gold)
  content(
    (com.at(0), com.at(1) - 0.8 * weight * newtons),
    anchor: "east",
    padding: 0.1,
    text(
      fill: palette.gold.text,
    )[$arrow(W)$],
  )

  // Somme des forces, au centre de masse
  let x-sum = com.at(0) - gap
  force-arrow(
    (x-sum, com.at(1)),
    (reaction - weight) * newtons,
    sum-color,
    dash: "dashed",
  )
  content(
    (x-sum, com.at(1) + (reaction - weight) * newtons),
    anchor: "south-east",
    padding: 0.06,
    text(
      fill: sum-color.darken(20%),
    )[$arrow(R) + arrow(W)$],
  )

  circle(com, radius: 0.09, fill: white, stroke: 1.2pt + black)

  // Repère
  let o = (-2, 0.6)
  let axis(dir, label, anchor) = {
    let to = (o.at(0) + dir.at(0), o.at(1) + dir.at(1))
    line(o, to, stroke: 1pt + black, mark: (end: "stealth", fill: black))
    content(to, anchor: anchor, padding: 0.08, label)
  }
  axis((0.8, 0), $x$, "west")
  axis((0, 0.8), $y$, "south")
})
