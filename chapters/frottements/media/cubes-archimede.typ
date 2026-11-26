#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Quatre cubes de même volume (0.001 m³, côté 10 cm) mais de masses
// volumiques différentes : 100, 500, 1000 et 1400 kg/m³.
// A : données (masse volumique, masse, poids).
// B : posés à la surface : chacun s'enfonce jusqu'à ce que la poussée
//     d'Archimède égale son poids (10 %, 50 %, 100 % immergé); le dernier
//     coule et le fond ajoute une réaction R = W − P_A.
// C : plongés au milieu de l'eau : la poussée est la même pour tous (9.81 N);
//     seul le poids change, d'où le mouvement (remonte, reste, coule).
// Couleurs : cubes de bois de plus en plus foncés avec la masse volumique;
// poids en gris, poussée d'Archimède en bleu (l'eau), réaction du fond en
// violet (comme les autres réactions).

#let densities = (100, 500, 1000, 1400)
#let g = 9.81
#let volume = 0.001
#let side = 1.0 // côté d'un cube (unités du canevas)
#let gap = 1.9 // écart entre les colonnes
#let depth = 3.0 // profondeur de l'eau
#let force-scale = 0.09 // unités du canevas par newton
#let wood(rho) = {
  let t = 100% * (rho - 100) / 1300
  color.mix((rgb("#f6e3bd"), 100% - t), (rgb("#6b4220"), t))
}
#let reaction = rgb("#7b1fa2")

#let fixed(x, n) = {
  let s = str(calc.round(x, digits: n))
  let parts = s.split(".")
  let decimals = if parts.len() > 1 { parts.at(1) } else { "" }
  parts.at(0) + if n > 0 { "." + decimals + "0" * (n - decimals.len()) } else { "" }
}

#let x-of(i) = i * gap

/// Cube vu de face, en légère perspective
#let cube(center, rho, label: none) = {
  import cetz.draw: *
  let (x, y) = center
  let h = side / 2
  let d = 0.22
  let base = wood(rho)
  line((x - h, y + h), (x - h + d, y + h + d), (x + h + d, y + h + d), (x + h, y + h), close: true, fill: base.lighten(25%), stroke: 0.8pt + base.darken(40%))
  line((x + h, y + h), (x + h + d, y + h + d), (x + h + d, y - h + d), (x + h, y - h), close: true, fill: base.darken(15%), stroke: 0.8pt + base.darken(40%))
  rect((x - h, y - h), (x + h, y + h), fill: base, stroke: 0.8pt + base.darken(40%))
  if label != none {
    content(center, text(size: 10pt, weight: "bold", fill: if rho > 700 { white } else { base.darken(70%) }, label))
  }
}

#let force(from, newtons, paint, dir: 1) = {
  import cetz.draw: *
  let to = (from.at(0), from.at(1) + dir * newtons * force-scale)
  line(from, to, stroke: 1.6pt + paint, mark: (end: "stealth", fill: paint, stroke: paint, scale: 0.6))
}

#let tank(origin) = {
  import cetz.draw: *
  let (x0, y0) = origin
  let (left, right) = (x0 - 1.0, x0 + x-of(3) + 1.2)
  rect((left, y0 - depth), (right, y0), fill: palette.blue.fill.lighten(30%), stroke: none)
  line((left, y0), (right, y0), stroke: 1.2pt + palette.blue.line)
  line((left, y0 - depth), (right, y0 - depth), stroke: 1pt + palette.neutral.text)
  // Fond (bande hachurée : les flèches du cube posé au fond la traversent)
  rect((left, y0 - depth - 0.7), (right, y0 - depth), stroke: none, fill: tiling(size: (5pt, 5pt), place(std.line(start: (0pt, 5pt), end: (5pt, 0pt), stroke: 0.5pt + palette.neutral.text.transparentize(55%)))))
}

#let panel-title(at, letter, body) = cetz.draw.content(at, anchor: "south-west", text(size: 11pt, fill: palette.neutral.text)[*#letter* #h(4pt) #body])

#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *
  let ink = palette.neutral.text
  let weight-paint = palette.neutral.line
  let push-paint = palette.blue.line

  // A : données
  let y-a = 0
  panel-title((-4.2, y-a + 1.0), "A", [Quatre cubes de même volume (#qty[0.001][m^3])])
  let rows = (
    ([masse volumique $[#unit[kg/m^3]]$], none),
    ([masse $[#unit[kg]]$], rho => fixed(rho * volume, 1)),
    ([poids $[#unit[N]]$], rho => fixed(rho * volume * g, 2)),
  )
  let x-a = 3.0 // décalage pour laisser la place aux intitulés
  for (i, rho) in densities.enumerate() {
    cube((x-a + x-of(i), y-a), rho, label: str(rho))
  }
  for (j, (name, value)) in rows.slice(1).enumerate() {
    let y = y-a - 1.05 - j * 0.6
    content((x-a - 0.9, y), anchor: "east", text(size: 10pt, fill: ink, name))
    for (i, rho) in densities.enumerate() {
      content((x-a + x-of(i), y), text(size: 10pt, fill: ink, value(rho)))
    }
  }
  content((x-a - 0.9, y-a), anchor: "east", text(size: 10pt, fill: ink, rows.at(0).at(0)))

  // B : posés à la surface
  let b = (-4.2 + 1.0, -4.2)
  panel-title((b.at(0) - 1.0, b.at(1) + 1.25), "B", [Posés à la surface])
  tank(b)
  for (i, rho) in densities.enumerate() {
    let x = b.at(0) + x-of(i)
    let w = rho * volume * g
    // Fraction immergée à l'équilibre (au plus 1 : le dernier coule)
    let f = calc.min(rho / 1000, 1)
    let bottom = if rho > 1000 { b.at(1) - depth } else { b.at(1) - f * side }
    cube((x, bottom + side / 2), rho)
    let pa = calc.min(rho, 1000) * volume * g // ρ_eau V_I g
    force((x - 0.2, bottom + side / 2), w, weight-paint, dir: -1)
    // Poussée appliquée au centre du volume immergé
    force((x + 0.2, bottom + f * side / 2), pa, push-paint)
    if rho > 1000 {
      force((x + 0.38, bottom + 0.05), w - pa, reaction)
      content((x + side / 2 + 0.25, bottom + 0.2), anchor: "west", text(size: 10pt, fill: reaction)[$arrow(R)$])
    }
    let state = if rho < 1000 { [flotte] } else if rho == 1000 { [flotte, \ immergé] } else { [coule] }
    content((x + 0.1, b.at(1) - depth - 0.8), anchor: "north", text(size: 9.5pt, fill: ink, style: "italic", align(center, state)))
  }

  // C : plongés au milieu de l'eau
  let c = (b.at(0) + x-of(3) + 3.6, b.at(1))
  panel-title((c.at(0) - 1.0, c.at(1) + 1.25), "C", [Plongés dans l'eau])
  tank(c)
  for (i, rho) in densities.enumerate() {
    let x = c.at(0) + x-of(i)
    let y = c.at(1) - depth / 2
    let w = rho * volume * g
    cube((x, y), rho)
    force((x - 0.2, y), w, weight-paint, dir: -1)
    force((x + 0.2, y), volume * 1000 * g, push-paint)
    let state = if rho < 1000 { [↑ remonte] } else if rho == 1000 { [reste] } else { [↓ coule] }
    content((x + 0.1, c.at(1) - depth - 0.8), anchor: "north", text(size: 9.5pt, fill: ink, style: "italic", state))
  }

  // Légende
  let y-l = b.at(1) - depth - 2.2
  let item(x, paint, body) = {
    line((x, y-l), (x + 0.7, y-l), stroke: 1.6pt + paint, mark: (end: "stealth", fill: paint, stroke: paint, scale: 0.6))
    content((x + 0.85, y-l), anchor: "west", text(size: 10pt, fill: ink, body))
  }
  item(b.at(0) - 0.6, weight-paint, [poids $arrow(W)$])
  item(b.at(0) + 2.6, push-paint, [poussée d'Archimède $arrow(P)_A$])
  item(b.at(0) + 8.2, reaction, [réaction du fond $arrow(R)$])
})
