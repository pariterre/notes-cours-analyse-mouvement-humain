#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Technique de la main droite : pouce = x, index = y, majeur = z.
// La photo provient du document Word d'origine (image16.emf); les flèches
// et étiquettes sont dessinées par-dessus pour rester nettes et modifiables.

// Repère de dessin : pixels de la photo originale (1805 × 1535, origine en
// haut à gauche, y vers le bas). Le fichier JPEG est réduit de moitié, mais
// sa taille d'affichage est imposée ici : les positions restent valables
// quelle que soit sa résolution.
#let (photo-w, photo-h) = (1805, 1535)
#let px-per-unit = 100

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let pt((x, y)) = (x / px-per-unit, (photo-h - y) / px-per-unit)

  content(
    (0, 0),
    anchor: "south-west",
    image("main-droite-photo.jpg", width: photo-w / px-per-unit * 1cm),
  )

  let origin = (730, 1140)
  let axes = (
    (tip: (1630, 1085), shade: palette.red, name: $x$, finger: [pouce], label-anchor: "south-east"),
    (tip: (975, 700), shade: palette.green, name: $y$, finger: [index], label-anchor: "south-west"),
    (tip: (575, 330), shade: palette.blue, name: $z$, finger: [majeur], label-anchor: "south-east"),
  )

  for axis in axes {
    // Halo blanc pour détacher la flèche de la peau
    line(
      pt(origin),
      pt(axis.tip),
      stroke: (paint: white.transparentize(15%), thickness: 14pt, cap: "round"),
    )
    line(
      pt(origin),
      pt(axis.tip),
      stroke: (paint: axis.shade.line, thickness: 7pt, cap: "round"),
      mark: (end: "stealth", fill: axis.shade.line, stroke: (paint: white, thickness: 1.5pt), scale: 4.5),
    )
    content(pt(axis.tip), anchor: axis.label-anchor, padding: 0.4, box(
      fill: white.transparentize(10%),
      radius: 6pt,
      width: 2.9cm,
      height: 2.15cm,
      stroke: 1.6pt + axis.shade.line,
      // Boîtes de même taille; hauteurs de ligne ajustées au dessin réel des
      // lettres ("bounds") pour que le contenu soit bien centré.
      {
        set text(fill: axis.shade.text, top-edge: "bounds", bottom-edge: "bounds")
        align(center + horizon, stack(
          spacing: 8pt,
          align(center, text(size: 36pt, axis.name)),
          align(center, text(size: 20pt, axis.finger)),
        ))
      },
    ))
  }

  // Origine commune
  circle(pt(origin), radius: 0.26, fill: white, stroke: 4pt + palette.dark.fill)
})
