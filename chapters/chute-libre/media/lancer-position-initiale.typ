#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"
#import "lancer-poids.typ": panel


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  panel(
    [Position horizontale],
    (
      ((x: -0.3), [#qty[-0.3][m]]),
      ((:), [#qty[0][m]]),
      ((x: 0.3), [#qty[+0.3][m]]),
    ),
    (16.3, 17.1, 0.1),
  )
  group({
    translate((11.2, 0))
    panel(
      [Hauteur de lâcher],
      (
        ((h: 2.0), [#qty[2.0][m]]),
        ((:), [#qty[2.2][m]]),
        ((h: 2.4), [#qty[2.4][m]]),
      ),
      (16.3, 17.1, 0.1),
    )
  })
})
