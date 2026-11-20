#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Deux impulsions de même aire (195 N s) : le premier athlète applique une
// force résultante de 650 N pendant 0.300 s, le second 1500 N pendant 0.130 s.
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (sx, sy) = (22, 0.0026) // échelles : unités par seconde et par newton
  let (t-max, f-max) = (0.42, 1650)
  // `written` : durée telle qu'écrite dans le texte
  let athletes = (
    (force: 650, duration: 0.300, written: "0.300", shade: palette.blue, name: [Athlète 1]),
    (force: 1500, duration: 0.130, written: "0.130", shade: palette.green, name: [Athlète 2]),
  )
  let at(t, f) = (t * sx, f * sy)

  // Rectangles (aires = impulsions), semi-transparents pour voir le
  // recouvrement
  for a in athletes {
    rect(
      at(0, 0),
      at(a.duration, a.force),
      fill: a.shade.fill.transparentize(25%),
      stroke: 1.5pt + a.shade.line,
    )
  }

  // Axes
  let axis(to) = line(at(0, 0), to, stroke: 1.2pt + black, mark: (end: "stealth", fill: black))
  axis(at(t-max, 0))
  axis(at(0, f-max))
  content(at(t-max, 0), anchor: "south-east", padding: 0.15)[Temps $[#unit[s]]$]
  content(at(0, f-max), anchor: "south", padding: 0.1)[Somme des forces $[#unit[N]]$]

  // Graduations aux valeurs des deux athlètes
  for a in athletes {
    content(at(0, a.force), anchor: "east", padding: 0.12, text(fill: a.shade.text)[#a.force])
    content(at(a.duration, 0), anchor: "north", padding: 0.12, text(fill: a.shade.text, a.written))
  }

  // Étiquettes : force × durée = impulsion
  let label(pos, a) = content(pos, anchor: "west", text(size: 10pt, fill: a.shade.text)[
    *#a.name* \
    $#qty[#a.force][N] times #qty[#a.written][s] = #qty[195][N s]$
  ])
  label(at(0.31, 450), athletes.at(0))
  label(at(0.14, 1250), athletes.at(1))
})
