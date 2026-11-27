#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Soulever une charge : technique « stoop » (genoux tendus, tronc fléchi) et
// « squat » (genoux fléchis, tronc redressé, charge proche du corps).
//
// Pour chaque technique :
//   - bras de levier d de la charge par rapport au rachis lombaire (L5/S1) ;
//   - loupe sur deux vertèbres lombaires et leur disque, perpendiculaire à
//     l'axe du tronc. Le poids W (charge et haut du corps) est le même pour
//     les deux techniques et vertical ; on le décompose au centre du disque :
//     compression (perpendiculaire au disque, W cos θ) et cisaillement
//     (parallèle au disque, vers l'avant, W sin θ), θ étant l'inclinaison du
//     tronc. Plus le tronc est fléchi, plus le cisaillement domine.
//
// Non représentée : la force des muscles érecteurs du rachis, qui ajoute une
// forte compression selon l'axe du rachis, proportionnelle au moment de la
// charge (donc au bras de levier d).

#let compression = palette.green
#let shear = palette.red // le cisaillement est la contrainte dangereuse
#let load = palette.gold
#let lever = palette.blue
#let bone = palette.neutral
#let body-color = rgb("#5c6bc0").lighten(25%)
#let size = 6

// Étiquette lisible par-dessus le dessin (fond blanc)
#let tag(body, paint: black) = box(fill: white.transparentize(10%), inset: 2pt, radius: 2pt, text(
  size: 12pt,
  weight: "bold",
  fill: paint,
  body,
))

#let add((ax, ay), (bx, by)) = (ax + bx, ay + by)
#let sub((ax, ay), (bx, by)) = (ax - bx, ay - by)
#let mul((ax, ay), k) = (ax * k, ay * k)
#let norm((ax, ay)) = calc.sqrt(ax * ax + ay * ay)
#let unit(v) = mul(v, 1 / norm(v))
#let dot((ax, ay), (bx, by)) = ax * bx + ay * by

// Le tronc s'incline avec le bassin (`global.pitch`) ; les hanches fléchissent
// d'autant pour ramener les jambes. Les angles `lean` (inclinaison du tronc)
// et `leg` (flexion de la cuisse par rapport à la verticale) sont donc ceux
// vus à l'écran. Pieds à plat : cheville = genou - `leg`.
#let pose(lean, leg, knee, head: -20deg) = (
  global: (pitch: lean),
  head: head,
  shoulder-r: lean, // bras pendants, verticaux
  shoulder-l: lean,
  hip-r: lean + leg,
  hip-l: lean + leg,
  knee-r: knee,
  knee-l: knee,
  ankle-r: knee - leg,
  ankle-l: knee - leg,
)

#let techniques = (
  stoop: (
    title: [Technique « stoop »],
    subtitle: [genoux tendus, tronc fléchi],
    pose: pose(75deg, 0deg, 5deg),
  ),
  squat: (
    title: [Technique « squat »],
    subtitle: [genoux fléchis, tronc redressé, charge proche],
    // Centre de masse (corps et charge) au-dessus des pieds, à environ un
    // tiers de la longueur du pied depuis le talon ; caisse à la même
    // hauteur que pour la technique « stoop »
    pose: pose(38deg, 60deg, 85deg),
  ),
)

// Géométrie d'une technique, à l'écran (x antérieur, y vers le haut), le
// talon au sol en x = x0
#let geometry(technique, x0) = {
  let p = mannequin-points(pose: technique.pose, size: size)
  let flat(q) = (q.at(0), q.at(2))
  let ground = calc.min(p.heel-r.at(2), p.toe-r.at(2))
  let shift = (x0 - p.heel-r.at(0), -ground)
  let at(q) = add(flat(q), shift)

  let pelvis = at(p.pelvis)
  let axis = unit(sub(at(p.neck), pelvis)) // axe du tronc (vers le haut)
  let l5 = add(pelvis, mul(axis, 0.03 * size)) // L5/S1, juste au-dessus du bassin

  // Charge : une caisse tenue sous les mains
  let hand = mul(add(at(p.hand-r), at(p.wrist-r)), 0.5)
  let box-size = (0.2 * size, 0.13 * size)
  (
    shift: shift,
    l5: l5,
    axis: axis,
    box-center: sub(hand, (0, box-size.at(1) / 2 - 0.02 * size)),
    box-size: box-size,
  )
}

// Vertèbre lombaire vue de profil, dans un repère local (avant = +u,
// haut = +v) : corps vertébral (u de 0 à 1, v de 0 à 0.55) aux coins arrondis
// et arc postérieur (pédicule, processus articulaires, apophyse épineuse).
#let vertebra-body = {
  let r = 0.08
  let corner((cx, cy), from) = range(0, 5).map(i => {
    let t = from + i * 90deg / 4
    (cx + r * calc.cos(t), cy + r * calc.sin(t))
  })
  (
    ..corner((1 - r, r), -90deg),
    (0.97, 0.27), // taille antérieure
    ..corner((1 - r, 0.55 - r), 0deg),
    ..corner((r, 0.55 - r), 90deg),
    ..corner((r, r), 180deg),
  )
}
#let vertebra-arch = (
  (0.02, 0.47), // pédicule
  (-0.18, 0.48),
  (-0.2, 0.62),
  (-0.26, 0.75), // processus articulaire supérieur
  (-0.36, 0.71),
  (-0.38, 0.52),
  (-0.52, 0.46), // lame
  (-0.92, 0.44), // apophyse épineuse
  (-1.0, 0.38),
  (-1.0, 0.18),
  (-0.92, 0.12),
  (-0.58, 0.14),
  (-0.47, 0.02),
  (-0.44, -0.15), // processus articulaire inférieur
  (-0.34, -0.13),
  (-0.31, 0.08),
  (-0.16, 0.16), // échancrure du pédicule
  (0.02, 0.18),
)

#let x-stoop = 0
#let x-squat = 7.6

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // Sol
  line((-1.5, 0), (x-squat + 3.4, 0), stroke: 1pt + palette.neutral.line)

  // Une vertèbre dans le repère (origine o, avant f, haut u), à l'échelle k
  let vertebra(o, f, u, k) = {
    let at((a, b)) = add(o, add(mul(f, a * k), mul(u, b * k)))
    let outline = (paint: bone.text, thickness: 1pt, join: "round")
    line(..vertebra-arch.map(at), close: true, fill: bone.fill, stroke: outline)
    line(..vertebra-body.map(at), close: true, fill: bone.fill, stroke: outline)
  }

  let panel(t, x0, inset-offset, title-x) = {
    let g = geometry(t, x0)
    mannequin(size: size, origin: g.shift, view: (azimuth: -90deg), pose: t.pose, color: body-color)

    // Caisse
    let (bw, bh) = g.box-size
    let c = g.box-center
    rect(sub(c, (bw / 2, bh / 2)), add(c, (bw / 2, bh / 2)), fill: load.fill, stroke: 1.2pt + load.line, radius: 2pt)

    // Bras de levier de la charge par rapport à L5/S1
    let l5 = g.l5
    line(l5, (c.at(0), l5.at(1)), stroke: 2pt + lever.line)
    line((c.at(0), l5.at(1)), c, stroke: (paint: lever.line, thickness: 0.7pt, dash: "dashed"))
    content(((l5.at(0) + c.at(0)) / 2, l5.at(1)), anchor: "south", padding: 0.1, tag(paint: lever.text)[$d$])

    // Loupe sur deux vertèbres lombaires
    let r-spot = 0.3
    let r-inset = 2.2
    let center = add(l5, inset-offset)
    let w = unit(sub(center, l5))
    circle(l5, radius: r-spot, stroke: 1pt + palette.neutral.text)
    line(add(l5, mul(w, r-spot)), sub(center, mul(w, r-inset)), stroke: 0.8pt + palette.neutral.text)
    circle(center, radius: r-inset, fill: white, stroke: 1.2pt + palette.neutral.text)
    circle(l5, radius: 0.06, fill: white, stroke: 1.2pt + palette.dark.fill)

    // Deux vertèbres parallèles, perpendiculaires à l'axe du tronc, centrées
    // sur le disque
    let k = 0.85
    let disc = 0.2
    let up = g.axis
    let front = (up.at(1), -up.at(0))
    let o-low = sub(center, add(mul(front, 0.5 * k), mul(up, (0.55 + disc / 2) * k)))
    let o-high = add(o-low, mul(up, (0.55 + disc) * k))
    let at-low((p, q)) = add(o-low, add(mul(front, p * k), mul(up, q * k)))
    let at-high((p, q)) = add(o-high, add(mul(front, p * k), mul(up, q * k)))
    line(at-low((0.08, 0.55)), at-low((0.92, 0.55)), at-high((0.92, 0)), at-high((0.08, 0)), close: true, fill: palette.gold.fill.darken(5%), stroke: 0.8pt + bone.text)
    vertebra(o-low, front, up, k)
    vertebra(o-high, front, up, k)

    // Poids W⃗ au centre du disque, décomposé selon le plan du disque
    let origin = center
    let weight = (0, -1.7) // même poids pour les deux techniques
    let w-n = mul(up, dot(weight, up))
    let w-t = mul(front, dot(weight, front))
    let tip(v) = add(origin, v)
    let thin = (paint: palette.neutral.text, thickness: 0.8pt, dash: "dashed")
    line(tip(w-n), tip(weight), stroke: thin)
    line(tip(w-t), tip(weight), stroke: thin)
    let force-arrow(v, paint, thickness) = line(origin, tip(v), stroke: thickness + paint, mark: (
      end: "stealth",
      fill: paint,
      scale: 1.2,
    ))
    force-arrow(weight, palette.dark.fill, 2.4pt)
    force-arrow(w-n, compression.line, 4pt)
    force-arrow(w-t, shear.line, 4pt)
    circle(origin, radius: 0.08, fill: palette.dark.fill, stroke: none)

    content(tip(weight), anchor: "north", padding: 0.06, tag[$arrow(W)$])

    content((x0 + title-x, -0.35), anchor: "north", text(weight: "semibold", t.title))
    content((x0 + title-x, -0.85), anchor: "north", text(size: 9pt, t.subtitle))
  }

  panel(techniques.stoop, x-stoop, (0.9, 3.7), 1.3)
  panel(techniques.squat, x-squat, (-0.6, 4.4), 0.2)

  // Légende (deux lignes)
  let item(x, y, stroke, mark, body) = {
    line((x, y), (x + 0.7, y), stroke: stroke, mark: mark)
    content((x + 0.85, y), anchor: "west", text(size: 9pt, body))
  }
  let (x1, x2, y1, y2) = (-1.0, 5.6, -1.7, -2.2)
  item(x1, y1, 2.4pt + palette.dark.fill, (end: "stealth", fill: palette.dark.fill), [Poids $arrow(W)$ (charge et haut du corps)])
  item(x2, y1, 2pt + lever.line, none, [Bras de levier $d$ (L5/S1)])
  item(x1, y2, 4pt + compression.line, (end: "stealth", fill: compression.line), [Compression (perpendiculaire au disque)])
  item(x2, y2, 4pt + shear.line, (end: "stealth", fill: shear.line), [Cisaillement (parallèle au disque)])
})
