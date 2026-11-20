#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Kinogramme schématique des trois derniers pas en saut en longueur : deux
// pas de pré-appel puis l'appel. La course est échantillonnée à intervalle de
// temps régulier : un pas qui dure plus longtemps contient donc plus d'images.
// Les pas du pré-appel durent plus longtemps et sont plus fléchis : le centre
// de masse s'abaisse et l'athlète a plus de temps pour créer sa force
// verticale avant de décoller. Les barres marquent les images où un pied est
// au sol (rouge : pré-appel, or : appel).

#let size = 3 // taille du coureur (unités du dessin)
#let stance-ratio = 0.45 // part du pas passée en appui

// Pas successifs : (longueur, facteur de flexion du genou d'appui, durée en
// nombre d'images). Les pas ont la même longueur : seule la durée change.
// Le dernier élément est l'appui d'appel (sur la planche), qui se termine au
// décollage.
// Le premier pas est un pas de course normal : il n'est pas dessiné, mais sert
// de référence pour la hauteur de course habituelle.
#let steps = (
  (2.4, 1.0, 3), // référence (non dessiné)
  (2.4, 1.7, 5), // pré-appel : pas plus longs dans le temps et plus fléchis
  (2.4, 2.3, 5),
  (2.4, 1.8, 4), // appel (le troisième des derniers pas), appui plus long
)

// Interpolation linéaire périodique d'une table ((phase, valeur), ...)
#let _interp(keys, p) = {
  let p = calc.rem(p, 1)
  let i = keys.position(k => k.at(0) > p)
  let (a, b) = (keys.at(i - 1), keys.at(i))
  let u = (p - a.at(0)) / (b.at(0) - a.at(0))
  a.at(1) + u * (b.at(1) - a.at(1))
}

// Angles d'une jambe selon sa phase dans le cycle (2 pas) ; 0 = pose du pied
#let _hip = ((0, 25deg), (0.225, -20deg), (0.5, 40deg), (0.75, 55deg), (1, 25deg))
#let _knee = ((0, 15deg), (0.1, 35deg), (0.225, 15deg), (0.45, 105deg), (0.7, 60deg), (0.9, 10deg), (1, 15deg))
#let _ankle = ((0, 0deg), (0.1, 20deg), (0.225, -25deg), (0.4, 5deg), (1, 0deg))

#let _side(k) = if calc.rem(k, 2) == 0 { "r" } else { "l" }

// Pose au pas k, à la fraction s du pas (la jambe d'appui du pas k vient de
// se poser en s = 0)
#let _pose(k, s) = {
  let depth = steps.at(calc.min(k, steps.len() - 1)).at(1)
  let pose = (trunk: 12deg)
  for (side, p) in ((_side(k), s / 2), (_side(k + 1), 0.5 + s / 2)) {
    let knee = _interp(_knee, p)
    // Flexion supplémentaire du genou pendant l'appui
    if p < stance-ratio / 2 { knee = 15deg + (knee - 15deg) * depth + (depth - 1) * 15deg }
    let hip = _interp(_hip, p)
    pose.insert("hip-" + side, hip)
    pose.insert("knee-" + side, knee)
    pose.insert("ankle-" + side, _interp(_ankle, p))
    // Bras en opposition avec la jambe du même côté : à la pose du pied, le
    // bras du même côté est en arrière et l'autre en avant. Le coude est très
    // fléchi devant et s'ouvre derrière (bras arrière plus étendu).
    let swing = calc.cos(p * 360deg)
    pose.insert("shoulder-" + side, 0deg - 55deg * swing)
    pose.insert("elbow-" + side, 85deg - 30deg * swing)
  }
  pose
}

// Appel : jambe d'appui tendue, genou libre et bras montés
#let _takeoff(k) = {
  let (a, b) = (_side(k), _side(k + 1))
  (
    trunk: 0deg,
    ("hip-" + a): -15deg,
    ("knee-" + a): 5deg,
    ("ankle-" + a): -25deg,
    ("hip-" + b): 85deg,
    ("knee-" + b): 95deg,
    // Bras lancés vers le haut, symétriques
    ("shoulder-" + a): 120deg,
    ("elbow-" + a): 35deg,
    ("shoulder-" + b): 120deg,
    ("elbow-" + b): 35deg,
  )
}

// Abscisse de la pose du pied pour chaque pas
#let _contacts = range(steps.len() + 1).map(k => steps.slice(0, k).map(s => s.at(0)).sum(default: 0))

// Origine qui place le pied d'appui `side` (milieu du pied) en `x`, au sol
#let _plant(pose, side, x) = {
  let p = mannequin-points(pose: pose, size: size)
  let heel = p.at("heel-" + side)
  let toe = p.at("toe-" + side)
  (x - (heel.at(0) + toe.at(0)) / 2, -calc.min(heel.at(2), toe.at(2)))
}

// Images : (pose, origine, phase)
#let _frames = {
  let frames = ()
  let last = steps.len() - 1
  for k in range(steps.len()) {
    let phase = if k == 0 { "reference" } else { "pre" }
    let count = steps.at(k).at(2)
    for j in range(count) {
      // L'appel ne comprend que l'appui, jusqu'au décollage
      let s = if k == last { j / (count - 1) * stance-ratio } else { j / count }
      let is-takeoff = k == last and j == count - 1
      let pose = if is-takeoff { _takeoff(k) } else { _pose(k, s) }
      let origin = if s <= stance-ratio or is-takeoff {
        _plant(pose, _side(k), _contacts.at(k))
      } else {
        // Phase aérienne : entre le décollage et la pose suivante
        let a = _plant(_pose(k, stance-ratio), _side(k), _contacts.at(k))
        let b = _plant(_pose(k + 1, 0), _side(k + 1), _contacts.at(k + 1))
        let u = (s - stance-ratio) / (1 - stance-ratio)
        (
          a.at(0) + u * (b.at(0) - a.at(0)),
          a.at(1) + u * (b.at(1) - a.at(1)) + 0.05 * size * 4 * u * (1 - u),
        )
      }
      frames.push((
        pose: pose,
        origin: origin,
        phase: if is-takeoff { "appel" } else { phase },
        step: k,
        stance: s <= stance-ratio or k == last,
      ))
    }
  }
  frames
}

// Kinogramme : une case par image, à intervalle de temps constant. L'axe
// horizontal est donc le temps (les poses ne se chevauchent pas) ; la hauteur
// de chaque pose est réelle.
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let view = (azimuth: -90deg)
  let slot = 1.65 // largeur d'une case (un intervalle de temps)

  let all = _frames.map(f => {
    let p = mannequin-points(pose: f.pose, size: size)
    (..f, local-com: p.com)
  })
  // Hauteur de course habituelle, donnée par le pas de référence
  let reference = all.filter(f => f.phase == "reference")
  let run-height = reference.map(f => f.local-com.at(2) + f.origin.at(1)).sum() / reference.len()
  let frames = all.filter(f => f.phase != "reference")

  // Envol : une image de plus, le centre de masse continue de monter
  let takeoff = frames.last()
  frames.push((
    ..takeoff,
    phase: "vol",
    stance: false,
    origin: (takeoff.origin.at(0), takeoff.origin.at(1) + 0.35),
  ))

  // Chaque pose est centrée sur sa case (centre de masse au milieu)
  let frames = frames.enumerate().map(((i, f)) => {
    let x = i * slot
    let origin = (x - f.local-com.at(0), f.origin.at(1))
    (..f, x: x, origin: origin, com: (x, f.local-com.at(2) + origin.at(1)))
  })
  let n = frames.len()
  let (x-min, x-max) = (-slot / 2 - 0.3, (n - 1) * slot + slot / 2 + 0.3)

  // Sol
  rect((x-min, -0.2), (x-max, 0), fill: palette.neutral.fill, stroke: none)
  line((x-min, 0), (x-max, 0), stroke: 1pt + palette.neutral.line)

  for (i, f) in frames.enumerate() {
    mannequin(size: size, origin: f.origin, view: view, pose: f.pose, name: "f" + str(i))
  }

  // Hauteur de course habituelle et trajectoire du centre de masse
  line((x-min, run-height), (x-max, run-height), stroke: (
    paint: palette.neutral.line,
    thickness: 0.8pt,
    dash: "dashed",
  ))
  content((x-min, run-height), anchor: "east", padding: 0.1, text(size: 11pt, fill: palette.neutral.text)[
    hauteur de course
  ])
  catmull(..frames.map(f => f.com), stroke: 1.8pt + palette.green.line)
  for f in frames {
    circle(f.com, radius: 0.08, fill: palette.green.line, stroke: 0.6pt + white)
  }

  // Une graduation par image (intervalle de temps constant)
  let y-ticks = -0.35
  for f in frames {
    line((f.x, y-ticks), (f.x, y-ticks - 0.2), stroke: 0.8pt + palette.neutral.text)
  }
  line((x-min, y-ticks), (x-max, y-ticks), stroke: 0.8pt + palette.neutral.text, mark: (end: "stealth", fill: palette.neutral.text))
  content((x-max, y-ticks), anchor: "south-east", padding: 0.08, text(size: 11pt)[temps])

  // Appuis des pas du pré-appel (en rouge) et de l'appel (en or) : images où
  // un pied est au sol
  let y-bars = y-ticks - 0.5
  for k in range(1, steps.len()) {
    let xs = frames.filter(f => f.step == k and f.stance and f.phase != "vol").map(f => f.x)
    let shade = if k == steps.len() - 1 { palette.gold } else { palette.red }
    line((calc.min(..xs) - 0.25, y-bars), (calc.max(..xs) + 0.25, y-bars), stroke: (
      paint: shade.line,
      thickness: 4pt,
      cap: "round",
    ))
  }
  content((x-min, y-bars), anchor: "east", padding: 0.1, text(size: 11pt)[pied au sol])

  // Phases
  let top = size * 1.25 // au-dessus des mains levées à l'appel
  let phase-label(x0, x1, body) = {
    line((x0, top), (x1, top), stroke: 0.8pt + palette.neutral.text, mark: (start: "|", end: "|"))
    content(((x0 + x1) / 2, top), anchor: "south", padding: 0.1, text(size: 13pt, weight: "semibold", body))
  }
  let first-appel = frames.position(f => f.step == steps.len() - 1)
  phase-label(x-min + 0.1, first-appel * slot - slot / 2 - 0.05, [Pré-appel])
  phase-label(first-appel * slot - slot / 2 + 0.05, x-max - 0.1, [Appel])
})
