#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": (
  mannequin, mannequin-points, segment-data,
)
#import "squat-jump-poses.typ": squat-pose-at
#import "@preview/cetz:0.4.1"


// Construction graphique de la résultante cinétique pendant l'impulsion d'un
// squat jump, limitée à trois segments (tronc, cuisses, jambes) pour garder
// peu de vecteurs. Deux instants (t1, t2) suffisent : la vitesse de chaque
// centre de masse segmentaire est estimée par différence finie (son
// déplacement entre t1 et t2), puis multipliée par la masse du segment
// (de Leva). Les membres gauche et droit sont additionnés (ils se superposent
// de profil).

#let size = 4.2
#let view = (azimuth: -90deg)

// Les deux instants : début (t1) et fin (t2) de la phase d'impulsion, poses
// partagées avec le kinogramme
#let instants = (squat-pose-at(0), squat-pose-at(1))

// Place le mannequin pour que le talon reste au même endroit, au sol
#let _placed(pose) = {
  let p = mannequin-points(pose: pose, size: size)
  let heel = p.heel-r
  let origin = (-heel.at(0), -calc.min(heel.at(2), p.toe-r.at(2)))
  let screen(q) = (q.at(0) + origin.at(0), q.at(2) + origin.at(1))
  (pose: pose, origin: origin, points: p, screen: screen)
}
#let _frames = instants.map(_placed)

// Segments : (nom, couleur, [(masse relative, ancre)]) ; masses de de Leva
#let _data = segment-data.male
#let segments = (
  ([tronc], palette.red.line, ((_data.trunk.mass, "com-trunk"),)),
  (
    [cuisses],
    palette.green.line,
    ((_data.thigh.mass, "com-thigh-r"), (_data.thigh.mass, "com-thigh-l")),
  ),
  (
    [jambes],
    palette.blue.text,
    ((_data.shank.mass, "com-shank-r"), (_data.shank.mass, "com-shank-l")),
  ),
)

// Vitesse et quantité de mouvement de chaque segment
#let _add(a, b) = (a.at(0) + b.at(0), a.at(1) + b.at(1))
#let _scale(a, k) = (a.at(0) * k, a.at(1) * k)
#let _norm(a) = calc.sqrt(calc.pow(a.at(0), 2) + calc.pow(a.at(1), 2))
#let _raw = segments.map(((name, color, parts)) => {
  let (f1, f2) = _frames
  let mass = parts.map(((m, _)) => m).sum()
  let center(f) = parts.fold((0, 0), (acc, (m, key)) => _add(acc, _scale(
    (f.screen)(f.points.at(key)),
    m / mass,
  )))
  let (before, at) = (center(f1), center(f2))
  (
    name: name,
    color: color,
    mass: mass,
    before: before,
    at: at,
    d: _add(at, _scale(before, -1)),
  )
})

// Vecteurs dessinés : directions et longueurs EXAGÉRÉES pour la lisibilité
// (non à l'échelle). La direction est celle du déplacement réel, étirée
// horizontalement ; la longueur est comprimée pour que les petits segments
// restent visibles, en conservant l'ordre des grandeurs. La résultante est la
// somme exacte des vecteurs dessinés : la construction graphique reste valide.
#let stretch = 2
#let d-max = calc.max(.._raw.map(r => _norm(r.d)))
#let m-ref = _raw.at(1).mass // cuisses
#let momenta = _raw.map(r => {
  let dir = (r.d.at(0) * stretch, r.d.at(1))
  // Longueur minimale pour que les petits vecteurs restent lisibles
  let v = _scale(
    dir,
    1.5 * (0.45 + 0.55 * calc.sqrt(_norm(r.d) / d-max)) / _norm(dir),
  )
  (..r, v: v, p: _scale(v, 1.15 * calc.pow(r.mass / m-ref, 1 / 3)))
})
#let resultant = momenta.fold((0, 0), (acc, m) => _add(acc, m.p))

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let vector(from, p, color, width: 2pt) = line(
    from,
    _add(from, p),
    stroke: (
      paint: color,
      thickness: width,
      cap: "round",
    ),
    mark: (end: "stealth", fill: color, stroke: color, scale: 1),
  )

  let (f1, f2) = _frames
  // Panneaux côte à côte
  let origin-of(i) = (i * 4.5, 0)
  // Sol : juste un peu au-delà des pieds
  let ground(o) = {
    rect(
      _add(o, (-1.0, -0.2)),
      _add(o, (1.5, 0)),
      fill: palette.neutral.fill,
      stroke: none,
    )
    line(
      _add(o, (-1.0, 0)),
      _add(o, (1.5, 0)),
      stroke: 1pt + palette.neutral.line,
    )
  }
  let panel-label(o, body) = content(
    _add(o, (0.25, -0.4)),
    anchor: "north",
    align(center, text(weight: "semibold", body)),
  )
  let pose-at(o, color, name) = mannequin(
    size: size,
    origin: _add(f2.origin, o),
    view: view,
    pose: f2.pose,
    color: color,
    name: name,
  )
  // B et C montrent le même instant que t2 : même couleur que t2 en A
  let ghost-color = rgb("#5c6bc0")
  // Nom de chaque vecteur, au bout de sa flèche, du côté où elle pointe
  let names(o, values) = for (m, body) in momenta.zip(values) {
    let anchor = if m.p.at(0) < 0 { "east" } else { "west" }
    content(_add(o, _add(m.at, m.p)), anchor: anchor, padding: 0.12, text(
      size: 10pt,
      fill: m.color.darken(20%),
      body,
    ))
  }
  // Centre de masse : anneau noir bien visible sur le mannequin estompé
  let mark-g(g) = {
    circle(g, radius: 0.15, fill: white, stroke: 2pt + black)
    circle(g, radius: 0.05, fill: black, stroke: none)
    content(g, anchor: "east", padding: 0.28, text(
      size: 13pt,
      weight: "bold",
    )[$bold(G)$])
  }

  // ---- A) Quantité de mouvement des segments ----
  // Le déplacement du centre de masse entre t1 (cercle vide) et t2 (point
  // plein) donne la direction de la vitesse, donc de m v.
  let o = origin-of(0)
  ground(o)
  mannequin(
    size: size,
    origin: _add(f1.origin, o),
    view: view,
    pose: f1.pose,
    color: rgb("#5c6bc0").lighten(60%),
    name: "a1",
  )
  pose-at(o, rgb("#5c6bc0"), "a2")
  for m in momenta {
    line(_add(o, m.before), _add(o, m.at), stroke: (
      paint: m.color,
      thickness: 1pt,
      dash: "dashed",
    ))
    circle(_add(o, m.before), radius: 0.07, fill: white, stroke: 1pt + m.color)
    vector(_add(o, m.at), m.p, m.color)
    circle(_add(o, m.at), radius: 0.07, fill: m.color, stroke: 0.6pt + white)
  }
  names(o, ($m_t arrow(v_t)$, $m_c arrow(v_c)$, $m_j arrow(v_j)$))
  content(
    _add(o, (f1.screen)(f1.points.head)),
    anchor: "north-west",
    padding: 0.3,
    text(fill: palette.neutral.line)[$t_1$],
  )
  content(
    _add(o, (f2.screen)(f2.points.vertex)),
    anchor: "north-east",
    padding: 0.25,
  )[$t_2$]
  panel-label(o, [A) Quantités \ de mouvement])

  // ---- B) Vecteurs déplacés en G et mis bout à bout ----
  let o = origin-of(1)
  let g = _add(o, (f2.screen)(f2.points.com))
  ground(o)
  pose-at(o, ghost-color, "c")
  // Résultante en filigrane : ce que la chaîne de vecteurs additionne
  line(
    g,
    _add(g, resultant),
    stroke: (
      paint: palette.gold.line.lighten(30%),
      thickness: 2pt,
      dash: "dashed",
    ),
    mark: (
      end: "stealth",
      fill: palette.gold.line.lighten(30%),
      stroke: palette.gold.line.lighten(30%),
    ),
  )
  let tip = g
  for m in momenta {
    vector(tip, m.p, m.color)
    tip = _add(tip, m.p)
  }
  mark-g(g)
  panel-label(o, [B) Mis bout à\  bout en $G$])

  // ---- C) Résultante cinétique ----
  let o = origin-of(2)
  let g = _add(o, (f2.screen)(f2.points.com))
  ground(o)
  pose-at(o, ghost-color, "d")
  // Vecteurs mis bout à bout, en filigrane : la résultante ferme le polygone
  let tip = g
  for m in momenta {
    vector(tip, m.p, m.color.lighten(60%), width: 1.4pt)
    tip = _add(tip, m.p)
  }
  vector(g, resultant, palette.gold.line, width: 3pt)
  mark-g(g)
  content(_add(g, _scale(resultant, 0.85)), anchor: "east", padding: 0.15, text(
    size: 11pt,
    fill: palette.gold.text,
  )[
    $sum m_k arrow(v_k)$
  ])
  panel-label(o, [C) Résultante \ cinétique])
})
