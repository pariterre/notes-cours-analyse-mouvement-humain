#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Sac à dos : un objet lourd placé en haut et loin du dos (mal rangé) ou en
// bas et près du dos (bien rangé). Le bras de levier d du poids de l'objet
// par rapport au rachis lombaire (L5/S1) est bien plus grand dans le premier
// cas ; le tronc se penche alors vers l'avant pour ne pas être déséquilibré
// vers l'arrière.

#let bag = palette.green
#let object = palette.gold
#let lever = palette.blue
#let body-color = rgb("#5c6bc0").lighten(25%)
#let size = 6

// Étiquette lisible par-dessus le dessin (fond blanc)
#let tag(body, paint: black) = box(fill: white.transparentize(10%), inset: 2pt, radius: 2pt, text(
  size: 12pt,
  weight: "bold",
  fill: paint,
  body,
))

#let add((ax, ay), (bx, by)) = (ax + bx, ay + by)
#let sub((ax, ay), (bx, by)) = (ax - bx, ay - by)
#let mul((ax, ay), k) = (ax * k, ay * k)
#let norm((ax, ay)) = calc.sqrt(ax * ax + ay * ay)
#let unit(v) = mul(v, 1 / norm(v))

// Dimensions du sac et de l'objet, en fraction de la taille. Repère du tronc :
// `back` vers l'arrière depuis la surface du dos, `up` vers le haut depuis le
// bas du sac.
#let bag-depth = 0.2
#let bag-height = 0.34
#let object-size = (0.07, 0.24) // (épaisseur, hauteur) : un gros livre

#let cases = (
  bad: (
    title: [Objet lourd\ en haut, loin du dos],
    shade: palette.red,
    trunk: 10deg, // le tronc se penche pour compenser
    object: (0.12, 0.09), // position (arrière, haut) du coin bas-avant de l'objet
    // Objets légers qui remplissent le reste du sac : (arrière, haut) des
    // coins opposés
    light: (
      ((0.12, 0.01), (0.19, 0.08)),
      ((0.01, 0.01), (0.11, 0.11)),
      ((0.01, 0.12), (0.11, 0.2)),
      ((0.01, 0.21), (0.055, 0.33)),
      ((0.06, 0.21), (0.11, 0.33)),
    ),
  ),
  good: (
    title: [Objet lourd\ en bas, près du dos],
    shade: palette.green,
    trunk: 0deg,
    object: (0.01, 0.01),
    light: (
      ((0.01, 0.26), (0.08, 0.33)),
      ((0.09, 0.01), (0.19, 0.11)),
      ((0.09, 0.12), (0.19, 0.2)),
      ((0.09, 0.21), (0.14, 0.33)),
      ((0.145, 0.21), (0.19, 0.33)),
    ),
  ),
)

#let x-bad = 0
#let x-good = 5.6

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Sol
  line((-2.2, 0), (x-good + 1.6, 0), stroke: 1pt + palette.neutral.line)

  let panel(c, x0) = {
    let pose = (
      trunk: c.trunk,
      head: -c.trunk,
      shoulder-r: c.trunk - 5deg, // bras le long du corps
      shoulder-l: c.trunk - 5deg,
      elbow-r: 15deg,
      elbow-l: 15deg,
    )
    let p = mannequin-points(pose: pose, size: size)
    let flat(q) = (q.at(0), q.at(2))
    let ground = calc.min(p.heel-r.at(2), p.toe-r.at(2))
    let shift = (x0 - p.ankle-r.at(0), -ground)
    let at(q) = add(flat(q), shift)

    // Repère du tronc
    let pelvis = at(p.pelvis)
    let up = unit(sub(at(p.neck), pelvis))
    let back = (-up.at(1), up.at(0)) // vers l'arrière (x négatif debout)
    let l5 = add(pelvis, mul(up, 0.03 * size))
    // Surface du dos, et bas du sac 5-10 cm sous la taille (sur le bassin)
    let surface = add(pelvis, add(mul(back, 0.035 * size), mul(up, -0.03 * size)))
    let in-bag((b, h)) = add(surface, add(mul(back, b * size), mul(up, h * size)))

    // Sac (derrière le dos) et bretelle
    let corners = (in-bag((0, 0)), in-bag((bag-depth, 0)), in-bag((bag-depth, bag-height)), in-bag((0, bag-height)))
    line(..corners, close: true, fill: bag.fill, stroke: 1.4pt + bag.line)

    mannequin(size: size, origin: shift, view: (azimuth: -90deg), pose: pose, color: body-color)
    // Bretelle : du haut du sac, par-dessus l'épaule, sous l'aisselle
    let shoulder = at(p.shoulder-r)
    let front = mul(back, -1)
    line(
      in-bag((0.01, bag-height - 0.01)),
      add(shoulder, mul(up, 0.035 * size)),
      add(shoulder, add(mul(front, 0.045 * size), mul(up, 0.0))),
      add(shoulder, add(mul(front, 0.02 * size), mul(up, -0.07 * size))),
      in-bag((0.0, bag-height - 0.14)),
      stroke: (paint: bag.line, thickness: 2.4pt, join: "round"),
    )

    // Objets légers
    for ((b0, h0), (b1, h1)) in c.light {
      let pad = 0.004
      line(
        in-bag((b0 + pad, h0 + pad)),
        in-bag((b1 - pad, h0 + pad)),
        in-bag((b1 - pad, h1 - pad)),
        in-bag((b0 + pad, h1 - pad)),
        close: true,
        fill: object.fill,
        stroke: 0.7pt + object.line.lighten(30%),
      )
    }

    // Objet lourd et son poids
    let (ob, oh) = c.object
    let (ot, oz) = object-size
    let obj = (in-bag((ob, oh)), in-bag((ob + ot, oh)), in-bag((ob + ot, oh + oz)), in-bag((ob, oh + oz)))
    line(..obj, close: true, fill: object.line, stroke: 1.2pt + object.text)
    let obj-center = in-bag((ob + ot / 2, oh + oz / 2))
    line(obj-center, sub(obj-center, (0, 1.2)), stroke: 2.4pt + palette.dark.fill, mark: (end: "stealth", fill: palette.dark.fill))
    circle(obj-center, radius: 0.06, fill: palette.dark.fill, stroke: none)
    content(sub(obj-center, (0, 1.2)), anchor: "north", padding: 0.06, tag[$arrow(W)$])

    // Bras de levier du poids par rapport à L5/S1
    line(l5, (obj-center.at(0), l5.at(1)), stroke: 2.4pt + lever.line)
    line((obj-center.at(0), l5.at(1)), obj-center, stroke: (paint: lever.line, thickness: 0.7pt, dash: "dashed"))
    content(((l5.at(0) + obj-center.at(0)) / 2, l5.at(1)), anchor: "north", padding: 0.12, tag(paint: lever.text)[$d$])
    circle(l5, radius: 0.07, fill: white, stroke: 1.2pt + palette.dark.fill)

    content((x0 - 0.3, -0.35), anchor: "north", align(center, text(weight: "semibold", fill: c.shade.text, c.title)))
  }

  panel(cases.bad, x-bad)
  panel(cases.good, x-good)

  // Légende
  let ly = -2.0
  line((-1.6, ly), (-0.9, ly), stroke: 2.4pt + palette.dark.fill, mark: (end: "stealth", fill: palette.dark.fill))
  content((-0.75, ly), anchor: "west", text(size: 9pt)[Poids $arrow(W)$ de l'objet lourd])
  line((3.4, ly), (4.1, ly), stroke: 2.4pt + lever.line)
  content((4.25, ly), anchor: "west", text(size: 9pt)[Bras de levier $d$ (L5/S1)])
})
