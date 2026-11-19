#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let size = 6
  let red = palette.red.line
  let gray = palette.neutral.text

  // Vue de face : la projection est (y, z)
  let view = (azimuth: 0deg)
  let screen(p) = (p.at(1), p.at(2))

  // Bras le long du corps, deux bras levés, un bras levé
  let poses = (
    (:),
    (shoulder-r: 180deg, shoulder-l: 180deg),
    (shoulder-r: 180deg),
  )
  let spacing = 2
  let panel-gap = 2.6
  let panel-width = spacing * (poses.len() - 1)

  let com-marker(pos) = {
    circle(pos, radius: 0.09, fill: white, stroke: 1pt + red)
    line((rel: (-0.15, 0), to: pos), (rel: (0.3, 0)), stroke: 1pt + red)
    line((rel: (0, -0.15), to: pos), (rel: (0, 0.3)), stroke: 1pt + red)
  }
  // Ligne de niveau horizontale couvrant un panneau
  let level(x0, y, style) = line(
    (x0 - 0.8, y),
    (x0 + panel-width + 0.8, y),
    stroke: style,
  )
  let panel-label(x0, y, body) = content(
    (x0 - 0.8, y),
    anchor: "south-west",
    text(size: 11pt, weight: "bold", body),
  )

  let points = poses.map(pose => mannequin-points(pose: pose, size: size))
  let top = calc.max(..points.map(p => p.hand-r.at(2)))

  // ---- A) Au sol : le centre de masse monte quand on lève les bras ----
  let x0 = 0
  line((x0 - 0.8, 0), (x0 + panel-width + 0.8, 0), stroke: 1pt + gray)
  level(x0, points.first().com.at(2), (paint: red, thickness: 0.7pt, dash: "dotted"))
  for (i, pose) in poses.enumerate() {
    let x = x0 + i * spacing
    mannequin(size: size, origin: (x, 0), view: view, pose: pose, name: "a" + str(i))
    com-marker((x + screen(points.at(i).com).at(0), points.at(i).com.at(2)))
  }
  panel-label(x0, top + 0.3, [A)])

  // ---- B) Centres de masse alignés : tête et main n'atteignent pas la
  // même hauteur ----
  let x0 = panel-width + panel-gap
  let y-com = points.first().com.at(2) // même niveau que le panneau A
  level(x0, y-com, (paint: red, thickness: 0.8pt, dash: "dashed"))
  for (i, pose) in poses.enumerate() {
    let x = x0 + i * spacing
    let p = points.at(i)
    let dy = y-com - p.com.at(2)
    mannequin(size: size, origin: (x, dy), view: view, pose: pose, name: "b" + str(i))
    com-marker((x + screen(p.com).at(0), y-com))
  }

  // Hauteur atteinte par la tête (bras baissés vs deux bras levés) et par la
  // main (deux bras levés vs un bras levé)
  let x-end = x0 + panel-width + 0.8
  let reach-y(i, key) = {
    let p = points.at(i)
    p.at(key).at(2) + y-com - p.com.at(2)
  }
  let reach(i, y, style) = line((x0 + i * spacing - 0.45, y), (x-end, y), stroke: style)
  let head-y = (reach-y(0, "vertex"), reach-y(1, "vertex"))
  let hand-y = (reach-y(1, "hand-r"), reach-y(2, "hand-r"))
  let head-style = (paint: gray, thickness: 0.7pt, dash: "dash-dotted")
  let hand-style = 0.7pt + red
  reach(0, head-y.at(0), head-style)
  reach(1, head-y.at(1), head-style)
  reach(1, hand-y.at(0), hand-style)
  reach(2, hand-y.at(1), hand-style)
  let side-label(ys, body) = content(
    (x-end, ys.sum() / 2),
    anchor: "west",
    padding: 0.12,
    text(size: 9pt, body),
  )
  side-label(head-y, [tête])
  side-label(hand-y, [main])
  panel-label(x0, top + 0.3, [B)])
})
