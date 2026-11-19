// Image de la trampoliniste (#qty[1.61][m], #qty[55][kg]) et annotations
// dessinées par-dessus. Les trois figures (vierge, jambe, modèle à trois
// segments) partagent la même image.
//
// Les coordonnées sont en pixels de l'image d'origine (1502 × 635 px, origine
// en haut à gauche, y vers le bas). Imprimée sur 5.87 in (149.1 mm), l'image
// donne environ 10.07 px/mm : les mesures du tableau VII.2 sont faites à cette
// échelle.

#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"

#let _source = (width: 1502, height: 635)
#let _px-per-mm = 1502 / 149.1

// Repère de l'image (déjà tracé sur l'image vierge)
#let _origin = (30, 610)

// Centres articulaires
#let _hip = (728, 440)
#let _ankle = (225, 175)
#let _knee = (506, 323) // à 31.5 mm de la malléole, sur l'axe du membre
#let _shoulder = (1108, 410)
#let _wrist = (1370, 160)

// Point exprimé en mm dans le repère de l'image → pixels
#let _from-mm(x, y) = (_origin.at(0) + x * _px-per-mm, _origin.at(1) - y * _px-per-mm)

// Centres de masse segmentaires, aux coordonnées du tableau VII.2
#let _com = (
  mi: _from-mm(48, 29),
  tt: _from-mm(84, 19),
  ms: _from-mm(123, 34.5),
)

#let _segment-color = palette.red.line
#let _com-color = palette.blue.line
#let _projection-color = palette.green.line

/// Dessine l'image (rognée à `crop`, en pixels) à la hauteur `height`, puis
/// les annotations `draw(p)`, où `p(x, y)` convertit des pixels de l'image en
/// coordonnées du canevas.
#let _annotated(
  height,
  crop: (x: 0, y: 0, w: _source.width, h: _source.height),
  draw: p => (),
) = {
  let px = height / crop.h // longueur d'un pixel
  let p((x, y)) = (x, -y)
  box(
    width: crop.w * px,
    height: height,
    clip: true,
    // `place` ancre l'image en haut à gauche, quel que soit l'alignement
    // ambiant (une figure centre son contenu, ce qui décalerait le rognage)
    place(top + left, dx: -crop.x * px, dy: -crop.y * px, cetz.canvas(
      length: px,
      {
        import cetz.draw: *
        content((0, 0), anchor: "north-west", image(
          "trampoliniste-vierge.jpg",
          width: _source.width * px,
        ))
        draw(p)
      },
    )),
  )
}

// Segment orienté vers l'extrémité distale
#let _segment(p, from, to) = {
  import cetz.draw: *
  line(p(from), p(to), stroke: 2.5pt + _segment-color, mark: (
    end: "stealth",
    fill: _segment-color,
    stroke: _segment-color,
    scale: 1.2,
  ))
}

#let _com-marker(p, pos, radius: 11) = {
  import cetz.draw: *
  circle(p(pos), radius: radius, fill: _com-color, stroke: 1pt + white)
}

// Projections d'un point sur les axes d'origine `origin`
#let _projection(p, pos, origin) = {
  import cetz.draw: *
  let style = (paint: _projection-color, thickness: 1pt, dash: "dashed")
  line(p(pos), p((origin.at(0), pos.at(1))), stroke: style)
  line(p(pos), p((pos.at(0), origin.at(1))), stroke: style)
}

/// Image vierge, pour l'exercice.
#let trampoliniste-vierge(height: 2.48in) = _annotated(height)

/// Placement du centre de masse de la jambe (axe genou → malléole latérale,
/// centre de masse à 0.433 de la longueur depuis le genou).
#let trampoliniste-jambe(height: 1.7in) = {
  let crop = (x: 20, y: 40, w: 560, h: 530)
  let origin = (48, 490) // repère local, dans le coin de l'image rognée
  let com = _knee.zip(_ankle).map(((k, a)) => k + 0.433 * (a - k))

  _annotated(height, crop: crop, draw: p => {
    import cetz.draw: *

    // Masque le repère de l'image entière qui déborde dans le rognage
    rect(p((crop.x, 440)), p((220, crop.y + crop.h)), fill: white, stroke: none)
    rect(p((crop.x, crop.y)), p((40, crop.y + crop.h)), fill: white, stroke: none)

    // Repère local
    let axis-style = (
      stroke: 1.5pt + black,
      mark: (end: "stealth", fill: black, scale: 1.2),
    )
    line(p(origin), p((origin.at(0), 60)), ..axis-style)
    line(p(origin), p((570, origin.at(1))), ..axis-style)
    content(p((origin.at(0) - 12, com.at(1))), anchor: "east", text(
      fill: _projection-color,
    )[$y$])
    content(p((com.at(0), origin.at(1) + 10)), anchor: "north", text(
      fill: _projection-color,
    )[$x$])

    _projection(p, com, origin)
    _segment(p, _knee, _ankle)
    for joint in (_knee, _ankle) {
      circle(p(joint), radius: 10, fill: _segment-color, stroke: 1pt + white)
    }
    _com-marker(p, com)
  })
}

/// Modèle à trois segments : membres inférieurs (hanche → cheville),
/// tête-cou-tronc (épaule → hanche) et membres supérieurs (épaule → poignet).
#let trampoliniste-exemple(height: 1.7in) = _annotated(height, draw: p => {
  import cetz.draw: *

  // Vecteur position du centre de masse des membres inférieurs et projections
  _projection(p, _com.mi, _origin)
  line(p(_origin), p(_com.mi), stroke: 1.5pt + _projection-color)

  _segment(p, _hip, _ankle)
  _segment(p, _shoulder, _hip)
  _segment(p, _shoulder, _wrist)
  for pos in _com.values() { _com-marker(p, pos, radius: 16) }
})
