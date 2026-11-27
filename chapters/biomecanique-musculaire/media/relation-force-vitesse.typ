#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Relation force-vitesse : vitesse positive = raccourcissement (concentrique),
// négative = allongement (excentrique). Force relative à la force maximale
// isométrique F_iso, vitesse relative à la vitesse maximale V_max.
//   - concentrique : hyperbole de Hill, (f + k)(v + k) = k (1 + k)
//   - excentrique : hyperbole qui tend vers 1,5 F_iso

#let concentric = palette.blue
#let eccentric = palette.gold

#let k = 0.25 // courbure de l'hyperbole de Hill (a / F_iso)
#let k-ecc = 0.08 // raideur de la montée excentrique
#let f-ecc = 1.5 // asymptote excentrique (× F_iso)

#let force(v) = if v >= 0 {
  k * (1 - v) / (v + k)
} else {
  f-ecc - (f-ecc - 1) * k-ecc / (k-ecc - v)
}

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (v-min, v-max) = (-0.75, 1)
  let (kx, ky) = (5, 2.6) // échelles (cm par unité)
  let p(v, f) = (v * kx, f * ky)

  // Repères F_iso et 1,5 F_iso
  let guide = (paint: palette.neutral.text, thickness: 0.7pt, dash: "dashed")
  for (f, label) in ((1, $F_"iso"$), (f-ecc, $1.5 F_"iso"$)) {
    line(p(v-min, f), p(0, f), stroke: guide)
    content(p(v-min, f), anchor: "east", padding: 0.1, text(size: 10pt, label))
  }

  // Courbes
  let curve(from, to) = range(0, 101).map(i => {
    let v = from + i / 100 * (to - from)
    p(v, force(v))
  })
  line(..curve(v-min, 0), stroke: 2.2pt + eccentric.line)
  line(..curve(0, v-max), stroke: 2.2pt + concentric.line)
  circle(p(0, 1), radius: 0.07, fill: palette.dark.fill, stroke: none)

  // Axes
  let axis-mark = (end: "stealth", fill: black)
  line(
    p(v-min - 0.05, 0),
    p(v-max + 0.12, 0),
    stroke: 1.2pt + black,
    mark: axis-mark,
  )
  line(p(0, 0), p(0, f-ecc + 0.35), stroke: 1.2pt + black, mark: axis-mark)
  content(p(v-max + 0.12, 0), anchor: "west", padding: 0.12, align(left, text(
    size: 10pt,
  )[Vitesse de\ raccourcissement]))
  content(p(0, f-ecc + 0.35), anchor: "west", padding: 0.12)[Force]
  content(p(0, 0), anchor: "north", padding: 0.12)[$0$]
  line(p(v-max, 0), (rel: (0, -0.12)), stroke: 1pt + black)
  content(p(v-max, 0), anchor: "north", padding: 0.18)[$V_max$]

  // Zones
  content(p(v-min / 2, 0.5), text(
    fill: eccentric.text,
    weight: "semibold",
  )[Excentrique])
  content(p(v-min / 2, 0.5 - 0.17), text(
    size: 9pt,
    fill: eccentric.text,
  )[(allongement)])
  content(p(0.55, 0.9), text(
    fill: concentric.text,
    weight: "semibold",
  )[Concentrique])
  content(p(0.55, 0.9 - 0.17), text(
    size: 9pt,
    fill: concentric.text,
  )[(raccourcissement)])
  content(p(0, 1), anchor: "south-west", padding: 0.1, text(
    size: 9pt,
  )[Isométrique])

  // Équation de Hill (partie concentrique) ; la courbe ci-dessus en découle
  // avec a = k F_iso et b = k V_max.
  content(p(0.82, 1.5), box(
    fill: concentric.fill,
    stroke: 0.8pt + concentric.line,
    radius: 4pt,
    inset: 6pt,
    align(center, text(fill: concentric.text)[
      Équation de Hill\
      $(F + a)(v + b) = (F_"iso" + a) b$\
      #text(size: 8.5pt)[$a$, $b$ : constantes du muscle]
    ]),
  ))
})
