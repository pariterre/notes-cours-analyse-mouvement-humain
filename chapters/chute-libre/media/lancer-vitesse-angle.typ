#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"
#import "lancer-poids.typ": panel


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  panel(
    [Vitesse de lâcher],
    (
      ((v: 11), [#qty[11][m / s]]),
      ((:), [#qty[12][m / s]]),
      ((v: 13), [#qty[13][m / s]]),
    ),
    (13, 20, 1),
  )
  group({
    translate((11.2, 0))
    panel(
      [Angle de lâcher],
      (
        ((angle: 35), [35°]),
        ((:), [40°]),
        ((angle: 45), [45°]),
      ),
      (16.3, 16.8, 0.1),
    )
  })
})
