#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Entropie : chaque conversion d'une forme d'énergie en une autre perd une
// partie de l'énergie sous forme de chaleur. Diagramme de flux : la largeur
// des bandes est proportionnelle à l'énergie. Reconvertir l'énergie 2 en
// énergie 1 ne redonne pas l'énergie de départ (transformation irréversible).
// Rendement de chaque conversion : 70 % (valeur d'exemple, non affichée).

#let efficiency = 0.7
#let unit-height = 2.2 // hauteur de la bande de départ (100 %)
#let (box-w, gap) = (2.7, 2.6) // largeur des blocs, distance entre deux blocs
#let tip = 0.4 // profondeur de la pointe des flèches
#let sep = 0.25 // écart entre une pointe et le bloc qui la reçoit (comme la chaîne de la puissance)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  // Chaleur en rouge, comme la « perte en chaleur » de la figure suivante
  let heat = palette.red

  // Toutes les formes d'énergie en bleu, de plus en plus estompé au fil des
  // conversions (l'énergie disponible diminue)
  let faded(amount) = (
    fill: palette.blue.fill.lighten(amount),
    line: palette.blue.line.lighten(amount),
    text: palette.blue.text.lighten(amount * 0.6),
  )
  // Blocs successifs : (nom, couleur, énergie relative)
  let blocks = (
    ([Énergie 1], faded(0%), 1.0),
    ([Énergie 2], faded(35%), efficiency),
    ([Énergie 1], faded(60%), efficiency * efficiency),
  )
  let x-of(i) = i * (box-w + gap)

  for (i, (name, shade, e)) in blocks.enumerate() {
    let h = e * unit-height
    let x = x-of(i)

    // Bande vers le bloc suivant et dérivation de chaleur
    if i + 1 < blocks.len() {
      let h-next = blocks.at(i + 1).at(2) * unit-height
      let (x0, x1) = (x + box-w, x-of(i + 1))
      // Énergie transmise (en bas) : flèche dont la pointe entre dans l'encoche
      // du bloc suivant (même style que la chaîne de la puissance)
      let xe = x1 - sep // la flèche s'arrête un peu avant le bloc suivant
      line(
        (x0, 0),
        (xe, 0),
        (xe + tip, h-next / 2),
        (xe, h-next),
        (x0, h-next),
        close: true,
        fill: shade.fill.lighten(30%),
        stroke: 0.8pt + shade.line.lighten(30%),
      ) // couleur du bloc de départ
      // Chaleur (en haut) : la bande tourne vers le haut et se termine en flèche
      let w = h - h-next // largeur de la bande de chaleur
      let xc = x0 + 0.5 + w // abscisse de la partie verticale (bord extérieur)
      let top = unit-height + 0.9
      merge-path(fill: heat.fill, stroke: 0.8pt + heat.line, {
        bezier((x0, h), (xc - w, top), (xc - w, h))
        line((xc - w, top), (xc - w - 0.15, top))
        line((xc - w - 0.15, top), (xc - w / 2, top + 0.55))
        line((xc - w / 2, top + 0.55), (xc + 0.15, top))
        line((xc + 0.15, top), (xc, top))
        bezier((xc, top), (x0, h-next), (xc, h-next))
      })
      content((xc - w / 2, top + 0.55), anchor: "south", padding: 0.08, text(
        size: 12pt,
        fill: heat.text,
        weight: "semibold",
      )[chaleur])
    }

    // Bloc; à partir du deuxième, encoche à gauche qui reçoit la flèche
    let notch = if i == 0 { 0 } else { tip }
    line(
      (x, 0),
      (x + box-w, 0),
      (x + box-w, h),
      (x, h),
      (x + notch, h / 2),
      close: true,
      fill: shade.fill,
      stroke: 1.2pt + shade.line,
    )
    content((x + box-w / 2 + notch / 2, h / 2), text(
      size: 12pt,
      weight: "semibold",
      fill: shade.text,
      name,
    ))
  }
})
