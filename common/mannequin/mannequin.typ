// Mannequin 3D articulé, dessiné avec CeTZ.
//
// Le mannequin est un squelette (chaîne de segments) dont chaque articulation
// peut être orientée. Chaque partie du corps est l'enveloppe convexe de
// quelques sphères; en projection orthographique, une sphère devient un
// cercle de même rayon, et l'enveloppe des sphères devient l'enveloppe des
// cercles. Les parties sont ensuite dessinées de la plus éloignée à la plus
// proche de l'observateur.
//
// Repère du mannequin (debout, position anatomique) :
//   x : vers l'avant (antérieur)
//   y : vers la gauche du mannequin
//   z : vers le haut
//
// Exemple :
// ```typ
// #cetz.canvas({
//   mannequin(
//     view: (azimuth: 0deg),           // vue de face
//     pose: (shoulder-r: (abduction: 90deg)),
//     name: "m",
//   )
//   circle("m.elbow-r", radius: 0.1)   // points d'ancrage nommés
// })
// ```

#import "@preview/cetz:0.4.1"
#import "../palette.typ": palette

// ---------------------------------------------------------------------------
// Algèbre 3D
// ---------------------------------------------------------------------------

#let _add(a, b) = a.zip(b).map(((x, y)) => x + y)
#let _scale(a, k) = a.map(x => x * k)
#let _dot(a, b) = a.zip(b).map(((x, y)) => x * y).sum()

#let _mat-vec(m, v) = m.map(row => _dot(row, v))
#let _mat-mul(a, b) = {
  let cols = range(3).map(j => b.map(row => row.at(j)))
  a.map(row => cols.map(col => _dot(row, col)))
}
#let _rot-x(a) = (
  (1, 0, 0),
  (0, calc.cos(a), -calc.sin(a)),
  (0, calc.sin(a), calc.cos(a)),
)
#let _rot-y(a) = (
  (calc.cos(a), 0, calc.sin(a)),
  (0, 1, 0),
  (-calc.sin(a), 0, calc.cos(a)),
)
#let _rot-z(a) = (
  (calc.cos(a), -calc.sin(a), 0),
  (calc.sin(a), calc.cos(a), 0),
  (0, 0, 1),
)
#let _chain(..mats) = mats.pos().fold(_rot-z(0deg), _mat-mul)

// Position d'un point exprimé dans un repère (origine, rotation)
#let _at(frame, v) = _add(frame.origin, _mat-vec(frame.rot, v))

// ---------------------------------------------------------------------------
// Pose
// ---------------------------------------------------------------------------

// Lit un angle de la pose; accepte un angle seul (flexion) ou un dictionnaire.
#let _angle(pose, joint, dof) = {
  let value = pose.at(joint, default: (:))
  if type(value) == angle { if dof == "flexion" { value } else { 0deg } } else {
    value.at(dof, default: 0deg)
  }
}

// ---------------------------------------------------------------------------
// Anthropométrie (fractions de la taille, d'après Winter)
// ---------------------------------------------------------------------------

#let _dims = (
  male: (
    hip-height: 0.530,
    hip-half-width: 0.045,
    shoulder-height: 0.262, // au-dessus des hanches
    shoulder-half-width: 0.095,
    neck-height: 0.330, // au-dessus des hanches
    head-top: 0.141, // sommet du crâne, au-dessus du cou
    upper-arm: 0.186,
    forearm: 0.146,
    hand: 0.100,
    thigh: 0.245,
    shank: 0.246,
  ),
  // Femme : épaules plus étroites, hanches plus larges, jambes un peu plus
  // courtes (de Leva, 1996) et membres supérieurs légèrement plus courts.
  female: (
    hip-height: 0.515,
    hip-half-width: 0.052,
    shoulder-height: 0.275,
    shoulder-half-width: 0.084,
    neck-height: 0.343,
    head-top: 0.135,
    upper-arm: 0.180,
    forearm: 0.142,
    hand: 0.092,
    thigh: 0.230,
    shank: 0.246,
  ),
)

/// Paramètres inertiels segmentaires de de Leva (1996, tableau 4), référencés
/// aux centres articulaires. `mass` : fraction de la masse totale; `com` :
/// position du centre de masse depuis l'extrémité d'origine (proximale ou
/// crâniale), en fraction de la longueur; `length` : longueur moyenne en
/// fraction de la taille (échantillons de 1,735 m et 1,741 m).
///
/// Extrémités : tête vertex → milieu des gonions; tronc incisure jugulaire →
/// milieu des hanches; main poignet → 3e métacarpe; pied talon → orteil.
#let segment-data = (
  female: (
    head: (mass: 0.0668, com: 0.5894, length: 200.2 / 1735),
    trunk: (mass: 0.4257, com: 0.4151, length: 529.3 / 1735),
    upper-arm: (mass: 0.0255, com: 0.5754, length: 275.1 / 1735),
    forearm: (mass: 0.0138, com: 0.4559, length: 264.3 / 1735),
    hand: (mass: 0.0056, com: 0.7474, length: 78.0 / 1735),
    thigh: (mass: 0.1478, com: 0.3612, length: 368.5 / 1735),
    shank: (mass: 0.0481, com: 0.4416, length: 432.3 / 1735),
    foot: (mass: 0.0129, com: 0.4014, length: 228.3 / 1735),
  ),
  male: (
    head: (mass: 0.0694, com: 0.5976, length: 203.3 / 1741),
    trunk: (mass: 0.4346, com: 0.4486, length: 531.9 / 1741),
    upper-arm: (mass: 0.0271, com: 0.5772, length: 281.7 / 1741),
    forearm: (mass: 0.0162, com: 0.4574, length: 268.9 / 1741),
    hand: (mass: 0.0061, com: 0.7900, length: 86.2 / 1741),
    thigh: (mass: 0.1416, com: 0.4095, length: 422.2 / 1741),
    shank: (mass: 0.0433, com: 0.4459, length: 434.0 / 1741),
    foot: (mass: 0.0137, com: 0.4415, length: 258.1 / 1741),
  ),
)

// ---------------------------------------------------------------------------
// Cinématique directe : renvoie les repères et les points 3D du squelette
// ---------------------------------------------------------------------------

#let _skeleton(pose, size, sex) = {
  let d = (:)
  for (k, v) in _dims.at(sex) { d.insert(k, v * size) }

  let global = pose.at("global", default: (:))
  let root = (
    origin: _add(
      (0, 0, d.hip-height),
      global.at("position", default: (0, 0, 0)).map(x => x * size),
    ),
    rot: _chain(
      _rot-z(global.at("yaw", default: 0deg)),
      _rot-y(global.at("pitch", default: 0deg)),
      _rot-x(global.at("roll", default: 0deg)),
      // Rotation du corps autour de son axe longitudinal, appliquée en premier
      _rot-z(global.at("turn", default: 0deg)),
    ),
  )

  let child(parent, offset, rot) = (
    origin: _at(parent, offset),
    rot: _mat-mul(parent.rot, rot),
  )

  // Tronc et tête (le segment pointe vers le haut : la flexion penche vers l'avant)
  let trunk = child(root, (0, 0, 0), _chain(
    _rot-y(_angle(pose, "trunk", "flexion")),
    _rot-x(_angle(pose, "trunk", "lateral")),
    _rot-z(_angle(pose, "trunk", "rotation")),
  ))
  let head = child(trunk, (0, 0, d.neck-height), _chain(
    _rot-y(_angle(pose, "head", "flexion")),
    _rot-x(_angle(pose, "head", "lateral")),
    _rot-z(_angle(pose, "head", "rotation")),
  ))

  let frames = (root: root, trunk: trunk, head: head)
  let points = (
    pelvis: root.origin,
    neck: head.origin,
  )

  // Membres (les segments pendent vers le bas, -z)
  for (side, s) in (("r", -1), ("l", 1)) {
    // Bras
    let shoulder = child(trunk, (0, s * d.shoulder-half-width, d.shoulder-height), _chain(
      _rot-y(-_angle(pose, "shoulder-" + side, "flexion")),
      _rot-x(s * _angle(pose, "shoulder-" + side, "abduction")),
      _rot-z(s * _angle(pose, "shoulder-" + side, "rotation")),
    ))
    let elbow = child(shoulder, (0, 0, -d.upper-arm), _rot-y(-_angle(
      pose,
      "elbow-" + side,
      "flexion",
    )))
    let wrist = child(elbow, (0, 0, -d.forearm), _chain(
      _rot-y(-_angle(pose, "wrist-" + side, "flexion")),
      _rot-x(s * _angle(pose, "wrist-" + side, "deviation")),
    ))

    // Jambe
    let hip = child(root, (0, s * d.hip-half-width, 0), _chain(
      _rot-y(-_angle(pose, "hip-" + side, "flexion")),
      _rot-x(s * _angle(pose, "hip-" + side, "abduction")),
      _rot-z(s * _angle(pose, "hip-" + side, "rotation")),
    ))
    let knee = child(hip, (0, 0, -d.thigh), _rot-y(_angle(
      pose,
      "knee-" + side,
      "flexion",
    )))
    let ankle = child(knee, (0, 0, -d.shank), _rot-y(-_angle(
      pose,
      "ankle-" + side,
      "flexion",
    )))

    frames.insert("shoulder-" + side, shoulder)
    frames.insert("elbow-" + side, elbow)
    frames.insert("wrist-" + side, wrist)
    frames.insert("hip-" + side, hip)
    frames.insert("knee-" + side, knee)
    frames.insert("ankle-" + side, ankle)

    let hand-end = _at(wrist, (0, 0, -d.hand))
    let toe = _at(ankle, (0.12 * size, 0, -0.03 * size))
    points.insert("shoulder-" + side, shoulder.origin)
    points.insert("elbow-" + side, elbow.origin)
    points.insert("wrist-" + side, wrist.origin)
    points.insert("hand-" + side, hand-end)
    points.insert("hip-" + side, hip.origin)
    points.insert("knee-" + side, knee.origin)
    points.insert("ankle-" + side, ankle.origin)
    points.insert("toe-" + side, toe)

    // Centres de masse segmentaires (de Leva)
    let data = segment-data.at(sex)
    let com(a, b, segment) = {
      let ratio = data.at(segment).com
      _add(_scale(a, 1 - ratio), _scale(b, ratio))
    }
    let metacarpal = _at(wrist, (0, 0, -data.hand.length * size))
    let heel = _at(ankle, (-0.03 * size, 0, -0.039 * size))
    points.insert("heel-" + side, heel)
    points.insert("com-upper-arm-" + side, com(shoulder.origin, elbow.origin, "upper-arm"))
    points.insert("com-forearm-" + side, com(elbow.origin, wrist.origin, "forearm"))
    points.insert("com-hand-" + side, com(wrist.origin, metacarpal, "hand"))
    points.insert("com-thigh-" + side, com(hip.origin, knee.origin, "thigh"))
    points.insert("com-shank-" + side, com(knee.origin, ankle.origin, "shank"))
    points.insert("com-foot-" + side, com(heel, toe, "foot"))
  }
  points.insert("head", _at(head, (0.005 * size, 0, 0.07 * size)))

  // Tête et tronc, puis centre de masse du corps entier
  let data = segment-data.at(sex)
  let vertex = _at(head, (0, 0, d.head-top))
  let head-com = _at(head, (0, 0, d.head-top - data.head.com * data.head.length * size))
  let suprasternale = _at(trunk, (0, 0, data.trunk.length * size))
  let trunk-com = _add(
    _scale(suprasternale, 1 - data.trunk.com),
    _scale(root.origin, data.trunk.com),
  )
  points.insert("vertex", vertex)
  points.insert("com-head", head-com)
  points.insert("com-trunk", trunk-com)

  let weighted = (
    (data.head.mass, head-com),
    (data.trunk.mass, trunk-com),
  )
  for side in ("r", "l") {
    for segment in ("upper-arm", "forearm", "hand", "thigh", "shank", "foot") {
      weighted.push((data.at(segment).mass, points.at("com-" + segment + "-" + side)))
    }
  }
  let total = weighted.map(((m, _)) => m).sum()
  points.insert("com", _scale(
    weighted.map(((m, c)) => _scale(c, m)).fold((0, 0, 0), _add),
    1 / total,
  ))

  (frames: frames, points: points)
}

// ---------------------------------------------------------------------------
// Volumes : chaque partie est une liste de sphères (centre 3D, rayon)
// ---------------------------------------------------------------------------

// Volumes du tronc et de la tête : (repère, centre, rayon), en fractions de la
// taille. `limbs` donne les rayons des membres aux articulations.
#let _shapes = (
  male: (
    pelvis: (
      ("root", (0, -0.042, 0.005), 0.045),
      ("root", (0, 0.042, 0.005), 0.045),
      ("root", (-0.014, -0.032, -0.01), 0.042), // fesses
      ("root", (-0.014, 0.032, -0.01), 0.042),
      ("root", (0.004, -0.025, 0.06), 0.042),
      ("root", (0.004, 0.025, 0.06), 0.042),
    ),
    chest: (
      ("trunk", (0, -0.028, 0.12), 0.042), // taille
      ("trunk", (0, 0.028, 0.12), 0.042),
      ("trunk", (0.006, -0.046, 0.215), 0.046), // poitrine
      ("trunk", (0.006, 0.046, 0.215), 0.046),
      ("trunk", (-0.004, -0.03, 0.272), 0.03), // trapèzes
      ("trunk", (-0.004, 0.03, 0.272), 0.03),
    ),
    neck: (
      ("trunk", (0, 0, 0.29), 0.025),
      ("head", (0.004, 0, 0.02), 0.023),
    ),
    head: (
      ("head", (-0.004, 0, 0.09), 0.051), // crâne
      ("head", (0.012, -0.008, 0.05), 0.033), // mâchoire
      ("head", (0.012, 0.008, 0.05), 0.033),
    ),
    limbs: (
      shoulder: 0.032,
      elbow: 0.019,
      wrist: 0.014,
      hip: 0.038,
      knee: 0.025,
      calf: 0.026,
      ankle: 0.016,
      hand: 1,
      foot: 1,
    ),
  ),
  female: (
    pelvis: (
      ("root", (0, -0.05, 0), 0.048),
      ("root", (0, 0.05, 0), 0.048),
      ("root", (-0.02, -0.036, -0.012), 0.046), // fesses
      ("root", (-0.02, 0.036, -0.012), 0.046),
      ("root", (0.002, -0.028, 0.065), 0.04),
      ("root", (0.002, 0.028, 0.065), 0.04),
    ),
    chest: (
      ("trunk", (-0.004, -0.02, 0.135), 0.036), // taille
      ("trunk", (-0.004, 0.02, 0.135), 0.036),
      ("trunk", (0.002, -0.038, 0.225), 0.04), // cage thoracique
      ("trunk", (0.002, 0.038, 0.225), 0.04),
      ("trunk", (0.03, -0.034, 0.222), 0.036), // seins
      ("trunk", (0.03, 0.034, 0.222), 0.036),
      ("trunk", (-0.006, -0.028, 0.28), 0.027), // trapèzes
      ("trunk", (-0.006, 0.028, 0.28), 0.027),
    ),
    neck: (
      ("trunk", (0, 0, 0.3), 0.021),
      ("head", (0.004, 0, 0.02), 0.019),
    ),
    head: (
      ("head", (-0.004, 0, 0.087), 0.048), // crâne
      ("head", (0.011, -0.007, 0.05), 0.03), // mâchoire
      ("head", (0.011, 0.007, 0.05), 0.03),
    ),
    limbs: (
      shoulder: 0.027,
      elbow: 0.017,
      wrist: 0.012,
      hip: 0.042,
      knee: 0.024,
      calf: 0.025,
      ankle: 0.015,
      hand: 0.9,
      foot: 0.9,
    ),
  ),
)

#let _parts(skeleton, size, sex) = {
  let f = skeleton.frames
  let p = skeleton.points
  let shape = _shapes.at(sex)
  let r = shape.limbs
  let sphere(frame, v, radius) = (_at(frame, _scale(v, size)), radius * size)
  let ball(point, radius) = (point, radius * size)
  let volume(key) = shape.at(key).map(((frame, v, radius)) => sphere(
    f.at(frame),
    v,
    radius,
  ))

  // `priority` départage les parties à égale profondeur (plus grand = devant)
  let parts = (
    (name: "pelvis", priority: 2, spheres: volume("pelvis")),
    (name: "chest", priority: 0, spheres: volume("chest")),
    (name: "neck", priority: -1, spheres: volume("neck")),
    (name: "head", priority: 1, spheres: volume("head")),
  )

  for side in ("r", "l") {
    let ankle = f.at("ankle-" + side)
    let wrist = f.at("wrist-" + side)
    parts += (
      (
        name: "upper-arm-" + side,
        priority: 3, // les bras passent devant les jambes
        spheres: (
          ball(p.at("shoulder-" + side), r.shoulder),
          ball(p.at("elbow-" + side), r.elbow),
        ),
      ),
      (
        name: "forearm-" + side,
        priority: 3, // les bras passent devant les jambes
        spheres: (
          ball(p.at("elbow-" + side), r.elbow),
          ball(p.at("wrist-" + side), r.wrist),
        ),
      ),
      (
        // Main à plat : large de face, mince de profil
        name: "hand-" + side,
        priority: 3, // les bras passent devant les jambes
        spheres: (
          sphere(wrist, (0, 0, -0.005).map(x => x * r.hand), 0.014 * r.hand),
          sphere(wrist, (0, -0.012, -0.055).map(x => x * r.hand), 0.012 * r.hand),
          sphere(wrist, (0, 0.012, -0.055).map(x => x * r.hand), 0.012 * r.hand),
          sphere(wrist, (0, -0.009, -0.09).map(x => x * r.hand), 0.009 * r.hand), // bout des doigts
          sphere(wrist, (0, 0.009, -0.09).map(x => x * r.hand), 0.009 * r.hand),
        ),
      ),
      (
        name: "thigh-" + side,
        priority: 1,
        spheres: (
          ball(p.at("hip-" + side), r.hip),
          ball(p.at("knee-" + side), r.knee),
        ),
      ),
      (
        name: "shank-" + side,
        priority: 1,
        spheres: (
          ball(p.at("knee-" + side), r.knee),
          sphere(f.at("knee-" + side), (-0.006, 0, -0.08), r.calf), // mollet
          ball(p.at("ankle-" + side), r.ankle),
        ),
      ),
      (
        name: "foot-" + side,
        priority: 1,
        spheres: (
          sphere(ankle, (-0.015, 0, -0.022).map(x => x * r.foot), 0.018 * r.foot), // talon
          sphere(ankle, (0.1, -0.014, -0.028).map(x => x * r.foot), 0.012 * r.foot), // orteils
          sphere(ankle, (0.1, 0.014, -0.028).map(x => x * r.foot), 0.012 * r.foot),
        ),
      ),
    )
  }
  parts
}

// ---------------------------------------------------------------------------
// Projection et dessin
// ---------------------------------------------------------------------------

// Base de la caméra orthographique : `azimuth` = 0deg regarde le mannequin de
// face, -90deg le regarde par sa droite (plan sagittal), `elevation` > 0
// regarde du dessus.
#let _camera(view) = {
  let az = view.at("azimuth", default: 0deg)
  let el = view.at("elevation", default: 0deg)
  let toward = (calc.cos(az), calc.sin(az), 0)
  let right = (-calc.sin(az), calc.cos(az), 0)
  (
    right: right,
    up: _add(_scale(toward, -calc.sin(el)), (0, 0, calc.cos(el))),
    depth: _add(_scale(toward, calc.cos(el)), (0, 0, calc.sin(el))),
  )
}

#let _project(cam, p) = (_dot(p, cam.right), _dot(p, cam.up))

// Enveloppe convexe (chaîne monotone d'Andrew)
#let _hull(points) = {
  let pts = points.sorted(key: p => p.at(1)).sorted(key: p => p.at(0))
  let cross(o, a, b) = (
    (a.at(0) - o.at(0)) * (b.at(1) - o.at(1))
      - (a.at(1) - o.at(1)) * (b.at(0) - o.at(0))
  )
  let half(seq) = {
    let out = ()
    for p in seq {
      while out.len() >= 2 and cross(out.at(-2), out.at(-1), p) <= 0 {
        let _ = out.pop()
      }
      out.push(p)
    }
    out
  }
  let lower = half(pts)
  let upper = half(pts.rev())
  lower.slice(0, -1) + upper.slice(0, -1)
}

#let _circle-points(c, r, n: 40) = range(n).map(i => {
  let a = i * 360deg / n
  (c.at(0) + r * calc.cos(a), c.at(1) + r * calc.sin(a))
})

/// Dessine le mannequin dans un canevas CeTZ.
///
/// - pose (dictionary): angles articulaires. Clés : `trunk`, `head`
///   (flexion, lateral, rotation), `shoulder-r/l` et `hip-r/l` (flexion,
///   abduction, rotation), `elbow-r/l`, `knee-r/l`, `ankle-r/l` (flexion),
///   `wrist-r/l` (flexion, deviation), et `global` (position, yaw, pitch,
///   roll, turn : rotation autour de l'axe longitudinal du corps, appliquée
///   avant les autres). Un angle seul vaut pour la flexion.
/// - view (dictionary): `azimuth` et `elevation` de la caméra.
/// - size (float): taille du mannequin en unités du canevas.
/// - origin (array): position du point au sol, entre les pieds.
/// - sex (str): `"male"` (défaut) ou `"female"`; change la silhouette et les
///   proportions.
/// - color (color): couleur du mannequin.
/// - name (str): nom du groupe; les articulations (`shoulder-r`, `elbow-r`,
///   …), les centres de masse segmentaires (`com-forearm-r`, `com-trunk`, …)
///   et le centre de masse du corps entier (`com`) sont des ancres.
/// - visible (bool): si `false`, seules les ancres sont créées (utile pour
///   annoter dans un canevas séparé, par ex. quand le mannequin est rogné).
#let mannequin(
  pose: (:),
  view: (:),
  size: 8,
  origin: (0, 0),
  sex: "male",
  color: rgb("#5c6bc0"),
  name: "mannequin",
  visible: true,
) = {
  import cetz.draw: *

  assert(sex in ("male", "female"), message: "mannequin : sex doit être \"male\" ou \"female\"")
  let skeleton = _skeleton(pose, size, sex)
  let cam = _camera(view)
  let to-screen(p) = _add(_project(cam, p), origin)

  let parts = _parts(skeleton, size, sex).map(part => {
    let depth = part.spheres.map(((c, r)) => _dot(c, cam.depth)).sum() / part.spheres.len()
    (..part, depth: depth, order: depth + part.priority * 0.002 * size)
  })
  // Seules les parties derrière le bassin sont assombries
  let reference = _dot(skeleton.points.pelvis, cam.depth)

  group(name: name, {
    for part in if visible { parts.sorted(key: p => p.order) } else { () } {
      let outline = _hull(
        part.spheres.map(((c, r)) => _circle-points(to-screen(c), r)).flatten().chunks(2),
      )
      // Les parties éloignées sont plus sombres
      let t = 1 - calc.clamp((reference - part.depth) / (0.15 * size), 0, 1)
      let base = color.darken((1 - t) * 30%)
      line(
        ..outline,
        close: true,
        fill: gradient.radial(
          base.lighten(35%),
          base,
          base.darken(25%),
          center: (35%, 30%),
          radius: 90%,
        ),
        stroke: (paint: base.darken(45%), thickness: 0.6pt, join: "round"),
      )
    }

    for (key, p) in skeleton.points { anchor(key, to-screen(p)) }
  })
}

/// Points 3D du squelette (articulations, centres de masse, `com`) sans rien
/// dessiner, dans le repère du mannequin (x avant, y gauche, z haut), en unités
/// du canevas. Utile pour placer un mannequin avant de le dessiner (par ex.
/// aligner les centres de masse de plusieurs poses).
#let mannequin-points(pose: (:), size: 8, sex: "male") = _skeleton(pose, size, sex).points
