#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Chaque choix : (couleur, nom, position du mot « temps », points).
// Question : quelle courbe (rouge, verte ou bleue) décrit l'accélération
// d'un doigt qui part de l'arrêt, se déplace à vitesse constante puis
// s'arrête ? (la bonne réponse est la bleue)
#let choices = (
  (palette.red, [rouge], "north-east", ((0, 0), (0.4, 1.4), (2.6, 1.4), (3, 0))),
  (palette.green, [verte], "north-east", ((0, 0), (1.5, 2.2), (3, 0))),
  (
    palette.blue,
    [bleue],
    "south-east",
    ((0, 0), (0.05, 1.4), (0.6, 1.4), (0.65, 0), (2.35, 0), (2.4, -1.4), (2.95, -1.4), (3, 0)),
  ),
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let (w, gap) = (3.3, 1.0)

  for (i, (shade, name, temps-anchor, pts)) in choices.enumerate() {
    let x0 = i * (w + gap)
    let at((t, a)) = (x0 + t, a)
    line(at((0, 0)), at((w, 0)), stroke: 0.8pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
    line(at((0, -1.8)), at((0, 2.6)), stroke: 0.8pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
    line(..pts.map(at), stroke: (paint: shade.line, thickness: 2.2pt, join: "round"))
    // Nom de l'axe sous ou sur la fin de l'axe, du côté libre de la courbe
    content(at((w, 0)), anchor: temps-anchor, padding: 0.2, text(size: 12pt, fill: ink)[temps])
    content(at((w / 2, -2.4)), text(size: 13pt, weight: "semibold", fill: shade.text)[Courbe #name])
  }
  content((-0.3, 0.4), angle: 90deg, anchor: "south", text(size: 12pt, fill: ink)[accélération (#unit[m / s^2])])
})
