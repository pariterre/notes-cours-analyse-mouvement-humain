#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Dessin d'un sarcomère, partagé par les figures du chapitre : filaments fins
// d'actine (attachés aux stries Z en zigzag), filaments épais de myosine et
// leurs têtes. Une tête forme un pont actomyosine (plus longue, avec un point)
// lorsqu'un filament d'actine lui fait face.

#let actin = palette.blue
#let myosin = palette.red

#let myosin-half = 1.6 // demi-longueur d'un filament de myosine
#let actin-length = 2.2 // longueur d'un filament d'actine
#let bare-zone = 0.3 // zone centrale sans têtes de myosine
#let sarcomere-height = 1.35 // demi-hauteur des stries Z

/// Dessine un sarcomère (commandes CeTZ, à utiliser dans un `cetz.canvas`).
///
/// - center (array): Centre du sarcomère `(x, y)`.
/// - half (float): Demi-longueur du sarcomère (distance du centre aux stries Z).
/// - factor (float): Facteur d'échelle de tout le dessin (traits compris).
/// -> array
#let sarcomere(center, half, factor: 1) = {
  import cetz.draw: *

  let (cx, cy) = center
  let at(x, y) = (cx + factor * x, cy + factor * y)
  let pt(v) = v * factor * 1pt

  let actin-rows = (1, 0, -1)
  let myosin-rows = (0.5, -0.5)
  // Quand les filaments d'actine des deux côtés se croisent au centre, on les
  // décale légèrement pour que le double chevauchement reste visible.
  let crossing = half < actin-length
  // Sarcomère plus court que la myosine : elle bute sur les stries Z et se
  // comprime (dessinée raccourcie, jusqu'aux stries Z).
  let m-half = calc.min(myosin-half, half - 0.06)

  // Actine : de chaque strie Z vers le centre
  for y in actin-rows {
    for side in (-1, 1) {
      let dy = if crossing { side * 0.07 } else { 0 }
      line(at(side * half, y + dy), at(side * (half - actin-length), y + dy), stroke: pt(1.4) + actin.line)
    }
  }

  // Myosine : filament épais et têtes
  for y in myosin-rows {
    line(at(-m-half, y), at(m-half, y), stroke: pt(4) + myosin.line)
    let n = 6
    for side in (-1, 1) {
      for i in range(n) {
        let x = side * (bare-zone + (i + 0.5) * (m-half - bare-zone) / n)
        // Les têtes pointent vers la strie Z la plus proche, vers l'actine
        // voisine ; elles forment un pont quand l'actine est en face.
        let bound = calc.abs(x) > half - actin-length
        for dir in (-1, 1) {
          let tip = at(x + side * 0.2, y + dir * (if bound { 0.5 } else { 0.3 }))
          line(at(x, y + dir * 0.06), tip, stroke: pt(if bound { 1.1 } else { 0.7 }) + myosin.line)
          if bound { circle(tip, radius: 0.05 * factor, fill: myosin.line, stroke: none) }
        }
      }
    }
  }

  // Stries Z en zigzag ; les sommets intérieurs (vers le centre) tombent sur
  // les filaments d'actine
  let (amp, step, n) = (0.11, 0.25, 10)
  for side in (-1, 1) {
    let pts = range(n + 1).map(i => at(
      side * half + side * (if calc.odd(i) { 0 } else { 2 * amp }),
      -1.25 + i * step,
    ))
    line(..pts, stroke: (paint: palette.dark.fill, thickness: pt(1.8), join: "miter"))
  }
}
