#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Petites icônes des configurations musculaires, pour le tableau
// « Exemples de configurations musculaires ». Même style que la figure
// configuration-fibres.typ : corps musculaire rouge pâle, fibres rouges,
// tendons et aponévroses foncés. Le muscle est couché (axe horizontal).
//
// Utilisation : `#muscle-icon("fusiforme")`, avec l'un des types :
// "parallele", "fusiforme", "circulaire", "penniforme", "bipenniforme",
// "eventail".

#let muscle = palette.red
#let tendon = 1.6pt + palette.dark.fill
#let fibre = 0.5pt + muscle.line

#let muscle-icon(kind, length: 2.4) = cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let L = length // longueur totale, tendons compris
  let h = 0.38 // demi-épaisseur du corps musculaire

  // Cadre invisible : toutes les icônes ont la même taille
  rect((0, -h - 0.12), (L, h + 0.12), stroke: none)

  if kind == "parallele" {
    // Fibres parallèles d'une extrémité à l'autre, tendons très courts
    let (x0, x1) = (0.25, L - 0.25)
    rect((x0, -h), (x1, h), fill: muscle.fill, stroke: none)
    for i in range(7) {
      let y = -h + (i + 0.5) * 2 * h / 7
      line((x0, y), (x1, y), stroke: fibre)
    }
    line((x0, -h), (x0, h), stroke: tendon)
    line((x1, -h), (x1, h), stroke: tendon)
    line((0, 0), (x0, 0), stroke: tendon)
    line((x1, 0), (L, 0), stroke: tendon)
  } else if kind == "fusiforme" {
    // Corps en fuseau, fibres presque parallèles qui convergent vers les tendons
    let (x0, x1) = (0.45, L - 0.45)
    let profile(x) = h * calc.sin(180deg * (x - x0) / (x1 - x0))
    let curve(k) = range(0, 41).map(i => {
      let x = x0 + i / 40 * (x1 - x0)
      (x, k * profile(x))
    })
    line(..curve(1), ..curve(-1).rev(), close: true, fill: muscle.fill, stroke: none)
    for k in (-0.95, -0.6, -0.2, 0.2, 0.6, 0.95) {
      line(..curve(k), stroke: fibre)
    }
    line((0, 0), (x0, 0), stroke: tendon)
    line((x1, 0), (L, 0), stroke: tendon)
  } else if kind == "circulaire" {
    // Fibres concentriques autour d'un orifice (orbiculaire)
    let c = (L / 2, 0)
    let (r-in, r-out) = (0.16, h + 0.05)
    circle(c, radius: r-out, fill: muscle.fill, stroke: none)
    circle(c, radius: r-in, fill: white, stroke: none)
    for i in range(5) {
      circle(c, radius: r-in + (i + 0.5) * (r-out - r-in) / 5, stroke: fibre)
    }
  } else if kind == "penniforme" {
    // Fibres obliques qui s'attachent d'un seul côté du tendon
    let shift = 0.45 // décalage horizontal d'une fibre entre ses deux attaches
    let (x0, x1) = (0.1, L - 0.35)
    line((x0, h), (x1 - shift, h), (x1, -h), (x0 + shift, -h), close: true, fill: muscle.fill, stroke: none)
    let n = 8
    for i in range(n + 1) {
      let x = x0 + i / n * (x1 - shift - x0)
      line((x, h), (x + shift, -h), stroke: fibre)
    }
    line((x0 + shift, -h), (L, -h), stroke: tendon)
  } else if kind == "bipenniforme" {
    // Fibres obliques de part et d'autre d'un tendon central (en plume)
    let shift = 0.4
    let (x0, x1) = (0.1, L - 0.35)
    line((x0, h), (x1 - shift, h), (x1, 0), (x1 - shift, -h), (x0, -h), (x0 + shift, 0), close: true, fill: muscle.fill, stroke: none)
    let n = 8
    for i in range(n + 1) {
      let x = x0 + i / n * (x1 - shift - x0)
      line((x, h), (x + shift, 0), stroke: fibre)
      line((x, -h), (x + shift, 0), stroke: fibre)
    }
    line((x0 + shift, 0), (L, 0), stroke: tendon)
  } else if kind == "eventail" {
    // Large origine, fibres qui convergent vers un tendon unique
    let (x0, x1) = (0.2, L - 0.45)
    let wide = h + 0.07
    line((x0, wide), (x1, 0), (x0, -wide), close: true, fill: muscle.fill, stroke: none)
    let n = 8
    for i in range(n + 1) {
      let y = -wide + i / n * 2 * wide
      line((x0, y), (x1, 0), stroke: fibre)
    }
    line((x0, -wide), (x0, wide), stroke: tendon)
    line((x1, 0), (L, 0), stroke: tendon)
  } else {
    panic("muscle-icon : type inconnu « " + kind + " »")
  }
})

// Aperçu de toutes les icônes quand le fichier est compilé seul
#grid(
  columns: 2,
  gutter: 8pt,
  align: horizon,
  ..("parallele", "fusiforme", "circulaire", "penniforme", "bipenniforme", "eventail")
    .map(kind => (raw(kind), muscle-icon(kind)))
    .flatten()
)
