#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"
#import "levier-commun.typ": bar, com, pivot


#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  let length = 6
  let height = 0.8

  // Barre posée sur un appui en `apex`; `offset` est la position de l'appui
  // le long de la barre et `angle` l'inclinaison prise par la barre.
  let balance(apex, offset, angle) = {
    pivot(apex)
    group({
      set-origin(apex)
      rotate(z: angle)
      bar((-offset, 0), length, height: height)
      com((length / 2 - offset, height / 2))
    })
  }

  // Appui à gauche ou à droite du centre de masse : la barre bascule
  balance((1.8, 3.4), 1.8, -6deg)
  balance((12.6, 3.4), 4.6, 6deg)

  // Appui sous le centre de masse : la barre est en équilibre
  balance((7, 0.6), 3, 0deg)

  // Déplacement de l'appui vers le centre de masse
  let arrow-stroke = (paint: palette.gold.line, thickness: 2pt, cap: "round")
  let arrow-mark = (
    end: "stealth",
    fill: palette.gold.line,
    stroke: palette.gold.line,
    scale: 1.6,
  )
  bezier((3.8, 5.2), (5.0, 2.3), (6.4, 5.0), (5.8, 3.1), stroke: arrow-stroke, mark: arrow-mark)
  bezier((10.2, 5.2), (9.0, 2.3), (7.6, 5.0), (8.2, 3.1), stroke: arrow-stroke, mark: arrow-mark)
})
