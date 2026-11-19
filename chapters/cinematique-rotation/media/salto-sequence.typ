#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Séquence d'un quadruple salto arrière (une image toutes les 0.1 s).
// Les anciennes étiquettes i-1, i, i+1 ont été effacées de la photo; on
// encadre ici les images k-1, k et k+1 utilisées pour calculer la vitesse en k.
// Coordonnées des images en pixels de la photo (1504 × 338).

#let (photo-w, photo-h) = (1504, 338)
// Début de chacune des 18 images (la dernière se termine en 1504)
#let starts = (
  4,
  165,
  319,
  430,
  525,
  615,
  692,
  770,
  860,
  950,
  1015,
  1079,
  1143,
  1207,
  1259,
  1323,
  1388,
  1439,
)
// Les images 6, 7 et 8 : l'exemple k = 7 du texte
#let frames = (
  (615, 692, [$k - 1$], palette.blue),
  (692, 770, [$k$], palette.gold),
  (770, 860, [$k + 1$], palette.red),
)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let width = 15
  let s = width / photo-w
  let height = photo-h * s
  let px(x) = x * s

  content((0, 0), anchor: "south-west", image(
    "salto-sequence-photo.jpg",
    width: width * 1cm,
  ))

  // Numéros des images
  for (i, x0) in starts.enumerate() {
    let x1 = starts.at(i + 1, default: photo-w)
    content(
      ((px(x0) + px(x1)) / 2, height),
      anchor: "south",
      padding: 0.08,
      text(
        size: 9pt,
        fill: palette.neutral.text,
      )[#(i + 1)],
    )
  }

  for (x0, x1, label, shade) in frames {
    rect(
      (px(x0) + 0.03, 0.03),
      (px(x1) - 0.03, height - 0.03),
      stroke: 2pt + shade.line,
    )
    content(((px(x0) + px(x1)) / 2, 0), anchor: "north", padding: 0.12, text(
      size: 12pt,
      weight: "bold",
      fill: shade.text,
      label,
    ))
  }
})
