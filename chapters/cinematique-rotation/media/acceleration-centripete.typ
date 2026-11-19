#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Accélération centripète à vitesse angulaire constante, en deux étapes :
//   1. les vitesses en k - 1 et k + 1 sont tangentes au cercle, de même
//      norme, et font entre elles l'angle Δθ balayé par le rayon;
//   2. ramenées au point k, leur différence Δv pointe vers le centre :
//      l'accélération a_R = Δv / Δt est centripète.

#let (theta-before, theta-k, theta-after) = (-25deg, 15deg, 55deg)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let r = 2.2
  let v-len = 1.7
  let polar(radius, a) = (radius * calc.cos(a), radius * calc.sin(a))
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let arc(c, radius, from, to, n: 30) = range(0, n + 1).map(i => add(c, polar(radius, from + (to - from) * i / n)))
  let vec-stroke(shade) = (
    stroke: 2.6pt + shade.line,
    mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.2),
  )
  let guide = (paint: ink.transparentize(45%), thickness: 0.7pt, dash: "dashed")
  let v-label(k) = $arrow(v)_(#k)$

  // Cercle, centre et sens de rotation (sens direct)
  let base(c) = {
    circle(c, radius: r, stroke: 1.2pt + ink.transparentize(35%))
    circle(c, radius: 0.06, fill: ink, stroke: none)
    let r-omega = r + 0.3
    line(..arc(c, r-omega, -80deg, -48deg), stroke: (paint: ink, thickness: 1.6pt, cap: "round"))
    let tip = add(c, polar(r-omega, -42deg))
    let back = add(c, polar(r-omega, -51deg))
    let side = polar(0.15, -51deg)
    line(tip, add(back, side), add(back, side.map(x => -x)), close: true, fill: ink, stroke: none)
    content(add(c, polar(r-omega, -64deg)), anchor: "north-west", padding: 0.1, text(size: 12pt, fill: ink)[$omega$])
  }
  let title(c, body) = content(add(c, (0, r + 1.9)), anchor: "south", text(size: 12pt, weight: "semibold", fill: ink, body))

  // ① Vitesses en k - 1 et k + 1
  let c1 = (0, 0)
  base(c1)
  title(c1)[① Vitesses en $k - 1$ et $k + 1$]
  line(c1, ..arc(c1, 0.8, theta-before, theta-after), close: true, fill: palette.gold.fill, stroke: none)
  content(add(c1, polar(1.1, theta-k)), text(size: 12pt, fill: palette.gold.text)[$Delta theta$])
  for (a, shade, k, anchor) in (
    (theta-before, palette.red, $k - 1$, "west"),
    (theta-after, palette.green, $k + 1$, "south-east"),
  ) {
    let p = add(c1, polar(r, a))
    line(c1, p, stroke: guide)
    line(p, add(p, polar(v-len, a + 90deg)), ..vec-stroke(shade))
    content(add(p, polar(v-len, a + 90deg)), anchor: anchor, padding: 0.12, text(size: 12pt, fill: shade.text, v-label(k)))
    circle(p, radius: 0.08, fill: shade.line, stroke: 1pt + white)
  }
  let pk = add(c1, polar(r, theta-k))
  circle(pk, radius: 0.08, fill: ink, stroke: 1pt + white)
  content(pk, anchor: "east", padding: 0.15, text(size: 12pt, fill: ink)[$k$])

  // ② Les deux vitesses ramenées au point k
  let c2 = (6.5, 0)
  base(c2)
  title(c2)[② Ramenées au point $k$]
  let pk = add(c2, polar(r, theta-k))

  // Rappel de ① en estompé : les vitesses d'origine en k - 1 et k + 1,
  // reliées par des pointillés à leurs copies déplacées en k
  for (a, shade, k, anchor) in (
    (theta-before, palette.red, $k - 1$, "west"),
    (theta-after, palette.green, $k + 1$, "south-east"),
  ) {
    let p = add(c2, polar(r, a))
    let faded = shade.line.transparentize(60%)
    let tip = add(p, polar(v-len, a + 90deg))
    line(c2, p, stroke: guide)
    line(p, tip, stroke: 2.2pt + faded, mark: (end: "stealth", fill: faded, stroke: faded, scale: 1.1))
    let moved = (paint: faded, thickness: 0.8pt, dash: "dotted")
    line(p, pk, stroke: moved)
    line(tip, add(pk, polar(v-len, a + 90deg)), stroke: moved)
    circle(p, radius: 0.07, fill: shade.line, stroke: 1pt + white)
    // Étiquette au bout du vecteur d'origine : le point lui-même est trop chargé
    content(tip, anchor: anchor, padding: 0.1, text(size: 11pt, fill: shade.text.transparentize(40%), v-label(k)))
  }

  line(c2, pk, stroke: guide)
  let tip-before = add(pk, polar(v-len, theta-before + 90deg))
  let tip-after = add(pk, polar(v-len, theta-after + 90deg))

  // Angle Δθ entre les deux vitesses
  line(pk, ..arc(pk, 0.65, theta-before + 90deg, theta-after + 90deg), close: true, fill: palette.gold.fill, stroke: none)
  content(add(pk, polar(0.95, theta-k + 90deg)), text(size: 11pt, fill: palette.gold.text)[$Delta theta$])

  line(pk, tip-before, ..vec-stroke(palette.red))
  line(pk, tip-after, ..vec-stroke(palette.green))
  content(tip-before, anchor: "west", padding: 0.12, text(size: 12pt, fill: palette.red.text, v-label($k - 1$)))
  // au milieu du vecteur, côté intérieur : sa pointe tombe sur le cercle
  content(((pk.at(0) + tip-after.at(0)) / 2, (pk.at(1) + tip-after.at(1)) / 2), anchor: "north-east", padding: 0.1, text(size: 12pt, fill: palette.green.text, v-label($k + 1$)))

  // Δv : de la pointe de v_(k-1) à celle de v_(k+1)
  line(tip-before, tip-after, stroke: 2.2pt + palette.dark.line, mark: (
    end: "stealth",
    fill: palette.dark.line,
    stroke: palette.dark.line,
    scale: 1.1,
  ))
  content(
    ((tip-before.at(0) + tip-after.at(0)) / 2, (tip-before.at(1) + tip-after.at(1)) / 2),
    anchor: "south",
    padding: 0.15,
    text(size: 12pt)[$Delta arrow(v)$],
  )

  // Accélération centripète, même direction que Δv, vers le centre
  let dv = (tip-after.at(0) - tip-before.at(0), tip-after.at(1) - tip-before.at(1))
  line(pk, add(pk, dv), ..vec-stroke(palette.blue))
  content(add(pk, dv), anchor: "north-east", padding: 0.1, text(
    size: 12pt,
    fill: palette.blue.text,
  )[$arrow(a)_R = display((Delta arrow(v)) / (Delta t))$])
  circle(pk, radius: 0.08, fill: ink, stroke: 1pt + white)
  content(pk, anchor: "north-west", padding: 0.12, text(size: 12pt, fill: ink)[$k$])
})
