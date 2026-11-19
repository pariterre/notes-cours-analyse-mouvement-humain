#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let size = 4
  let red = palette.red.line
  let bar-color = palette.gold.line

  // Vue de face de la barre : les sauteurs sont vus de profil (azimut -90deg),
  // la projection est donc (x, z).
  let view = (azimuth: -90deg)
  let screen(p) = (p.at(0), p.at(2))

  // Chaque technique : pose, et point du corps qui frôle la barre (`clearance`)
  let techniques = (
    (
      label: [Ciseaux],
      pose: (
        trunk: -5deg,
        hip-r: 90deg,
        hip-l: 15deg,
        knee-l: 50deg,
        shoulder-r: 70deg,
        shoulder-l: 50deg,
        elbow-r: 30deg,
        elbow-l: 30deg,
      ),
      // Sous les fesses
      clearance: p => p.pelvis.at(2) - 0.05 * size,
    ),
    (
      label: [Rouleau ventral],
      pose: (
        global: (pitch: 90deg),
        hip-r: (flexion: 10deg, abduction: 30deg),
        hip-l: (flexion: 70deg),
        knee-l: 90deg,
        shoulder-r: 160deg,
        shoulder-l: 40deg,
        elbow-l: 30deg,
      ),
      // Sous le ventre
      clearance: p => p.com-trunk.at(2) - 0.065 * size,
    ),
    (
      label: [Fosbury flop],
      pose: (
        global: (pitch: -90deg),
        trunk: -25deg,
        head: -10deg,
        hip-r: -25deg,
        hip-l: -25deg,
        knee-r: 85deg,
        knee-l: 85deg,
        shoulder-r: -10deg,
        shoulder-l: -10deg,
      ),
      // Sous le bas du dos
      clearance: p => p.pelvis.at(2) - 0.05 * size,
    ),
  )

  let xs = (0, 5.2, 10.2) // abscisse du centre de masse de chaque sauteur
  let (y-com, y-bar) = (6.6, 1.8) // niveaux de référence des deux rangées
  let (x-left, x-right) = (-3.4, 12.2)

  let com-marker(pos) = {
    circle(pos, radius: 0.1, fill: white, stroke: 1pt + red)
    line((rel: (-0.16, 0), to: pos), (rel: (0.32, 0)), stroke: 1pt + red)
    line((rel: (0, -0.16), to: pos), (rel: (0, 0.32)), stroke: 1pt + red)
  }
  let row-label(y, body) = content(
    (x-left, y),
    anchor: "south-west",
    padding: 0.08,
    text(size: 9pt, body),
  )

  // Rangée du haut : centres de masse à la même hauteur
  line((x-left, y-com), (x-right, y-com), stroke: (
    paint: red,
    thickness: 0.8pt,
    dash: "dashed",
  ))
  row-label(y-com, [Centre de masse])

  // Rangée du bas : barres à la même hauteur
  line((x-left, y-bar), (x-right, y-bar), stroke: 2pt + bar-color)
  row-label(y-bar, [Barre])

  for (i, technique) in techniques.enumerate() {
    let points = mannequin-points(pose: technique.pose, size: size)
    let (cx, cz) = screen(points.com)
    let bar-z = (technique.clearance)(points)

    // Haut : centre de masse sur la ligne; la barre franchissable est dessous
    // (dessinée avant le corps, qui passe devant)
    let top = (xs.at(i) - cx, y-com - cz)
    line(
      (xs.at(i) - 0.9, top.at(1) + bar-z),
      (xs.at(i) + 0.9, top.at(1) + bar-z),
      stroke: 2pt + bar-color,
    )
    mannequin(size: size, origin: top, view: view, pose: technique.pose, name: "t" + str(i))
    com-marker((xs.at(i), y-com))

    // Bas : barre sur la ligne; le centre de masse est plus ou moins au-dessus
    let bottom = (xs.at(i) - cx, y-bar - bar-z)
    mannequin(size: size, origin: bottom, view: view, pose: technique.pose, name: "b" + str(i))
    com-marker((xs.at(i), bottom.at(1) + cz))

    content(
      (xs.at(i), -0.3),
      anchor: "north",
      text(size: 10pt, weight: "semibold", technique.label),
    )
  }
})
