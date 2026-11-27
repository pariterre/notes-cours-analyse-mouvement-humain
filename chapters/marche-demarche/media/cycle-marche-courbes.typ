#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Cycle de marche (d'une attaque du talon à la suivante, en % du cycle) :
// A. force de réaction antéropostérieure (freinage puis poussée; les deux
//    impulsions s'annulent à vitesse constante);
// B. force de réaction verticale (deux pics, au-dessus du poids, et un creux);
// C. angle de flexion du genou (petite flexion en appui, grande flexion en
//    oscillation).
// Les forces ne s'exercent que pendant l'appui (≈ 60 % du cycle).
// Courbes typiques d'un adulte à vitesse spontanée (allure générale).
// Couleurs : aire négative (freinage) en rouge, aire positive (poussée) en
// vert, comme pour le travail; courbes de force en gris, angle en bleu.

#let width = 11.0 // largeur des graphiques (100 % du cycle)
#let height = 2.4 // hauteur de chaque graphique
#let stance = 60 // fin de l'appui (% du cycle)

/// Courbe lisse (Catmull-Rom) passant par les points (x, y), échantillonnée
#let smooth(pts, n: 12) = {
  let out = ()
  for i in range(pts.len() - 1) {
    let p0 = pts.at(calc.max(i - 1, 0))
    let (p1, p2) = (pts.at(i), pts.at(i + 1))
    let p3 = pts.at(calc.min(i + 2, pts.len() - 1))
    for k in range(n) {
      let t = k / n
      let (t2, t3) = (t * t, t * t * t)
      let f(a, b, c, d) = 0.5 * (2 * b + (-a + c) * t + (2 * a - 5 * b + 4 * c - d) * t2 + (-a + 3 * b - 3 * c + d) * t3)
      out.push((f(p0.at(0), p1.at(0), p2.at(0), p3.at(0)), f(p0.at(1), p1.at(1), p2.at(1), p3.at(1))))
    }
  }
  out.push(pts.last())
  out
}

// Données (% du cycle, valeur)
#let antero = smooth(((0, 0), (3, -0.9), (9, -2.0), (14, -1.9), (22, -1.0), (31, 0), (40, 0.8), (49, 2.0), (55, 1.4), (58, 0.4), (60, 0)))
#let vertical = smooth(((0, 0), (4, 6), (9, 10.5), (13, 11.3), (20, 9.6), (30, 7.6), (40, 9.0), (48, 11.1), (54, 9.2), (57, 4.5), (60, 0)))
#let knee = smooth(((0, 4), (6, 12), (15, 18), (26, 11), (40, 5), (50, 9), (60, 38), (66, 54), (72, 62), (79, 56), (87, 34), (94, 10), (100, 4)))

#cetz.canvas(length: 1cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let x-of(pct) = width * pct / 100

  /// Échelle verticale d'un graphique (origine `y0`, valeurs de `lo` à `hi`)
  let scale-of(y0, lo, hi) = v => y0 + height * (v - lo) / (hi - lo)
  /// Axes d'un graphique, avec graduations `ticks`
  let graph(y0, lo, hi, ticks, unit, letter, title) = {
    let y-of = scale-of(y0, lo, hi)
    // Axes
    line((0, y-of(lo)), (0, y-of(hi) + 0.25), stroke: 0.8pt + ink, mark: (end: "stealth", fill: ink, scale: 0.7))
    let zero = y-of(calc.max(lo, 0))
    line((0, zero), (width + 0.3, zero), stroke: 0.8pt + ink, mark: (end: "stealth", fill: ink, scale: 0.7))
    for v in ticks {
      line((-0.08, y-of(v)), (0.08, y-of(v)), stroke: 0.8pt + ink)
      content((-0.15, y-of(v)), anchor: "east", text(size: 9pt, fill: ink, str(v)))
    }
    content((-0.15, y-of(hi) + 0.25), anchor: "south-east", text(size: 9pt, fill: ink, unit))
    content((0.25, y-of(hi) + 0.25), anchor: "west", text(size: 10.5pt, fill: ink)[*#letter* #h(3pt) #title])
  }

  // Bandes appui / oscillation sur toute la hauteur
  let (top, bottom) = (3 * (height + 1.3) - 0.6, -0.5)
  rect((x-of(stance), bottom), (x-of(100), top), fill: palette.neutral.fill, stroke: none)
  line((x-of(stance), bottom), (x-of(stance), top), stroke: (paint: ink.transparentize(40%), thickness: 0.7pt, dash: "dashed"))
  content((x-of(stance / 2), top), anchor: "south", text(size: 10pt, weight: "semibold", fill: ink)[appui])
  content((x-of((100 + stance) / 2), top), anchor: "south", text(size: 10pt, weight: "semibold", fill: ink)[oscillation])

  // --- A : force antéropostérieure
  let y0 = 2 * (height + 1.3)
  graph(y0, -2.5, 2.5, (-2, 0, 2), [N/kg], "A", [Force antéropostérieure])
  let y-of = scale-of(y0, -2.5, 2.5)
  let pts = antero.map(((p, v)) => (x-of(p), y-of(v)))
  let zero = y-of(0)
  let neg = pts.filter(p => p.at(0) <= x-of(31))
  let pos = pts.filter(p => p.at(0) >= x-of(31) and p.at(0) <= x-of(stance))
  line((neg.first().at(0), zero), ..neg, (x-of(31), zero), close: true, fill: palette.red.fill, stroke: none)
  line((x-of(31), zero), ..pos, (x-of(stance), zero), close: true, fill: palette.green.fill, stroke: none)
  line(..pts, stroke: 1.8pt + palette.neutral.line)
  content((x-of(13), y-of(-1.0)), text(size: 9.5pt, fill: palette.red.text)[freinage])
  content((x-of(50), y-of(0.75)), text(size: 9.5pt, fill: palette.green.text)[poussée])

  // --- B : force verticale
  let y0 = height + 1.3
  graph(y0, 0, 12, (0, 10), [N/kg], "B", [Force verticale])
  let y-of = scale-of(y0, 0, 12)
  line((0, y-of(9.81)), (x-of(100), y-of(9.81)), stroke: (paint: ink.transparentize(30%), thickness: 0.8pt, dash: "dash-dotted"))
  content((x-of(100), y-of(9.81)), anchor: "south-east", padding: 0.05, text(size: 9.5pt, fill: ink, style: "italic")[poids])
  line(..vertical.map(((p, v)) => (x-of(p), y-of(v))), stroke: 1.8pt + palette.neutral.line)

  // --- C : flexion du genou
  graph(0, 0, 70, (0, 30, 60), [deg], "C", [Flexion du genou])
  let y-of = scale-of(0, 0, 70)
  line(..knee.map(((p, v)) => (x-of(p), y-of(v))), stroke: 1.8pt + palette.blue.line)

  // Axe du temps (commun)
  for pct in (0, 20, 40, 60, 80, 100) {
    line((x-of(pct), -0.08), (x-of(pct), 0.08), stroke: 0.8pt + ink)
    content((x-of(pct), -0.15), anchor: "north", text(size: 9pt, fill: ink, str(pct)))
  }
  content((x-of(50), -0.55), anchor: "north", text(size: 10pt, fill: ink)[temps (% du cycle de marche)])
})
