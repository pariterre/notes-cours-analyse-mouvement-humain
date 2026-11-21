#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Levier inter-appui en équilibre autour du point d'appui O :
//   - la résistance R (gauche, bras court) fait tourner dans le sens direct :
//     moment positif;
//   - la force motrice F (droite, bras long) fait tourner dans le sens
//     horaire : moment négatif;
//   - la réaction en O (violet) compense R + F; son bras de levier est nul.
// Bras de levier dans un rapport 1 : 3, donc R = 3 F.

#let (arm-r, arm-f) = (1.2, 3.6)
#let tilt = 15deg // inclinaison de la barre (les forces restent verticales)
#let force-scale = 0.8 // longueur dessinée de F
#let purple = (fill: rgb("#f1e4f7"), line: rgb("#7b1fa2"), text: rgb("#561571"))

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let f-len = force-scale
  let r-len = force-scale * arm-f / arm-r
  let vec(from, to, shade, width: 3pt) = line(from, to, stroke: width + shade.line, mark: (
    end: "stealth",
    fill: shade.line,
    stroke: shade.line,
    scale: 1.3,
  ))
  // Flèche courbe de rotation (sens direct ou horaire) autour de c
  let rotation(c, ccw, shade, radius: 0.5, from: 90deg) = {
    let sgn = if ccw { 1 } else { -1 }
    let arc = range(0, 25).map(i => add(c, polar(radius, from + sgn * 110deg * i / 24)))
    line(..arc.slice(0, 21), stroke: (paint: shade.line, thickness: 1.5pt, cap: "round"))
    let (tip, back) = (arc.last(), arc.at(19))
    let (dx, dy) = (tip.at(0) - back.at(0), tip.at(1) - back.at(1))
    let n = calc.sqrt(dx * dx + dy * dy)
    let w = (-dy / n * 0.1, dx / n * 0.1)
    line(tip, add(back, w), add(back, w.map(c => -c)), close: true, fill: shade.line, stroke: none)
  }

  // Barre : bras de résistance (bleu) et bras de force (rouge)
  let end-r = polar(-arm-r, tilt)
  let end-f = polar(arm-f, tilt)
  line(end-r, (0, 0), stroke: (paint: palette.blue.line, thickness: 4pt, cap: "round"))
  line((0, 0), end-f, stroke: (paint: palette.red.line, thickness: 4pt, cap: "round"))

  // Point d'appui
  line((-0.3, -0.55), (0.3, -0.55), (0, -0.06), close: true, fill: palette.gold.fill, stroke: 1.2pt + palette.gold.line)

  // Résistance et force motrice
  let tip-r = add(end-r, (0, -r-len))
  let tip-f = add(end-f, (0, -f-len))
  vec(end-r, tip-r, palette.blue)
  content(tip-r, anchor: "north", padding: 0.1, text(size: 14pt, fill: palette.blue.text)[$arrow(R)$])
  vec(end-f, tip-f, palette.red)
  content(tip-f, anchor: "north", padding: 0.1, text(size: 14pt, fill: palette.red.text)[$arrow(F)$])

  // Moments : + pour R (sens direct), − pour F (sens horaire)
  rotation(end-r, true, palette.blue, radius: 0.55, from: 110deg)
  content(add(end-r, (-0.75, 0.55)), text(size: 14pt, weight: "bold", fill: palette.blue.text)[+])
  rotation(end-f, false, palette.red, radius: 0.55, from: 70deg)
  content(add(end-f, (0.75, 0.55)), text(size: 14pt, weight: "bold", fill: palette.red.text)[−])

  // Réaction en O, égale et opposée à R + F (décomposition à côté)
  vec((0, 0), (0, r-len + f-len), purple, width: 3.4pt)
  content((0, r-len + f-len), anchor: "south", padding: 0.1, text(size: 13pt, fill: purple.text)[réaction])
  let x-sum = -0.35 // à gauche : la barre monte vers la droite
  line((x-sum, 0), (x-sum, r-len), stroke: 1.6pt + palette.blue.line)
  line((x-sum, r-len), (x-sum, r-len + f-len), stroke: 1.6pt + palette.red.line)
  content((x-sum, r-len / 2), anchor: "east", padding: 0.08, text(size: 11pt, fill: palette.blue.text)[$norm(arrow(R))$])
  content((x-sum, r-len + f-len / 2), anchor: "east", padding: 0.08, text(size: 11pt, fill: palette.red.text)[$norm(arrow(F))$])

  circle((0, 0), radius: 0.08, fill: ink, stroke: 1pt + white)
  content((0.12, -0.05), anchor: "north-west", padding: 0.18, text(size: 13pt, weight: "bold", fill: ink)[$O$])

  // Repère et sens positif
  let o = (-3.4, -2.6)
  for (to, label, anchor) in ((add(o, (1.1, 0)), $x$, "west"), (add(o, (0, 1.1)), $y$, "south")) {
    line(o, to, stroke: 1pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
    content(to, anchor: anchor, padding: 0.1, text(size: 12pt, fill: ink, label))
  }
  rotation(add(o, (0.1, 0.1)), true, palette.blue, radius: 0.6, from: -10deg)
  content(add(o, (0.4, 0.4)), text(size: 11pt, fill: palette.blue.text, weight: "bold")[+])
})
