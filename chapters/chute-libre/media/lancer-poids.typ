#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Outils communs aux figures sur l'effet des paramètres de lâcher en lancer
// de poids. Lancer de référence : lâché au butoir (x_i = 0 m), à 2.2 m de
// haut, à 12 m/s et 40°; il atterrit à ≈ 16.72 m.
//
// Chaque panneau montre les trajectoires complètes à l'échelle (en haut) et
// une règle agrandie de la zone d'atterrissage (en bas), où l'on lit le gain
// ou la perte de performance par rapport au lancer de référence.

#let g = 9.81
#let reference = (x: 0, h: 2.2, v: 12, angle: 40)

/// Distance d'atterrissage (y = 0) d'un lancer.
#let landing(throw) = {
  let vx = throw.v * calc.cos(throw.angle * 1deg)
  let vy = throw.v * calc.sin(throw.angle * 1deg)
  let t = (vy + calc.sqrt(vy * vy + 2 * g * throw.h)) / g
  throw.x + vx * t
}

/// Points de la trajectoire jusqu'au sol.
#let trajectory(throw, steps: 60) = {
  let vx = throw.v * calc.cos(throw.angle * 1deg)
  let vy = throw.v * calc.sin(throw.angle * 1deg)
  let t-end = (vy + calc.sqrt(vy * vy + 2 * g * throw.h)) / g
  range(steps + 1).map(i => {
    let t = t-end * i / steps
    (throw.x + vx * t, throw.h + vy * t - g * t * t / 2)
  })
}

#let fixed(value, digits) = {
  if digits == 0 { return str(int(calc.round(value))) }
  let negative = value < 0
  let scaled = str(int(calc.round(calc.abs(value) * calc.pow(10, digits))))
  while scaled.len() <= digits { scaled = "0" + scaled }
  (if negative { "-" } else { "" }) + scaled.slice(0, -digits) + "." + scaled.slice(-digits)
}

/// Un panneau.
/// - title (content): titre au-dessus.
/// - variants (array): (changements par rapport à la référence, nom).
///   Ils sont colorés dans l'ordre vert (plus petit), bleu (référence),
///   rouge (plus grand).
/// - zoom (array): (début, fin, pas des graduations) de la règle agrandie, en m.
#let panel(title, variants, zoom) = {
  import cetz.draw: *

  let ink = palette.neutral.text
  let shades = (palette.green, palette.blue, palette.red)
  // cm par mètre; l'échelle verticale est agrandie pour bien séparer les courbes
  let (k, ky) = (0.42, 0.75)
  let x-max = 20.5
  let width = x-max * k
  let throws = variants.map(((change, _)) => reference + change)
  let ref-landing = landing(reference)

  // Titre
  content((width / 2, 7.4 * ky), anchor: "south", text(size: 13pt, fill: ink, weight: "semibold", title))

  // Axes
  let arrow-mark = (end: "stealth", fill: ink, stroke: ink)
  line((0, 0), (width + 0.2, 0), stroke: 0.8pt + ink, mark: arrow-mark)
  line((0, 0), (0, 7 * ky), stroke: 0.8pt + ink, mark: arrow-mark)
  for x in range(0, 21, step: 5) {
    line((x * k, 0), (x * k, -0.08), stroke: 0.6pt + ink)
    content((x * k, -0.12), anchor: "north", text(size: 10pt, fill: ink)[#x])
  }
  for y in range(0, 7) {
    line((0, y * ky), (-0.08, y * ky), stroke: 0.6pt + ink)
    content((-0.12, y * ky), anchor: "east", text(size: 10pt, fill: ink)[#y])
  }
  content((width + 0.2, 0), anchor: "west", padding: 0.1, text(size: 11pt, fill: ink)[$x$ (#unit[m])])
  content((0, 7 * ky), anchor: "west", padding: 0.15, text(size: 11pt, fill: ink)[$y$ (#unit[m])])

  // Trajectoires, la référence par-dessus
  for i in (0, 2, 1) {
    let pts = trajectory(throws.at(i)).map(((x, y)) => (x * k, y * ky))
    line(..pts, stroke: (paint: shades.at(i).line, thickness: 1.6pt, join: "round"))
    circle(pts.first(), radius: 0.06, fill: shades.at(i).line, stroke: none)
  }

  // Légende
  for (i, (_, name)) in variants.enumerate() {
    let y = 7 * ky - 0.3 - i * 0.45
    line((15.2 * k, y), (16.6 * k, y), stroke: (paint: shades.at(i).line, thickness: 1.6pt))
    content((16.9 * k, y), anchor: "west", text(size: 11pt, fill: shades.at(i).text, name))
  }

  // Règle agrandie de la zone d'atterrissage
  let (z0, z1, z-step) = zoom
  let ruler-y = -1.95
  let zx(x) = (x - z0) / (z1 - z0) * width
  let zoom-guide = (paint: ink.transparentize(60%), thickness: 0.6pt, dash: "dashed")
  rect((z0 * k, -0.04), (z1 * k, 0.04), fill: ink.transparentize(70%), stroke: none)
  line((z0 * k, 0), (0, ruler-y), stroke: zoom-guide)
  line((z1 * k, 0), (width, ruler-y), stroke: zoom-guide)
  line((0, ruler-y), (width, ruler-y), stroke: 1pt + ink)
  let n = int(calc.round((z1 - z0) / z-step))
  for j in range(n + 1) {
    let x = z0 + j * z-step
    line((zx(x), ruler-y), (zx(x), ruler-y - 0.1), stroke: 0.6pt + ink)
    content((zx(x), ruler-y - 0.14), anchor: "north", text(size: 9pt, fill: ink, fixed(x, if z-step < 1 { 1 } else { 0 })))
  }
  content((width / 2, ruler-y - 0.6), anchor: "north", text(
    size: 10pt,
    fill: ink,
    style: "italic",
  )[zone d'atterrissage agrandie (#unit[m])])

  // Points d'atterrissage et écart avec la référence
  for (i, throw) in throws.enumerate() {
    let d = landing(throw)
    let shade = shades.at(i)
    let x = zx(d)
    line((x, ruler-y), (x - 0.1, ruler-y + 0.2), (x + 0.1, ruler-y + 0.2), close: true, fill: shade.line, stroke: none)
    let delta = d - ref-landing
    let distance = fixed(d, 2)
    let gain = (if delta > 0 { "+" } else { "" }) + fixed(delta, 2)
    let label = if i == 1 { [*#qty[#distance][m]* \ #text(size: 9.5pt)[(référence)]] } else {
      [#qty[#distance][m] \ #text(size: 9.5pt)[(#qty[#gain][m])]]
    }
    // Fond blanc : les guides du zoom passent derrière
    content((x, ruler-y + 0.25), anchor: "south", box(fill: white, inset: 1.5pt, radius: 2pt, text(
      size: 11pt,
      fill: shade.text,
      align(center, label),
    )))
  }
}
