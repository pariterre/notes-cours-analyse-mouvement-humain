#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Posture en cyclisme : le produit C_x S diminue à mesure que le cycliste
// s'abaisse (0.40 bras tendus, 0.35 tronc penché et bras fléchis, 0.30 coudes
// posés en avant du guidon, 0.25 en position de contre-la-montre avec casque
// profilé). Même vélo que la figure de la transmission (1 unité = 0.1 m),
// simplifié. Le cycliste est placé par cinématique inverse : bassin sur la
// selle, pieds sur les pédales, mains (ou coudes) sur le guidon.
// Traînée en rouge (barres proportionnelles, comme la figure de la traînée
// de forme).

#let k = 0.34 // cm par unité du vélo (0.1 m)
#let size = 17.5 * k // cycliste de 1.75 m
#let wheel-r = 3.5
#let crank-c = (4.2, -0.6)
#let crank-r = 1.7
#let crank-angle = -20deg // pédale droite (côté visible), vers l'avant
// Pour un cycliste de 1.75 m, la tige de selle et la potence sont plus hautes
// que sur la figure de la transmission
#let saddle-y = 5.6
#let bar-rise = 0.75 // vélo de route (contre-la-montre : 0, avant plus bas)
#let hip = (2.75, saddle-y + 0.85) // articulation de la hanche, au-dessus de la selle
#let view = (azimuth: -90deg) // regarde vers la droite

#let polar(r, a) = (r * calc.cos(a), r * calc.sin(a))
#let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
#let sub(p, q) = (p.at(0) - q.at(0), p.at(1) - q.at(1))
#let scl(p, f) = (p.at(0) * f, p.at(1) * f)
#let dist(p, q) = calc.norm(..sub(p, q))
#let dist3(p, q) = calc.norm(..p.zip(q).map(((a, b)) => a - b))
// Direction d'un segment, comptée depuis la verticale descendante vers l'avant
#let dir(a) = (calc.sin(a), -calc.cos(a))
#let heading(v) = calc.atan2(-v.at(1), v.at(0))

// Longueurs des segments du mannequin (unités du canevas)
#let p0 = mannequin-points(size: size)
#let thigh = dist3(p0.hip-r, p0.knee-r)
#let shank = dist3(p0.knee-r, p0.ankle-r)
#let upper-arm = dist3(p0.shoulder-r, p0.elbow-r)
#let forearm = dist3(p0.elbow-r, p0.wrist-r)
#let shoulder-height = p0.shoulder-r.at(2) - p0.pelvis.at(2)
#let pelvis-height = p0.pelvis.at(2)

/// Chaîne à deux segments (l1, l2) de `from` à `to` (cinématique inverse).
/// Renvoie les directions absolues des deux segments. `bend` : 1 si
/// l'articulation intermédiaire est vers l'avant (genou), -1 vers le bas (coude).
#let two-link(from, to, l1, l2, bend) = {
  let v = sub(to, from)
  let d = calc.min(calc.norm(..v), (l1 + l2) * 0.999)
  let a = heading(v)
  let alpha = calc.acos(calc.clamp((l1 * l1 + d * d - l2 * l2) / (2 * l1 * d), -1, 1))
  let beta = calc.acos(calc.clamp((l2 * l2 + d * d - l1 * l1) / (2 * l2 * d), -1, 1))
  (a + bend * alpha, a - bend * beta)
}

/// Pose du cycliste. `lean` : inclinaison du tronc (depuis la verticale);
/// `grip` : poignets sur le guidon (unités du vélo) ou `none` en position
/// aérodynamique (coudes sur les appuis, avant-bras vers l'avant).
#let cyclist(lean, grip: none, arm: 12deg, head: 20deg) = {
  let h = scl(hip, k)
  let shoulder = add(h, scl((calc.sin(lean), calc.cos(lean)), shoulder-height))
  // Bras
  let (arm, fore) = if grip != none {
    two-link(shoulder, scl(grip, k), upper-arm, forearm, -1)
  } else {
    (arm, 96deg)
  }
  // Jambes : chevilles un peu en arrière et au-dessus de l'axe de la pédale
  let leg(a) = {
    let pedal = scl(add(crank-c, polar(crank-r, a)), k)
    let ankle = add(pedal, (-0.07 * size, 0.05 * size))
    let (t, s) = two-link(h, ankle, thigh, shank, 1)
    (hip: t, knee: t - s, ankle: 5deg - s)
  }
  let (r, l) = (leg(crank-angle), leg(crank-angle + 180deg))
  // Tout le corps (bassin compris) est incliné; le tronc s'arrondit un peu.
  // L'inclinaison du bassin ramène les cuisses vers l'arrière : on la compense.
  let pitch = lean - 10deg
  let pose = (
    global: (pitch: pitch),
    trunk: 10deg,
    head: head - lean,
    shoulder-r: arm + lean,
    shoulder-l: arm + lean,
    elbow-r: fore - arm,
    elbow-l: fore - arm,
    hip-r: r.hip + pitch,
    knee-r: r.knee,
    ankle-r: r.ankle,
    hip-l: l.hip + pitch,
    knee-l: l.knee,
    ankle-l: l.ankle,
  )
  (
    pose: pose,
    origin: sub(h, (0, pelvis-height)),
    aero: grip == none,
    lean: lean,
    elbow: add(shoulder, scl(dir(arm), upper-arm)),
    wrist: add(add(shoulder, scl(dir(arm), upper-arm)), scl(dir(fore), forearm)),
  )
}

/// Vélo simplifié (même géométrie que la figure de la transmission)
#let bike(aero: none, rise: bar-rise) = {
  import cetz.draw: *
  let ink = palette.neutral.text
  let metal = palette.neutral.line
  let frame = (paint: metal.lighten(45%), thickness: 4pt, cap: "round", join: "round")
  let dark = palette.dark.fill
  let p(q) = scl(q, k)

  // Sol
  line(p((-4.4, -wheel-r)), p((13.9, -wheel-r)), stroke: 0.8pt + ink)
  for i in range(int(18 / 0.6)) {
    let x = -4.2 + i * 0.6
    line(p((x, -wheel-r)), p((x - 0.45, -wheel-r - 0.45)), stroke: 0.4pt + ink.transparentize(40%))
  }
  // Roues
  for c in ((0, 0), (9.8, 0)) {
    for j in range(12) {
      line(add(p(c), polar(0.2, j * 30deg)), add(p(c), polar(k * (wheel-r - 0.2), j * 30deg + 30deg)), stroke: 0.3pt + metal.lighten(30%))
    }
    circle(p(c), radius: k * (wheel-r - 0.1), stroke: 3pt + dark)
  }
  // Cadre
  let seat = (3.3, 3.4)
  let (head-bottom, head-top) = ((8.95, 2.1), (8.6, 3.4))
  line(p((0, 0)), p(crank-c), p(seat), close: true, stroke: frame)
  line(p(seat), p(head-top), p(head-bottom), p(crank-c), stroke: frame)
  line(p(head-bottom), p((9.35, 0.9)), p((9.8, 0)), stroke: (..frame, thickness: 3pt))
  // Selle
  let post = (seat.at(0) - 0.25 * (saddle-y - 0.15 - seat.at(1)), saddle-y - 0.15)
  line(p(seat), p(post), stroke: (paint: metal, thickness: 2.5pt, cap: "round"))
  line(p(add(post, (-0.75, 0.12))), p(add(post, (0.8, 0.08))), stroke: (paint: dark, thickness: 4pt, cap: "round"))
  // Potence et cintre
  let up(q) = p(add(q, (0, rise)))
  line(p(head-top), up((8.5, 3.75)), up((9.4, 3.85)), stroke: (paint: metal, thickness: 2.5pt, cap: "round", join: "round"))
  line(up((9.4, 3.85)), up((10.0, 3.75)), up((10.2, 3.3)), up((10.0, 2.85)), up((9.65, 2.85)), stroke: (
    paint: dark,
    thickness: 3pt,
    cap: "round",
    join: "round",
  ))
  // Prolongateur (position aérodynamique) : appui sous le coude, vers l'avant
  if aero != none {
    let (elbow, wrist) = aero
    let pad = add(elbow, (0, -0.06 * size))
    let tip = add(wrist, scl(dir(96deg), 0.06 * size))
    line(pad, tip, stroke: (paint: dark, thickness: 2.5pt, cap: "round"))
    line(add(pad, (-0.25, 0)), add(pad, (0.25, 0)), stroke: (paint: dark, thickness: 4pt, cap: "round"))
    // Support jusqu'au cintre
    line(up((9.2, 3.85)), (9.2 * k, pad.at(1) + (tip.at(1) - pad.at(1)) * (9.2 * k - pad.at(0)) / (tip.at(0) - pad.at(0))), stroke: (paint: metal, thickness: 2pt))
  }
  // Pédalier
  circle(p(crank-c), radius: k * 1.0, stroke: 1.5pt + metal)
  for a in (crank-angle, crank-angle + 180deg) {
    line(p(crank-c), p(add(crank-c, polar(crank-r, a))), stroke: (paint: metal, thickness: 2.5pt, cap: "round"))
  }
}

/// Casque profilé : goutte autour de la tête, la queue suit le dos
#let helmet(center, lean) = {
  import cetz.draw: *
  let r = 0.07 * size
  let back = 180deg + 90deg - lean // direction de la queue (vers l'arrière, le long du dos)
  let tail = add(center, polar(0.17 * size, back - 8deg))
  let arc = range(0, 31).map(i => add(center, polar(r, back + 75deg + 210deg * i / 30)))
  line(tail, ..arc, close: true, fill: palette.neutral.fill.darken(15%), stroke: 1pt + palette.neutral.line)
}

// (titre, C_x S, hauteur du cintre, cycliste, casque profilé)
#let postures = (
  ([Position traditionnelle, \ bras tendus], 0.40, bar-rise, cyclist(52deg, grip: (9.4, 3.95 + bar-rise)), false),
  ([Tronc penché, \ bras fléchis], 0.35, bar-rise, cyclist(64deg, grip: (9.85, 3.75 + bar-rise), head: 25deg), false),
  ([Coudes posés en avant \ du guidon], 0.30, bar-rise, cyclist(72deg, arm: 25deg, head: 50deg), false),
  ([Contre-la-montre, \ casque profilé], 0.25, 0, cyclist(80deg, arm: 30deg, head: 68deg), true),
)

#let panel((title, cxs, rise, c, aero-helmet)) = {
  let aero = if c.aero { (c.elbow, c.wrist) } else { none }
  stack(
    spacing: 4pt,
    align(center, text(size: 11pt, weight: "semibold", fill: palette.neutral.text, title)),
    cetz.canvas(length: 1cm, {
      import cetz.draw: *
      bike(aero: aero, rise: rise)
      mannequin(size: size, origin: c.origin, view: view, pose: c.pose, name: "m")
      if aero-helmet {
        let head = mannequin-points(size: size, pose: c.pose).com-head
        helmet(add(c.origin, (head.at(0), head.at(2))), c.lean)
      }
      // Traînée : barre proportionnelle à C_x S
      let y = -wheel-r * k - 0.55
      let len = 4.0 * cxs / 0.4
      rect((-1.2, y - 0.17), (-1.2 + len, y + 0.17), fill: palette.red.fill, stroke: 1pt + palette.red.line)
      content((-1.2 + len, y), anchor: "west", padding: 0.12, text(size: 11pt, fill: palette.red.text)[$C_x S approx #qty[#cxs][m^2]$])
    }),
  )
}

#grid(
  columns: 2,
  column-gutter: 1.2cm,
  row-gutter: 0.8cm,
  ..postures.map(panel),
)
