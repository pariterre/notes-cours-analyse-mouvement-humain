#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Trois forces appliquées à un objet qui se déplace de A vers B (u) :
//   F1 dans le sens du déplacement : travail positif (moteur);
//   F2 dans le sens opposé : travail négatif (résistant);
//   F3 perpendiculaire : travail nul.
// Couleurs reprises du demi-cercle du signe du travail (vert : positif,
// rouge : négatif); le déplacement en bleu comme dans les figures précédentes.

#let (box-w, box-h) = (2.4, 1.7)
#let f-len = 1.7

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let disp = palette.blue
  let force(from, to, shade, name, work, side) = {
    line(from, to, stroke: 2.6pt + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.2))
    content(from, anchor: side, padding: 0.1, text(size: 13pt, fill: shade.text)[#name $=>$ #work])
  }

  // Sol
  line((-2.6, 0), (8.0, 0), stroke: 1pt + ink)
  for i in range(36) {
    let x = -2.5 + i * 0.3
    line((x, 0), (x - 0.2, -0.2), stroke: 0.5pt + ink.transparentize(40%))
  }

  // Objet
  // Objet déplacé : bleu, comme le déplacement
  rect((0, 0), (box-w, box-h), radius: 0.05, fill: palette.blue.fill, stroke: 1.2pt + palette.blue.line)

  // Déplacement u de A vers B
  // Déplacement dans le haut de l'objet : laisse la place à F2 en dessous
  let a = (box-w / 2, box-h * 0.68)
  let b = (7.2, box-h * 0.68)
  line(a, b, stroke: 2.4pt + disp.line, mark: (end: "stealth", fill: disp.line, stroke: disp.line, scale: 1.2))
  content(((a.at(0) + b.at(0)) / 2 + 1.4, a.at(1)), anchor: "south", padding: 0.12, text(size: 13pt, fill: disp.text)[$arrow(u)$])
  for (p, name) in ((a, $A$), (b, $B$)) {
    circle(p, radius: 0.08, fill: ink, stroke: 1pt + white)
    content(p, anchor: "north", padding: 0.15, text(size: 13pt, weight: "bold", fill: ink, name))
  }

  // Forces
  force((-f-len, box-h * 0.75), (0, box-h * 0.75), palette.green, $arrow(F_1)$, $W_1 > 0$, "east")
  // F2 pousse sur la face avant, vers l'arrière (comme une résistance)
  force((box-w + f-len, box-h * 0.25), (box-w, box-h * 0.25), palette.red, $arrow(F_2)$, $W_2 < 0$, "west")
  // F3 : moitié de la norme de F1 et F2 (valeurs de l'exercice qui suit)
  force((box-w / 2, box-h + f-len / 2), (box-w / 2, box-h), palette.neutral, $arrow(F_3)$, $W_3 = 0$, "south")
})
