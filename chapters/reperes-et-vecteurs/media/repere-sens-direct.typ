#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Repère cartésien direct : pour chaque axe, une rotation positive d'un
// quart de tour amène l'axe suivant sur le troisième (x : y → z,
// y : z → x, z : x → y).

// Projection orthographique : on regarde le repère depuis la direction
// `viewer` (x vers l'observateur, y à droite, z vers le haut). Les cercles
// deviennent de vraies ellipses, ce qui rend les rotations lisibles.
#let normalize(v) = {
  let n = calc.sqrt(v.map(c => c * c).sum())
  v.map(c => c / n)
}
#let dot(a, b) = a.zip(b).map(((u, v)) => u * v).sum()
#let cross((a1, a2, a3), (b1, b2, b3)) = (
  a2 * b3 - a3 * b2,
  a3 * b1 - a1 * b3,
  a1 * b2 - a2 * b1,
)
#let viewer = normalize((1, 0.75, 0.45))
#let screen-right = normalize(cross((0, 0, 1), viewer))
#let screen-up = cross(viewer, screen-right)
#let proj(p) = (dot(p, screen-right), dot(p, screen-up))
// Profondeur : plus grand = plus près de l'observateur
#let depth(p) = dot(p, viewer)

#let unit = (
  x: (1, 0, 0),
  y: (0, 1, 0),
  z: (0, 0, 1),
)
#let add(a, b) = a.zip(b).map(((u, v)) => u + v)
#let mul(k, a) = a.map(u => k * u)

// Points d'un arc de cercle 3D de centre c, dans le plan (u, v), tournant
// de u vers v (sens positif autour de u × v).
#let arc3d(c, u, v, r, from, to, steps: 48) = range(steps + 1).map(i => {
  let t = from + (to - from) * i / steps
  add(c, add(mul(r * calc.cos(t), u), mul(r * calc.sin(t), v)))
})

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let axis-len = 2.4
  let shades = (x: palette.red, y: palette.green, z: palette.blue)
  let turn = palette.gold
  let ink = palette.neutral.text

  // (axe de rotation, axe de départ, axe d'arrivée)
  let panels = (("x", "y", "z"), ("y", "z", "x"), ("z", "x", "y"))

  for (i, (axis, from, to)) in panels.enumerate() {
    let shift = (i * 4.4, 0)
    let at(p) = add(proj(p), shift)

    let draw-axes() = {
      for name in ("x", "y", "z") {
        let shade = shades.at(name)
        line(
          at((0, 0, 0)),
          at(mul(axis-len, unit.at(name))),
          stroke: (paint: shade.line, thickness: 1.6pt, cap: "round"),
          mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.4),
        )
        let label-pos = mul(axis-len + 0.3, unit.at(name))
        content(at(label-pos), text(size: 11pt, fill: shade.text, eval(name, mode: "math")))
      }
      content(add(at((0, 0, 0)), (0.05, -0.1)), anchor: "north-west", text(
        size: 10pt,
        fill: ink,
      )[O])
    }

    // Quart de tour de l'axe de départ vers l'axe d'arrivée (fin, pointillé)
    let quarter = arc3d(
      (0, 0, 0),
      unit.at(from),
      unit.at(to),
      0.72 * axis-len,
      12deg,
      78deg,
    ).map(at)
    line(
      ..quarter,
      stroke: (paint: turn.line, thickness: 1pt, dash: "dashed"),
      mark: (end: "stealth", fill: turn.line, stroke: turn.line, scale: 1.1),
    )

    // Anneau de rotation autour de l'axe, coupé en parties avant/arrière
    let center = mul(0.55 * axis-len, unit.at(axis))
    // L'anneau se termine juste après son point le plus proche de
    // l'observateur : la pointe est devant l'axe et indique clairement le sens.
    let t-front = calc.atan2(dot(viewer, unit.at(from)), dot(viewer, unit.at(to)))
    let t-end = t-front + 35deg
    let ring = arc3d(center, unit.at(from), unit.at(to), 0.42, t-end - 290deg, t-end, steps: 72)
    let c-depth = depth(center)
    let ring-stroke = (paint: turn.line, thickness: 2.2pt, cap: "round")

    // Découpe en segments consécutifs de même côté
    let runs = ()
    let current = (ring.at(0),)
    let front = depth(ring.at(0)) > c-depth
    for p in ring.slice(1) {
      let f = depth(p) > c-depth
      current.push(p)
      if f != front {
        runs.push((front: front, points: current))
        current = (p,)
        front = f
      }
    }
    runs.push((front: front, points: current))

    let draw-runs(want-front) = {
      for (k, run) in runs.enumerate() {
        if run.front == want-front and run.points.len() > 1 {
          line(..run.points.map(at), stroke: ring-stroke)
        }
      }
    }

    // Pointe de flèche posée à la fin de l'anneau, orientée selon la
    // tangente exacte du cercle (sens positif de rotation)
    let ring-head() = {
      let tangent3d = add(
        mul(-calc.sin(t-end), unit.at(from)),
        mul(calc.cos(t-end), unit.at(to)),
      )
      let (dx, dy) = proj(tangent3d)
      let n = calc.sqrt(dx * dx + dy * dy)
      let (dx, dy) = (dx / n, dy / n)
      let base = at(ring.last())
      let (head-len, head-half) = (0.32, 0.15)
      let tip = add(base, (dx * head-len, dy * head-len))
      let back = add(base, (-dx * 0.06, -dy * 0.06))
      line(
        tip,
        add(back, (-dy * head-half, dx * head-half)),
        add(base, (dx * 0.05, dy * 0.05)),
        add(back, (dy * head-half, -dx * head-half)),
        close: true,
        fill: turn.line,
        stroke: (paint: turn.line, thickness: 0.6pt, join: "round"),
      )
    }

    draw-runs(false)
    draw-axes()
    draw-runs(true)
    ring-head()

    // Légende sous chaque repère
    content(
      (
        (at(mul(axis-len, unit.x)).at(0) + at(mul(axis-len, unit.y)).at(0)) / 2,
        at(mul(axis-len, unit.x)).at(1) - 0.75,
      ),
      text(size: 9pt, fill: ink)[autour de #eval(axis, mode: "math") :
        #eval(from, mode: "math") #sym.arrow #eval(to, mode: "math")],
    )
  }
})
