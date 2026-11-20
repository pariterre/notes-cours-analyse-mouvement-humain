#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Aire sous une courbe de force et ses approximations :
// A) aire exacte (l'impulsion), B) rectangles (hauteur F_k),
// C) trapèzes (moyenne de F_k et F_(k+1)).
// Les panneaux B et C utilisent les mêmes échantillons.

#let exact = palette.gold
#let rectangle = palette.blue
#let trapeze = palette.green

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let (duration, height) = (6, 2.6) // taille de la courbe (unités du dessin)
  let n = 8 // nombre d'intervalles
  // Intervalle détaillé (k), sur le flanc montant : F_k et F_(k+1) diffèrent
  // nettement, le rectangle sous-estime l'aire et le trapèze suit la courbe.
  let highlight = 1
  let dt = duration / n
  let gap = 2.4 // espace entre les panneaux

  // Force de réaction typique d'un appui : deux pics séparés par un creux
  let force(t) = {
    let u = t / duration
    height / 1.56 * calc.sin(u * 180deg) * (1 + 1.2 * calc.pow(calc.sin(u * 360deg), 2))
  }
  let samples = range(n + 1).map(k => (k * dt, force(k * dt)))

  let panel((x0, y0), kind, title) = {
    let shade = (exact: exact, rectangle: rectangle, trapeze: trapeze).at(kind)
    let at((t, f)) = (x0 + t, y0 + f)
    let curve = range(0, 101).map(i => at((i / 100 * duration, force(i / 100 * duration))))
    let tk = samples.at(highlight).at(0)
    let (fk, fk1) = (samples.at(highlight).at(1), samples.at(highlight + 1).at(1))

    if kind == "exact" {
      // Aire exacte sous la courbe
      line(at((0, 0)), ..curve, at((duration, 0)), close: true, fill: shade.fill, stroke: none)
      content(at((duration / 2, height * 0.38)), text(fill: shade.text, weight: "semibold")[
        Aire = impulsion
      ])
    } else {
      // Aires élémentaires
      for k in range(n) {
        let (t0, f0) = samples.at(k)
        let (t1, f1) = samples.at(k + 1)
        let top = if kind == "rectangle" { (f0, f0) } else { (f0, f1) }
        let strong = k == highlight
        line(
          at((t0, 0)),
          at((t0, top.at(0))),
          at((t1, top.at(1))),
          at((t1, 0)),
          close: true,
          fill: if strong { shade.line.lighten(45%) } else { shade.fill },
          stroke: (if strong { 1.2pt } else { 0.6pt }) + shade.line,
        )
      }
    }

    // Courbe de force (et échantillons pour les approximations)
    line(..curve, stroke: 1.6pt + palette.neutral.text)
    if kind != "exact" {
      for s in samples {
        circle(at(s), radius: 0.05, fill: palette.neutral.text, stroke: none)
      }
    }

    // Axes
    let axis(to) = line(at((0, 0)), at(to), stroke: 1.2pt + black, mark: (
      end: "stealth",
      fill: black,
    ))
    axis((duration + 0.7, 0))
    axis((0, height + 0.7))
    content(at((duration + 0.7, 0)), anchor: "north-east", padding: 0.12)[Temps $[#unit[s]]$]
    content(at((0, height + 0.7)), anchor: "south", padding: 0.1)[Force $[#unit[N]]$]

    if kind != "exact" {
      // Détail de l'intervalle k
      let guide = (paint: shade.line, thickness: 0.7pt, dash: "dashed")
      line(at((0, fk)), at((tk, fk)), stroke: guide)
      content(at((0, fk)), anchor: "east", padding: 0.1, text(fill: shade.text)[$F_k$])
      if kind == "trapeze" {
        line(at((0, fk1)), at((tk + dt, fk1)), stroke: guide)
        content(at((0, fk1)), anchor: "east", padding: 0.1, text(fill: shade.text)[$F_(k+1)$])
      }
      content(at((tk, 0)), anchor: "north", padding: 0.1)[$t_k$]
      content(at((tk + dt, 0)), anchor: "north", padding: 0.1)[$t_(k+1)$]

      // Formule de l'aire élémentaire, reliée à l'intervalle
      let formula = if kind == "rectangle" {
        $A_k = F_k (t_(k+1) - t_k)$
      } else {
        $A_k = (F_k + F_(k+1)) / 2 (t_(k+1) - t_k)$
      }
      let label-pos = at((duration * 0.62, height + 0.45))
      line(label-pos, at((tk + dt / 2, fk / 2)), stroke: 0.7pt + shade.line, mark: (
        end: "stealth",
        fill: shade.line,
        scale: 0.6,
      ))
      content(label-pos, anchor: "south", padding: 0.05, text(fill: shade.text, formula))
    }

    content(at((duration / 2, -0.8)), anchor: "north", text(weight: "semibold", title))
  }

  // A) en haut, centré au-dessus de B) et C)
  let step = duration + gap
  let row = height + 3.1 // hauteur d'une rangée de panneaux
  panel((step / 2, row), "exact", [A) Aire sous la courbe])
  panel((0, 0), "rectangle", [B) Rectangles])
  panel((step, 0), "trapeze", [C) Trapèzes])
})
