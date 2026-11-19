#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let size = 8
  let red = palette.red.line
  // Vert vif, lisible sur le bleu du mannequin
  let green = rgb("#69f0ae")

  // Hauteur moyenne du centre de masse (fraction de la taille), d'après le
  // texte. Chaque personne est vue de face puis de profil.
  let people = (
    (sex: "male", name: "h", x: 0, ratio: 0.57, label: [Homme], side: -1),
    (sex: "female", name: "f", x: 5, ratio: 0.55, label: [Femme], side: 1),
  )
  let profile-offset = 2.2
  let (x-left, x-right) = (-1.35, 5 + profile-offset + 1.35)

  let segments = (
    "com-head",
    "com-trunk",
    ..("upper-arm", "forearm", "hand", "thigh", "shank", "foot")
      .map(s => ("com-" + s + "-r", "com-" + s + "-l"))
      .flatten(),
  )

  // Repère du centre de masse du corps entier
  let com-marker(pos) = {
    circle(pos, radius: 0.13, fill: white, stroke: 1.2pt + red)
    line((rel: (-0.2, 0), to: pos), (rel: (0.4, 0)), stroke: 1.2pt + red)
    line((rel: (0, -0.2), to: pos), (rel: (0, 0.4)), stroke: 1.2pt + red)
  }

  // Sol
  line((x-left - 0.9, 0), (x-right + 0.9, 0), stroke: 1pt + palette.neutral.line)

  for person in people {
    let front = person.name
    let profile = person.name + "-profil"
    let height = person.ratio * size

    mannequin(
      size: size,
      origin: (person.x, 0),
      sex: person.sex,
      view: (azimuth: 0deg),
      name: front,
    )
    mannequin(
      size: size,
      origin: (person.x + profile-offset, 0),
      sex: person.sex,
      view: (azimuth: -90deg),
      name: profile,
    )

    // Niveau du centre de masse, prolongé sur toute la largeur pour comparer
    line((x-left, height), (x-right, height), stroke: (
      paint: red,
      thickness: 0.7pt,
      dash: "dotted",
    ))

    // Vue de face : les centres de masse segmentaires « tirent » vers le
    // centre de masse (à l'horizontale du centre de masse calculé, à la
    // hauteur moyenne donnée dans le texte)
    let com = (front + ".com", "|-", (0, height))
    for segment in segments {
      line(front + "." + segment, com, stroke: (
        paint: green,
        thickness: 1.1pt,
        dash: "dashed",
      ))
    }
    for segment in segments {
      circle(front + "." + segment, radius: 0.055, fill: red, stroke: 0.4pt + white)
    }
    com-marker(com)

    // Vue de profil : seul le centre de masse du corps entier
    com-marker((profile + ".com", "|-", (0, height)))

    // Hauteur du centre de masse, mesurée depuis le sol
    let x-ruler = if person.side < 0 { x-left } else { x-right }
    line(
      (x-ruler, 0),
      (x-ruler, height),
      stroke: 1pt + palette.neutral.text,
      mark: (
        start: "stealth",
        end: "stealth",
        fill: palette.neutral.text,
        scale: 0.7,
      ),
    )
    content(
      (x-ruler + person.side * 0.15, height / 2),
      anchor: if person.side < 0 { "east" } else { "west" },
      align(center, text(size: 10pt)[
        *#person.label* \
        #qty[#calc.round(person.ratio * 100)][%] \
        de la taille
      ]),
    )
  }
})
