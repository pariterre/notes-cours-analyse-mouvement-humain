#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Muscle mono-articulaire (soléaire : croise la cheville) et bi-articulaire
// (gastrocnémien : croise le genou et la cheville), sur une jambe vue de
// côté (orteils vers la droite, face postérieure à gauche). Le corps
// musculaire est rouge, les tendons foncés ; les articulations croisées par
// le muscle sont mises en évidence.

#let muscle = palette.red
#let tendon = 1.8pt + palette.dark.fill
#let bone = 7pt + palette.neutral.line.lighten(35%)
#let crossed = palette.gold

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Squelette de la jambe (coordonnées locales d'un panneau)
  // Genou légèrement fléchi : en avant de la droite hanche-cheville
  let hip = (-0.15, 4.8)
  let knee = (0.25, 2.6)
  let ankle = (0.15, 0.55)
  let heel = (-0.3, 0.15)
  let toe = (1.4, 0.0)

  let add((ax, ay), (bx, by)) = (ax + bx, ay + by)
  let lerp((ax, ay), (bx, by), t) = (ax + t * (bx - ax), ay + t * (by - ay))
  // Point sur l'os [a, b] à la fraction t, décalé vers l'arrière (gauche)
  let behind(a, b, t, offset) = {
    let (dx, dy) = (b.at(0) - a.at(0), b.at(1) - a.at(1))
    let n = calc.sqrt(dx * dx + dy * dy)
    // normale postérieure : vers les x négatifs
    let (nx, ny) = if dy < 0 { (dy / n, -dx / n) } else { (-dy / n, dx / n) }
    add(lerp(a, b, t), (offset * nx, offset * ny))
  }

  // Corps musculaire en fuseau entre a et b, d'épaisseur maximale w
  let belly(a, b, w) = {
    let (dx, dy) = (b.at(0) - a.at(0), b.at(1) - a.at(1))
    let n = calc.sqrt(dx * dx + dy * dy)
    let (nx, ny) = (-dy / n, dx / n)
    let side(s) = range(0, 31).map(i => {
      let t = i / 30
      let e = s * w * calc.sin(t * 180deg)
      add(lerp(a, b, t), (e * nx, e * ny))
    })
    line(..side(1), ..side(-1).rev(), close: true, fill: muscle.fill, stroke: 0.8pt + muscle.line)
    // quelques fibres
    for k in (-0.5, 0, 0.5) {
      line(..side(k), stroke: 0.5pt + muscle.line)
    }
  }

  let panel(ox, kind, title, subtitle) = {
    group({
      translate((ox, 0))

      // Os
      line(hip, knee, stroke: bone)
      line(knee, ankle, stroke: bone)
      line(ankle, heel, toe, ankle, close: true, fill: palette.neutral.line.lighten(35%), stroke: (
        paint: palette.neutral.line.lighten(35%),
        thickness: 3pt,
        join: "round",
      ))

      // Muscle et tendons
      let (origin, a, b) = if kind == "mono" {
        // Soléaire : de la face postérieure du tibia au calcanéum
        (behind(knee, ankle, 0.12, 0.12), behind(knee, ankle, 0.22, 0.36), behind(knee, ankle, 0.7, 0.36))
      } else {
        // Gastrocnémien : des condyles fémoraux au calcanéum
        (behind(knee, hip, 0.14, 0.14), behind(knee, ankle, -0.02, 0.5), behind(knee, ankle, 0.55, 0.5))
      }
      line(origin, a, stroke: tendon)
      line(b, heel, stroke: tendon)
      belly(a, b, if kind == "mono" { 0.26 } else { 0.32 })

      // Articulations (celles croisées par le muscle en évidence)
      let crosses = if kind == "mono" { ("ankle",) } else { ("knee", "ankle") }
      for (name, p) in (("hip", hip), ("knee", knee), ("ankle", ankle)) {
        if name in crosses {
          circle(p, radius: 0.2, fill: crossed.fill, stroke: 1.4pt + crossed.line)
        } else {
          circle(p, radius: 0.14, fill: white, stroke: 1pt + palette.neutral.line)
        }
      }

      // Étiquettes muscle / tendon
      let label(target, y, body) = {
        let at = (-1.6, y)
        line((at.at(0) + 0.05, y), target, stroke: 0.6pt + palette.neutral.text)
        content(at, anchor: "east", padding: 0.08, text(size: 9pt, body))
      }
      label(lerp(a, b, 0.5), lerp(a, b, 0.5).at(1) + 0.15, text(fill: muscle.text)[Muscle])
      label(lerp(b, heel, 0.5), 0.75, [Tendon])

      content((0.2, -0.35), anchor: "north", text(weight: "semibold", title))
      content((0.2, -0.85), anchor: "north", text(size: 9pt, subtitle))
    })
  }

  panel(0, "mono", [Mono-articulaire], [Soléaire (cheville)])
  panel(5, "bi", [Bi-articulaire], [Gastrocnémien (genou et cheville)])

  // Légende
  let (lx, ly) = (1.4, -1.75)
  circle((lx, ly), radius: 0.2, fill: crossed.fill, stroke: 1.4pt + crossed.line)
  content((lx + 0.35, ly), anchor: "west", text(size: 9pt)[Articulation croisée par le muscle])
  circle((lx, ly - 0.55), radius: 0.14, fill: white, stroke: 1pt + palette.neutral.line)
  content((lx + 0.35, ly - 0.55), anchor: "west", text(size: 9pt)[Articulation non croisée])
})
