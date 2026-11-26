#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Kayak vu de dessus (il avance vers le haut). À gauche, pale plate : elle
// ne recule que vers l'arrière; la force propulsive est la traînée, opposée
// à sa vitesse. À droite, pale creuse (profil d'aile) : elle recule et
// s'écarte de la coque; la traînée (opposée à la vitesse) et la portance
// (perpendiculaire à la vitesse) se combinent en une force propulsive
// dirigée vers l'avant.
// Mêmes couleurs que la figure portance/traînée : traînée en rouge, portance
// en gris, résultante en or; vitesse de la pale en bleu (déplacement).

#let force-len = 1.9 // norme de la force propulsive
// Pale creuse : direction de sa vitesse (vers l'arrière et l'extérieur)
#let v-dir = {
  let (x, y) = (0.7, -1)
  let n = calc.norm(x, y)
  (x / n, y / n)
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let vec(from, d, shade, width: 2.4pt) = line(from, (from.at(0) + d.at(0), from.at(1) + d.at(1)), stroke: width + shade.line, mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.1))
  let tip(from, d) = (from.at(0) + d.at(0), from.at(1) + d.at(1))
  let scaled(d, k) = (d.at(0) * k, d.at(1) * k)

  // Coque (fuseau) et sens d'avancement
  let hull(side) = range(0, 41).map(i => {
    let y = -3.4 + 6.8 * i / 40
    (side * 0.6 * (1 - calc.pow(y / 3.4, 2)), y)
  })
  line(..hull(1), ..hull(-1).rev(), close: true, fill: palette.neutral.fill.darken(4%), stroke: 1.2pt + palette.neutral.line)
  // Arête du pont, à l'avant et à l'arrière du cockpit
  line((0, 3.1), (0, 0.75), stroke: 0.6pt + palette.neutral.line.lighten(30%))
  line((0, -0.95), (0, -3.1), stroke: 0.6pt + palette.neutral.line.lighten(30%))
  // Hiloire du cockpit et kayakiste (épaules et tête vues de dessus)
  let cockpit = range(0, 41).map(i => {
    let t = 360deg * i / 40
    (0.4 * calc.cos(t), -0.1 + 0.8 * calc.sin(t))
  })
  line(..cockpit, close: true, fill: palette.neutral.fill.darken(25%), stroke: 1.6pt + palette.neutral.line)
  let shoulders = range(0, 41).map(i => {
    let t = 360deg * i / 40
    (0.62 * calc.cos(t), -0.05 + 0.22 * calc.sin(t))
  })
  line(..shoulders, close: true, fill: palette.blue.fill.darken(10%), stroke: 0.9pt + palette.blue.line)
  circle((0, 0.02), radius: 0.2, fill: palette.blue.fill.darken(25%), stroke: 0.9pt + palette.blue.line)
  line((0, 1.3), (0, 2.5), stroke: 1.4pt + ink, mark: (end: "stealth", fill: ink, stroke: ink))
  content((0, 3.5), anchor: "south", text(size: 10pt, fill: ink, style: "italic")[avancement])

  // --- Pale plate (à gauche)
  let a = (-2.6, 0)
  rect((a.at(0) - 0.6, a.at(1) - 0.06), (a.at(0) + 0.6, a.at(1) + 0.06), fill: palette.dark.fill, stroke: none)
  vec(a, (0, -2.0), palette.blue, width: 1.4pt)
  content((a.at(0) + 0.15, a.at(1) - 1.6), anchor: "west", text(size: 12pt, fill: palette.blue.text)[$arrow(v)$])
  vec((a.at(0), a.at(1) + 0.08), (0, force-len), palette.gold, width: 3pt)
  content(tip(a, (0, force-len)), anchor: "south", padding: 0.12, text(size: 11pt, fill: palette.gold.text, align(center)[*force propulsive* \ (traînée)]))
  content((a.at(0), -3.4), anchor: "north", text(size: 11pt, weight: "semibold", fill: ink)[Pale plate])

  // --- Pale creuse (à droite) : profil cambré, convexe vers l'avant
  let b = (2.8, 0)
  let chord = 1.3
  let upper = range(0, 21).map(i => {
    let t = -1 + 2 * i / 20
    (b.at(0) + t * chord / 2, b.at(1) + 0.32 * (1 - t * t))
  })
  let lower = range(0, 21).map(i => {
    let t = 1 - 2 * i / 20
    (b.at(0) + t * chord / 2, b.at(1) + 0.12 * (1 - t * t))
  })
  line(..upper, ..lower, close: true, fill: palette.dark.fill, stroke: none)
  vec(b, scaled(v-dir, 2.1), palette.blue, width: 1.4pt)
  content(tip(b, scaled(v-dir, 1.7)), anchor: "west", padding: 0.15, text(size: 12pt, fill: palette.blue.text)[$arrow(v)$])
  // Traînée (opposée à v) et portance (perpendiculaire à v) : leur somme
  // est dirigée vers l'avant
  let drag-dir = (-v-dir.at(0), -v-dir.at(1))
  let lift-dir = (-v-dir.at(1), v-dir.at(0))
  let lift-dir = if lift-dir.at(1) < 0 { (-lift-dir.at(0), -lift-dir.at(1)) } else { lift-dir }
  // Normes telles que la somme soit verticale et de norme force-len
  let ratio = -drag-dir.at(0) / lift-dir.at(0)
  let drag = force-len / (drag-dir.at(1) + ratio * lift-dir.at(1))
  let lift = ratio * drag
  let o = (b.at(0), b.at(1) + 0.2)
  let guide = (paint: ink.transparentize(45%), thickness: 0.7pt, dash: "dashed")
  line(tip(o, scaled(drag-dir, drag)), tip(o, (0, force-len)), tip(o, scaled(lift-dir, lift)), stroke: guide)
  vec(o, scaled(drag-dir, drag), palette.red)
  content(tip(o, scaled(drag-dir, drag)), anchor: "east", padding: 0.12, text(size: 11pt, fill: palette.red.text)[traînée])
  vec(o, scaled(lift-dir, lift), palette.neutral)
  content(tip(o, scaled(lift-dir, lift)), anchor: "west", padding: 0.12, text(size: 11pt, fill: palette.neutral.text)[portance])
  vec(o, (0, force-len), palette.gold, width: 3pt)
  content(tip(o, (0, force-len)), anchor: "south", padding: 0.12, text(size: 11pt, weight: "semibold", fill: palette.gold.text)[force propulsive])
  content((b.at(0), -3.4), anchor: "north", text(size: 11pt, weight: "semibold", fill: ink)[Pale creuse])
})
