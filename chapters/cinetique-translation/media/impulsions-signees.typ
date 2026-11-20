#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Force au cours du temps : A) impulsion nulle (aires positive et négative
// égales), B) impulsion positive (l'aire positive l'emporte).
#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  let force = palette.red
  let time = palette.green
  let positive = palette.gold
  let negative = palette.blue

  // Courbe faite d'arches en demi-sinus : (durée, amplitude); une amplitude
  // négative donne une arche sous l'axe du temps.
  let panel(x0, bumps, label) = {
    let width = bumps.map(b => b.at(0)).sum()
    let (x-max, y-max) = (width + 1.5, 2.1)

    let t0 = 0
    for (duration, amplitude) in bumps {
      let points = range(0, 41).map(i => {
        let u = i / 40
        (x0 + t0 + u * duration, amplitude * calc.sin(u * 180deg))
      })
      let shade = if amplitude > 0 { positive } else { negative }
      // Aire sous la courbe
      line((x0 + t0, 0), ..points, (x0 + t0 + duration, 0), close: true, fill: shade.fill, stroke: none)
      line(..points, stroke: 1.5pt + shade.line)
      content(
        (x0 + t0 + duration / 2, amplitude / 2.6),
        text(size: 16pt, weight: "bold", fill: shade.text, if amplitude > 0 [+] else [−]),
      )
      t0 += duration
    }

    // Axes
    let axis(from, to, shade) = line(from, to, stroke: 1.5pt + shade.line, mark: (
      end: "stealth",
      fill: shade.line,
      stroke: shade.line,
    ))
    axis((x0, 0), (x0 + x-max, 0), time)
    axis((x0, -y-max), (x0, y-max), force)
    // Au-dessus de l'axe : sous l'axe se trouve l'aire négative
    content((x0 + x-max, 0), anchor: "south-east", padding: 0.15, text(
      fill: time.text,
    )[Temps $[#unit[s]]$])
    content((x0, y-max), anchor: "south", padding: 0.1, text(
      fill: force.text,
    )[Force $[#unit[N]]$])

    content((x0 + x-max / 2, -y-max - 0.2), anchor: "north", text(
      weight: "semibold",
    )[#label])
  }

  // A) mêmes arches de part et d'autre : les aires s'annulent
  panel(0, ((2, 1.5), (2, -1.5)), [A) Impulsion nulle])
  // B) l'arche positive est plus grande que l'arche négative
  panel(6.9, ((2.8, 1.9), (1.3, -0.55)), [B) Impulsion positive])
})
