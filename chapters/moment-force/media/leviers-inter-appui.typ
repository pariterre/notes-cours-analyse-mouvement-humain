#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Exemples de leviers inter-appui (point d'appui entre la force motrice F et
// la résistance) : ciseaux, tête sur la colonne cervicale, cheville.
// Code couleur : point d'appui en or, force motrice en rouge, résistance en bleu.

#let ink = palette.neutral.text
#let bone = (fill: rgb("#f3efe6"), stroke: 1pt + rgb("#9e9585"))

// `side` et non `anchor` : `import cetz.draw: *` masquerait ce nom
#let force(from, to, shade, label, side, width: 2.6pt, label-at-start: false) = {
  import cetz.draw: *
  line(from, to, stroke: width + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.2))
  content(if label-at-start { from } else { to }, anchor: side, padding: 0.08, text(size: 13pt, weight: "bold", fill: shade.text, label))
}
#let pivot(at) = {
  import cetz.draw: *
  circle(at, radius: 0.13, fill: palette.gold.line, stroke: 1pt + white)
}
#let title(at, body) = {
  import cetz.draw: *
  content(at, anchor: "south", text(size: 12pt, weight: "semibold", fill: ink, body))
}

// Ciseaux : on serre les poignées, l'objet résiste entre les lames.
// Chaque branche est droite : lame d'un côté du pivot, poignée de l'autre.
#let scissors = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let steel = (fill: palette.neutral.fill.darken(8%), stroke: 0.8pt + palette.neutral.line)
  let handle = (fill: palette.red.fill, stroke: 1.2pt + palette.red.line)
  let half-open = 20deg
  let (blade-len, handle-len) = (3.3, 2.4)
  for s in (1, -1) {
    let a = s * half-open
    let d = (calc.cos(a), calc.sin(a))
    let n = (-d.at(1), d.at(0))
    let at(t, w) = (t * d.at(0) + w * n.at(0), t * d.at(1) + w * n.at(1))
    // Lame (côté extérieur bombé, tranchant côté intérieur)
    line(at(-0.3, 0.13 * s), at(blade-len, 0.03 * s), at(blade-len, -0.02 * s), at(-0.3, -0.12 * s), close: true, ..steel)
    // Poignée dans le prolongement de la lame, de l'autre côté du pivot
    let ring = at(-handle-len, 0)
    line(at(-0.3, 0), at(-handle-len + 0.45, 0), stroke: (paint: palette.red.line, thickness: 5pt, cap: "round"))
    circle(ring, radius: 0.48, ..handle)
    circle(ring, radius: 0.26, fill: white, stroke: 1pt + palette.red.line)
  }
  // Objet à couper, tangent aux deux lames
  let x-obj = 1.6
  let r-obj = x-obj * calc.sin(half-open)
  circle((x-obj, 0), radius: r-obj, fill: palette.blue.fill, stroke: 1pt + palette.blue.line)
  pivot((0, 0))
  // Forces perpendiculaires aux branches (comme dans l'original) :
  //   F sur l'anneau, vers l'autre anneau (on serre);
  //   R au contact de l'objet, dirigée vers l'autre lame.
  for s in (1, -1) {
    let a = s * half-open
    let d = (calc.cos(a), calc.sin(a))
    let dir = (-calc.sin(a) * s, calc.cos(a) * s) // normale, même sens pour F et R
    let ring = (-handle-len * d.at(0), -handle-len * d.at(1))
    let along(p, k) = (p.at(0) + k * dir.at(0), p.at(1) + k * dir.at(1))
    force(along(ring, -1.45), along(ring, -0.5), palette.red, [F], if s > 0 { "north" } else { "south" }, label-at-start: true)
    let contact = (x-obj * calc.cos(a) * d.at(0), x-obj * calc.cos(a) * d.at(1))
    // R part du contact et traverse l'objet vers l'autre lame (comme l'original)
    force(contact, along(contact, -1.6), palette.blue, [R], if s > 0 { "north" } else { "south" })
  }
  title((0.5, 2.55), [Ciseaux])
  line((0, -3.0), (0, 2.9), stroke: none)
})

// Tête (profil, regard vers la droite) : les muscles de la nuque retiennent
// le poids de la tête, dont le centre de masse est un peu en avant de
// l'articulation avec la colonne
#let head = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let skin = (fill: rgb("#f6e7da"), stroke: 1pt + rgb("#a1806a"))
  // Cou
  rect((-0.5, -2.4), (0.35, -0.6), fill: skin.fill, stroke: none)
  line((-0.5, -2.4), (-0.5, -0.75), stroke: skin.stroke)
  line((0.35, -2.4), (0.35, -0.95), stroke: skin.stroke)
  // Tête : arrière du crâne, sommet, front, nez, bouche, menton
  hobby(
    (-0.5, -0.75),
    (-0.85, -0.1),
    (-1.0, 0.65),
    (-0.5, 1.4),
    (0.35, 1.5),
    (0.95, 1.0),
    (1.05, 0.5),
    (1.35, 0.08),
    (1.08, -0.05),
    (1.1, -0.35),
    (0.95, -0.75),
    (0.45, -0.9),
    (0.35, -0.95),
    ..skin,
  )
  line((0.35, -0.95), (-0.5, -0.75), stroke: none)
  rect((-0.49, -1.3), (0.34, -0.7), fill: skin.fill, stroke: none) // raccord tête-cou
  circle((0.72, 0.55), radius: 0.07, fill: ink, stroke: none) // œil
  circle((-0.15, 0.25), radius: (0.13, 0.2), fill: none, stroke: skin.stroke) // oreille
  // Colonne cervicale (en transparence)
  for i in range(4) {
    rect((-0.22, -2.3 + i * 0.42), (0.12, -2.0 + i * 0.42), radius: 0.05, fill: bone.fill, stroke: 0.6pt + rgb("#9e9585"))
  }
  pivot((-0.05, -0.45))
  force((-0.8, -0.1), (-0.8, -2.0), palette.red, [F], "east")
  force((0.25, 0.45), (0.25, -1.1), palette.blue, [P], "west")
  circle((0.25, 0.45), radius: 0.07, fill: palette.blue.line, stroke: 1pt + white)
  title((0.15, 2.55), [Tête])
  line((0, -3.0), (0, 2.9), stroke: none)
})

// Cheville : le mollet tire le talon vers le haut, le sol pousse sous l'avant-pied
#let ankle = cetz.canvas(length: 1cm, {
  import cetz.draw: *
  line((-0.6, -2.2), (2.4, -2.2), stroke: 1pt + ink)
  for i in range(12) {
    let x = -0.5 + i * 0.25
    line((x, -2.2), (x - 0.18, -2.38), stroke: 0.5pt + ink.transparentize(40%))
  }
  // Fémur (coupé en haut), genou, tibia, pied
  // Genou un peu fléchi : le fémur remonte vers l'arrière (la hanche)
  let knee = (0, 1.4)
  let femur-angle = 112deg
  let fd = (calc.cos(femur-angle), calc.sin(femur-angle))
  let fn = (-fd.at(1) * 0.2, fd.at(0) * 0.2)
  let fp(t, w) = (knee.at(0) + t * fd.at(0) + w * fn.at(0), knee.at(1) + t * fd.at(1) + w * fn.at(1))
  line(fp(0, 1), fp(1.05, 1), fp(1.05, -1), fp(0, -1), close: true, ..bone)
  circle(knee, radius: 0.27, ..bone) // condyles du fémur
  rect((-0.18, -1.15), (0.18, 1.2), radius: 0.08, ..bone)
  line((-0.6, -2.2), (-0.62, -1.55), (-0.2, -1.05), (0.35, -1.1), (1.2, -1.6), (2.05, -1.95), (2.05, -2.2), close: true, ..bone)
  // Muscle du mollet (attaché au fémur, au-dessus du genou) et tendon d'Achille
  bezier((-0.35, 1.6), (-0.45, -0.6), (-1.0, 0.95), (-0.65, 0.0), stroke: (paint: palette.red.line.transparentize(30%), thickness: 6pt, cap: "round"))
  line((-0.45, -0.6), (-0.55, -1.6), stroke: (paint: palette.red.line.transparentize(30%), thickness: 2.5pt))
  pivot((0, -1.2))
  force((-0.9, -1.6), (-0.9, -0.3), palette.red, [F], "east")
  force((1.6, -2.2), (1.6, -1.0), palette.blue, [R], "west") // part du sol, sous l'avant-pied
  title((0.7, 2.55), [Cheville])
  line((0, -2.6), (0, 2.9), stroke: none)
})

#grid(
  columns: 3,
  column-gutter: 1.5em,
  align: top,
  scissors, head, ankle,
)
