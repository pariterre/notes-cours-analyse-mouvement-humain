#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Point M dans un repère cartésien OXYZ : OM = x X + y Y + z Z.
// Même projection orthographique que la figure du sens direct
// (repere-sens-direct.typ) pour que les repères se ressemblent.

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

// Coordonnées du point M
#let (mx, my, mz) = (1.7, 3.3, 2.7)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let axis-len = 4.4
  let unit-len = 1.3
  let ink = palette.neutral.text
  let shades = (x: palette.red, y: palette.green, z: palette.blue)
  let units = (x: (1, 0, 0), y: (0, 1, 0), z: (0, 0, 1))
  let names = (x: $arrow(X)$, y: $arrow(Y)$, z: $arrow(Z)$)
  let label-anchors = (x: "south-east", y: "south", z: "east")

  let o = proj((0, 0, 0))
  let m = (mx, my, mz)
  let m-floor = (mx, my, 0)

  let guide(from, to, paint) = line(
    proj(from),
    proj(to),
    stroke: (paint: paint, thickness: 0.9pt, dash: "dashed"),
  )

  // Axes (fins) et vecteurs unitaires (épais)
  for axis in ("x", "y", "z") {
    let shade = shades.at(axis)
    let u = units.at(axis)
    line(o, proj(u.map(c => c * axis-len)), stroke: (paint: shade.line.transparentize(40%), thickness: 0.8pt))
    let tip = proj(u.map(c => c * unit-len))
    line(
      o,
      tip,
      stroke: (paint: shade.line, thickness: 2.2pt, cap: "round"),
      mark: (end: "stealth", fill: shade.line, stroke: shade.line, scale: 1.3),
    )
    content(tip, anchor: label-anchors.at(axis), padding: 0.12, text(
      size: 11pt,
      fill: shade.text,
      names.at(axis),
    ))
  }

  // Projections de M sur le plan horizontal puis sur chaque axe
  guide(m, m-floor, ink)
  guide(m-floor, (mx, 0, 0), shades.x.line)
  guide(m-floor, (0, my, 0), shades.y.line)
  guide(m, (0, 0, mz), shades.z.line)

  // Composantes sur les axes
  let component(p, label, anchor, shade) = {
    circle(proj(p), radius: 0.05, fill: shade.line, stroke: none)
    content(proj(p), anchor: anchor, padding: 0.15, text(size: 11pt, fill: shade.text, label))
  }
  component((mx, 0, 0), $x$, "north-east", shades.x)
  component((0, my, 0), $y$, "north", shades.y)
  component((0, 0, mz), $z$, "east", shades.z)

  // Vecteur OM
  line(
    o,
    proj(m),
    stroke: (paint: palette.dark.line, thickness: 2.4pt),
    mark: (end: "stealth", fill: palette.dark.line, stroke: palette.dark.line, scale: 1.5),
  )
  content(proj(m), anchor: "south-west", padding: 0.1, text(size: 12pt, weight: "bold")[M])
  content(o, anchor: "south-east", padding: 0.15, text(size: 11pt, fill: ink)[O])
})
