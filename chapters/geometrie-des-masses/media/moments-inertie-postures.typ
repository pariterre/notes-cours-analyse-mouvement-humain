#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let size = 5
  let red = palette.red.line
  let arrow-mark = (end: "stealth", fill: red, stroke: red, scale: 0.9)

  // Dessine un mannequin dont le centre de masse tombe en `com`
  let place(pose, view, com, name) = {
    let p = mannequin-points(pose: pose, size: size).com
    let right = (-calc.sin(view.azimuth), calc.cos(view.azimuth), 0)
    let x = p.zip(right).map(((a, b)) => a * b).sum()
    mannequin(
      size: size,
      origin: (com.at(0) - x, com.at(1) - p.at(2)),
      view: view,
      pose: pose,
      name: name,
    )
  }

  // Rotation autour d'un axe perpendiculaire à la page, passant par `com`
  let rotation(com) = {
    arc(
      com,
      start: 165deg,
      stop: 15deg,
      radius: 0.45,
      anchor: "origin",
      stroke: 2.5pt + red,
      mark: arrow-mark,
    )
    circle(com, radius: 0.09, fill: red, stroke: none)
  }

  // Rotation autour d'un axe vertical passant par `com`
  let spin(com, top, bottom) = {
    line((com.at(0), bottom), (com.at(0), top), stroke: 1.2pt + red)
    arc(
      (com.at(0), top - 0.15),
      start: 200deg,
      delta: 300deg,
      radius: (0.3, 0.1),
      anchor: "origin",
      stroke: 1.8pt + red,
      mark: arrow-mark,
    )
  }

  let label(x, y, body) = content((x, y), anchor: "north", text(size: 11pt, body))

  // ---- Axe transversal (vues de profil) ----
  let side = (azimuth: -90deg)
  let y1 = 0
  let label-y1 = y1 - 3.1

  // Droit
  place((:), side, (0, y1), "droit")
  rotation((0, y1))
  label(0, label-y1, [$I_T = #qty[12][kg m^2]$])

  // Carpé : jambes tendues, tronc penché sur les jambes
  // (les angles d'épaule s'ajoutent à l'inclinaison du tronc)
  let pike = (
    hip-r: 95deg,
    hip-l: 95deg,
    trunk: 40deg,
    head: 20deg,
    shoulder-r: 108deg,
    shoulder-l: 108deg,
  )
  place(pike, side, (3.6, y1), "carpe")
  rotation((3.6, y1))
  label(3.6, label-y1, [$I_C = #qty[6][kg m^2]$])

  // Groupé : genoux ramenés sur la poitrine, bras autour des jambes
  let tuck = (
    hip-r: 120deg,
    hip-l: 120deg,
    knee-r: 130deg,
    knee-l: 130deg,
    trunk: 20deg,
    head: 25deg,
    // Bras autour des tibias : avant-bras tournés vers l'intérieur
    shoulder-r: (flexion: 35deg, rotation: 60deg),
    shoulder-l: (flexion: 35deg, rotation: 60deg),
    elbow-r: 80deg,
    elbow-l: 80deg,
  )
  place(tuck, side, (7, y1), "groupe")
  rotation((7, y1))
  label(7, label-y1, [$I_G = #qty[4][kg m^2]$])

  // ---- Axes longitudinal et antéropostérieur (vues de face) ----
  let front = (azimuth: 0deg)
  let y2 = -7.4
  let label-y2 = y2 - 3.1
  let (top, bottom) = (y2 + 2.6, y2 - 2.9)

  // Axe longitudinal, bras le long du corps
  place((:), front, (0, y2), "long-1")
  spin((0, y2), top, bottom)
  label(0, label-y2, [$I_1 = #qty[1][kg m^2]$])

  // Axe longitudinal, bras écartés
  let arms-out = (shoulder-r: (abduction: 90deg), shoulder-l: (abduction: 90deg))
  place(arms-out, front, (3.6, y2), "long-2")
  spin((3.6, y2), top, bottom)
  label(3.6, label-y2, [$I_2 = #qty[2][kg m^2]$])

  // Axe antéropostérieur
  place((:), front, (7.4, y2), "antero")
  rotation((7.4, y2))
  label(7.4, label-y2, [$I_3 = #qty[14][kg m^2]$])
})
