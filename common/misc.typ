#import "book-template/biomecaniqc-book.typ": _gray
#import "palette.typ": *
#import "variables.typ": Livre

/// Show the learning objectives
/// - objectives (array): An array of content
/// -> content
#let learning-objectives(objectives) = align(right, box(
  width: 300pt,
  fill: _gray,
  inset: (left: 4pt, top: 8pt, bottom: 8pt, right: 4pt),
  align(left, {
    line(length: 100%, stroke: 0.7pt)
    block(inset: (left: 8pt), [
      #text(weight: "bold")[Objectifs d'apprentissage]
      #v(0pt)
      #objectives.map(e => [+ #e]).join()
    ])
    line(length: 100%, stroke: 0.7pt)
  }),
))

#let tague-questions(body) = align(
  left,
  box(
    width: 50%,
    stroke: 0pt,
    fill: _gray,
    inset: 8pt,
    align(
      left,
      [
        #set list(marker: e => if e == 0 {} else {
          [#h(0.6em) ---]
        })
        *Exemple de questions dans:*
        #body
      ],
    ),
  ),
)

#let interesting-note(body) = align(
  center,
  box(
    width: 80%,
    stroke: 1.5pt,
    fill: _gray,
    inset: 8pt,
    align(
      left,
      body,
    ),
  ),
)

#let complementary-questions(body) = align(
  left,
  box(
    width: 80%,
    stroke: 0pt,
    fill: rgb(palette.gold.fill),
    inset: 8pt,
    align(
      left,
      [
        *Questions complémentaires:*

        #body
      ],
    ),
  ),
)

#let see-handbook(body) = box(
  width: 60%,
  stroke: 0pt,
  fill: rgb(palette.green.fill),
  inset: 8pt,
)[
  Pour plus d'information, voir #Livre #(body)
]
