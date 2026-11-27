#import "../../../common/lib.typ": *
#import "../../../common/mannequin/mannequin.typ": mannequin, mannequin-points
#import "@preview/cetz:0.4.1"


// Traction (chin-up) vue de profil, haut du corps seulement : coudes tendus
// puis coudes fléchis. Le biceps brachial va de l'épaule à la tubérosité du
// radius, juste sous le coude et en avant de l'axe de l'avant-bras. Une loupe
// agrandit le coude : le bras de levier d (distance du coude à la ligne
// d'action du biceps) est très faible coudes tendus, d'où la difficulté du
// début de la traction.

#let muscle = palette.red
#let lever = palette.gold
#let body-color = rgb("#5c6bc0").lighten(25%)
#let size = 7.5
#let k = size / 6 // les recadrages ci-dessous sont donnés pour une taille de 6

#let sub((ax, ay), (bx, by)) = (ax - bx, ay - by)
#let add((ax, ay), (bx, by)) = (ax + bx, ay + by)
#let mul((ax, ay), k) = (ax * k, ay * k)
#let norm((ax, ay)) = calc.sqrt(ax * ax + ay * ay)
#let unit(v) = mul(v, 1 / norm(v))
// Normale antérieure d'un segment de direction u (plan sagittal) : la flexion
// du coude amène l'avant-bras de ce côté.
#let anterior((ux, uy)) = (-uy, ux)

// Un panneau : la barre est en (0, 0) ; `inset-offset` place la loupe par
// rapport au coude ; `crop` = (x-min, y-min, x-max, y-max) garde le haut du corps.
#let chin-up(elbow-flexion, inset-offset, crop) = {
  let pose = (
    shoulder-r: 180deg - elbow-flexion,
    shoulder-l: 180deg - elbow-flexion,
    elbow-r: elbow-flexion,
    elbow-l: elbow-flexion,
  )
  let p = mannequin-points(pose: pose, size: size)
  // Coordonnées à l'écran (vue de profil) : x antérieur, z vers le haut ;
  // la prise (milieu poignet-main) est placée sur la barre.
  let flat(q) = (q.at(0), q.at(2))
  let grip = mul(add(flat(p.wrist-r), flat(p.hand-r)), 0.5)
  let shift = sub((0, 0), grip)
  let at(q) = add(flat(q), shift)

  // Cadre invisible couvrant tout le dessin : fixe l'origine du canevas
  let frame = (-1.2 * size, -1.3 * size, 1.2 * size, 1)

  let drawing = cetz.canvas(length: 1cm, {
    import cetz.draw: *
    rect((frame.at(0), frame.at(1)), (frame.at(2), frame.at(3)), stroke: none)

    mannequin(size: size, origin: shift, view: (azimuth: -90deg), pose: pose, color: body-color)

    // Barre (vue en coupe)
    circle((0, 0), radius: 0.16, fill: palette.dark.fill, stroke: 1.4pt + white)

    // Biceps : de l'épaule à la tubérosité du radius. Proportions réalistes :
    // insertion ≈ 3 % de la taille sous le coude et ≈ 1 % en avant, d'où un
    // bras de levier ≈ 3 fois plus grand coude fléchi à 90°.
    let (shoulder, elbow, wrist) = (at(p.shoulder-r), at(p.elbow-r), at(p.wrist-r))
    let u-arm = unit(sub(elbow, shoulder))
    let u-forearm = unit(sub(wrist, elbow))
    let origin = add(add(shoulder, mul(u-arm, 0.02 * size)), mul(anterior(u-arm), 0.012 * size))
    let insertion = add(add(elbow, mul(u-forearm, 0.03 * size)), mul(anterior(u-forearm), 0.008 * size))
    line(origin, insertion, stroke: (paint: muscle.line, thickness: 2.4pt, cap: "round"))

    // Repère de la loupe sur le mannequin
    let r-spot = 0.3
    circle(elbow, radius: r-spot, stroke: 1pt + palette.neutral.text)

    // Loupe : le mannequin lui-même, agrandi `zoom` fois, vu par une fenêtre
    // circulaire centrée en `c` sur le point `focus` (entre le coude et
    // l'insertion du biceps)
    let c = add(elbow, inset-offset)
    let (zoom, r-inset) = (3.8, 1.5)
    let focus = mul(add(elbow, insertion), 0.5)
    let z(q) = mul(q, zoom) // coordonnées dans le canevas agrandi

    let magnified = cetz.canvas(length: 1cm, {
      import cetz.draw: *
      // Cadre invisible couvrant tout le mannequin agrandi : fixe l'origine
      let reach = 1.5 * size * zoom
      let f = z(focus)
      rect(sub(f, (reach, reach)), add(f, (reach, reach)), stroke: none)

      mannequin(size: size * zoom, origin: z(shift), view: (azimuth: -90deg), pose: pose, color: body-color, hidden: ("head", "neck"))

      // Ligne d'action du biceps (prolongée vers l'origine, au-delà de la loupe)
      let (zi, zo) = (z(insertion), z(origin))
      line(zi, zo, stroke: (paint: muscle.line, thickness: 3pt, cap: "round"))
      circle(zi, radius: 0.08, fill: muscle.line, stroke: none)

      // Bras de levier : perpendiculaire du coude à la ligne d'action
      let dir = unit(sub(zo, zi))
      let ze = z(elbow)
      let t = sub(ze, zi).at(0) * dir.at(0) + sub(ze, zi).at(1) * dir.at(1)
      let foot = add(zi, mul(dir, t))
      line(ze, foot, stroke: 2.4pt + lever.line)
      circle(ze, radius: 0.08, fill: white, stroke: 1.2pt + palette.dark.fill)
      let away = unit(sub(foot, ze))
      content(
        add(foot, mul(away, 0.12)),
        anchor: if away.at(0) < 0 { "east" } else { "west" },
        padding: 0.04,
        box(fill: white.transparentize(20%), inset: 1pt, radius: 2pt, text(
          size: 11pt,
          fill: lever.text,
          weight: "semibold",
        )[$d$]),
      )
    })
    // Fenêtre circulaire : le canevas agrandi, recadré autour de `focus`
    let window = box(
      width: 2 * r-inset * 1cm,
      height: 2 * r-inset * 1cm,
      radius: r-inset * 1cm,
      clip: true,
      fill: white,
      stroke: 1.2pt + palette.neutral.text,
      place(top + left, dx: -(1.5 * size * zoom - r-inset) * 1cm, dy: -(1.5 * size * zoom - r-inset) * 1cm, magnified),
    )

    // Liaison entre le repère et la loupe
    let w = unit(sub(c, elbow))
    line(add(elbow, mul(w, r-spot)), sub(c, mul(w, r-inset)), stroke: 0.8pt + palette.neutral.text)
    content(c, window)
  })

  // Recadrage sur le haut du corps
  let (cx0, cy0, cx1, cy1) = crop
  box(width: (cx1 - cx0) * 1cm, height: (cy1 - cy0) * 1cm, clip: true, place(
    top + left,
    dx: -(cx0 - frame.at(0)) * 1cm,
    dy: -(frame.at(3) - cy1) * 1cm,
    drawing,
  ))
}

#let panel(body, title, subtitle) = align(center, stack(
  spacing: 6pt,
  body,
  text(weight: "semibold", title),
  text(size: 9pt, subtitle),
))

#grid(
  columns: 2,
  column-gutter: 0.3cm,
  align: bottom,
  panel(chin-up(3deg, (-2.4, -0.4), (-4.2, -4.6 * k, 1.1 * k, 0.5)), [Coudes tendus], [bras de levier $d$ très faible]),
  panel(chin-up(85deg, (2.2, -1.4), (-2.6 * k, -4.6 * k, 4.0, 0.5)), [Coudes fléchis], [bras de levier $d$ plus grand]),
)

#v(4pt)
#align(center, cetz.canvas(length: 1cm, {
  import cetz.draw: *
  line((0, 0), (0.7, 0), stroke: (paint: muscle.line, thickness: 3pt, cap: "round"))
  content((0.85, 0), anchor: "west", text(size: 9pt)[Biceps brachial (ligne d'action)])
  line((0, -0.45), (0.7, -0.45), stroke: 2pt + lever.line)
  content((0.85, -0.45), anchor: "west", text(size: 9pt)[Bras de levier $d$ par rapport au coude])
}))
