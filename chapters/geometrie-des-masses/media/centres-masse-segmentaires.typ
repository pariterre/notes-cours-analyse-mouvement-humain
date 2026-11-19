#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, segment-data
#import "@preview/cetz:0.4.1"

// Le mannequin est rogné sous la taille, mais pas les flèches. On superpose
// donc deux canevas : le mannequin (rogné) puis les annotations. Un cadre
// invisible commun garantit que les deux canevas ont le même repère.
#let (x-min, x-max, y-top) = (-4.4, 1.4, 8.1)
#let y-cut = 4.6 // hauteur de rognage du mannequin
#let y-bottom = 4.5 // bas de la figure (juste sous la plus longue flèche)

#let frame() = cetz.draw.rect(
  (x-min, 0),
  (x-max, y-top),
  stroke: none,
)
#let model(visible) = mannequin(
  size: 8,
  view: (azimuth: 0deg),
  pose: (shoulder-r: (abduction: 90deg)),
  name: "m",
  visible: visible,
)

#let body = cetz.canvas(length: 1cm, {
  frame()
  model(true)
})

#let annotations = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  frame()
  model(false)

  // Axe longitudinal du membre supérieur et articulations
  line("m.shoulder-r", "m.hand-r", stroke: (
    paint: white,
    thickness: 1pt,
    dash: "dashed",
  ))
  for joint in ("shoulder-r", "elbow-r", "wrist-r", "hand-r") {
    circle("m." + joint, radius: 0.06, fill: white, stroke: none)
  }

  // Poids des segments, appliqués aux centres de masse. La longueur des
  // flèches croît avec la masse relative du segment (de Leva), atténuée par une
  // racine carrée pour que la main reste lisible; la plus longue s'arrête au
  // niveau du rognage.
  let data = segment-data.male
  let weight = (
    upper-arm-r: data.upper-arm.mass,
    forearm-r: data.forearm.mass,
    hand-r: data.hand.mass,
  )
  let shoulder-y = 8 * (0.530 + 0.262)
  let longest = shoulder-y - y-cut
  let red = palette.red.line
  for (segment, mass) in weight {
    let com = "m.com-" + segment
    let length = longest * calc.sqrt(mass / weight.upper-arm-r)
    line(com, (rel: (0, -length)), stroke: 1.4pt + red, mark: (
      end: "stealth",
      fill: red,
      stroke: red,
      scale: 0.9,
    ))
    rect(
      (rel: (-0.07, -0.07), to: com),
      (rel: (0.07, 0.07), to: com),
      fill: red,
      stroke: 0.6pt + white,
    )
  }
})

#box(width: (x-max - x-min) * 1cm, height: (y-top - y-bottom) * 1cm, clip: true, {
  place(top, box(height: (y-top - y-cut) * 1cm, clip: true, body))
  place(top, annotations)
})
