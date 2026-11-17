#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Expérience de la seconde loi de Newton : une règle pousse en même temps
// trois billes de masses différentes avec la même force.
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (ruler-x, ruler-w) = (2.6, 0.22)
  let (ruler-bottom, ruler-top) = (0, 6.6)

  // Force appliquée par la main au milieu de la règle, qui la transmet
  // en même temps aux trois billes
  let force = palette.dark.line
  let y = (ruler-bottom + ruler-top) / 2
  line(
    (0, y),
    (ruler-x - 0.12, y),
    stroke: (paint: force, thickness: 3pt),
    mark: (end: "stealth", fill: force, stroke: force, scale: 2.6),
    name: "f",
  )
  content(
    ("f.start", 40%, "f.end"),
    anchor: "south",
    padding: 0.15,
    text(size: 12pt, fill: ink, $arrow(F)$),
  )

  // Règle (ombre légère puis règle)
  let wood = palette.gold
  rect(
    (ruler-x + 0.06, ruler-bottom - 0.06),
    (ruler-x + ruler-w + 0.06, ruler-top - 0.06),
    radius: 0.05,
    fill: palette.shadow,
    stroke: none,
  )
  rect(
    (ruler-x, ruler-bottom),
    (ruler-x + ruler-w, ruler-top),
    radius: 0.05,
    fill: wood.line,
    stroke: 0.8pt + wood.text,
  )

  // Billes : même matière, rayons différents donc masses différentes.
  // Dégradé radial pour donner du volume.
  let marble(y, radius, shade, label) = {
    let c = (ruler-x + ruler-w + radius + 0.02, y)
    circle(
      (c.at(0) + 0.06, c.at(1) - 0.06),
      radius: radius,
      fill: palette.shadow,
      stroke: none,
    )
    circle(
      c,
      radius: radius,
      fill: gradient.radial(
        shade.fill,
        shade.line,
        shade.text,
        center: (35%, 35%),
        radius: 75%,
      ),
      stroke: 0.6pt + shade.text,
    )
    content(
      (c.at(0) + radius, y),
      anchor: "west",
      padding: 0.25,
      text(size: 11pt, fill: shade.text, label),
    )
  }

  marble(5.1, 1.2, palette.red, $m_1$)
  marble(2.6, 0.45, palette.green, $m_2$)
  marble(0.9, 0.22, palette.blue, $m_3$)
})
