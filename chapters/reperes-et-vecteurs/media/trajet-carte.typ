#import "../../../common/lib.typ": *
#import "@preview/cetz:0.4.1"


// Carte schématique d'un trajet (Montréal, Québec, Côte-Nord, Gaspésie).
// Les positions sont les vraies coordonnées géographiques, projetées de façon
// équirectangulaire autour de 47° N : distances et directions sont donc
// respectées, ce qui donne un sens à l'échelle et à la rose des vents.

#let km-per-unit = 50
#let (lat0, lon0) = (45.2, -74.0)
#let project((lat, lon)) = (
  (lon - lon0) * calc.cos(47deg) * 111.32 / km-per-unit,
  (lat - lat0) * 111.32 / km-per-unit,
)

// (latitude, longitude)
#let cities = (
  montreal: (45.50, -73.57),
  trois-rivieres: (46.34, -72.54),
  quebec: (46.81, -71.21),
  saguenay: (48.43, -71.07),
  sherbrooke: (45.40, -71.89),
  riviere-du-loup: (47.84, -69.53),
  rimouski: (48.45, -68.52),
  baie-comeau: (49.22, -68.15),
  matane: (48.85, -67.53),
  sainte-anne: (49.12, -66.49),
  gaspe: (48.83, -64.48),
  perce: (48.52, -64.21),
  campbellton: (48.00, -66.67),
  edmundston: (47.37, -68.33),
)

// Fleuve et estuaire du Saint-Laurent (tracé simplifié)
#let north-shore = (
  (45.62, -73.45),
  (46.10, -72.85),
  (46.40, -72.40),
  (46.88, -71.15),
  (47.45, -70.30),
  (48.10, -69.70),
  (48.62, -68.95),
  (49.15, -68.30),
  (49.30, -67.40),
  (49.75, -66.60),
  (50.15, -65.50),
  (50.25, -64.00),
  (50.25, -63.22),
)
// Côte sud, parcourue d'est en ouest : Nouveau-Brunswick (depuis le bord
// droit de la carte), baie des Chaleurs, tour de la Gaspésie, puis rive sud
// de l'estuaire et du fleuve jusqu'à Montréal.
#let south-shore = (
  (45.95, -63.22),
  (46.22, -64.54), // Shediac
  (46.68, -64.87), // Richibucto
  (47.05, -65.00), // Miramichi
  (47.51, -64.91), // Tracadie
  (47.95, -64.55), // Miscou
  (47.80, -64.95), // Caraquet
  (47.62, -65.65), // Bathurst
  (47.90, -65.85), // Belledune
  (48.06, -66.37), // Dalhousie
  (48.00, -66.67), // Campbellton (fond de la baie)
  (48.10, -66.13), // Carleton
  (48.16, -65.86), // New Richmond
  (48.03, -65.25), // Paspébiac
  (48.18, -64.97), // Port-Daniel
  (48.35, -64.68), // Chandler
  (48.52, -64.21), // Percé
  (48.63, -64.27), // Barachois
  (48.76, -64.38), // Douglastown
  (48.83, -64.48), // Gaspé (fond de la baie)
  (48.85, -64.38), // rive nord de la baie (Forillon)
  (48.75, -64.17), // Cap Gaspé
  (48.86, -64.20), // Cap-des-Rosiers
  (49.00, -64.38), // Rivière-au-Renard
  (49.23, -65.13), // Grande-Vallée
  (49.23, -65.73), // Mont-Louis
  (49.12, -66.49), // Sainte-Anne-des-Monts
  (48.85, -67.53), // Matane
  (48.47, -68.50), // Rimouski
  (47.88, -69.48), // Rivière-du-Loup
  (47.20, -70.40),
  (46.78, -71.20),
  (46.30, -72.55),
  (45.85, -73.10),
  (45.55, -73.50),
)

// Pointe ouest de l'Île-du-Prince-Édouard (coupée au bord droit)
#let pei = (
  (46.55, -63.22),
  (46.80, -63.75),
  (47.06, -64.00), // North Cape
  (46.75, -64.38),
  (46.45, -64.10),
  (46.40, -63.79), // Summerside
  (46.30, -63.22),
)

#cetz.canvas(length: 0.8cm, {
  import cetz.draw: *

  let ink = palette.neutral.text
  let water = palette.blue
  let route = palette.red

  // Cadre de la carte
  let (x-max, y-max) = (16.4, 11.6)
  rect((0, 0), (x-max, y-max), fill: palette.neutral.fill, stroke: 0.6pt + palette.neutral.line)

  // Eau : le fleuve, l'estuaire et le golfe forment une seule surface,
  // fermée par le bord droit de la carte. Chaque côte est lissée séparément.
  let shore-stroke = 0.8pt + water.line.transparentize(40%)
  let smooth(points, ..style) = catmull(..points.map(project), tension: 0.4, ..style)
  merge-path(fill: water.fill, stroke: none, close: true, {
    smooth(north-shore)
    smooth(south-shore)
  })
  smooth(north-shore, stroke: shore-stroke)
  smooth(south-shore, stroke: shore-stroke)
  merge-path(fill: palette.neutral.fill, stroke: none, close: true, smooth(pei))
  smooth(pei, stroke: shore-stroke)

  // Noms de régions
  let region(coords, body, ..style) = content(project(coords), text(
    size: 7.5pt,
    style: "italic",
    ..style,
    body,
  ))
  region((48.72, -65.55), [Gaspésie], fill: ink)
  region((46.55, -66.6), [Nouveau-Brunswick], fill: ink)
  region((47.55, -63.95), align(center)[Golfe du \ Saint-Laurent], fill: water.text)
  content(
    project((49.78, -64.6)),
    angle: 5deg,
    text(size: 7.5pt, fill: water.text, style: "italic")[Fleuve Saint-Laurent],
  )

  // Villes de contexte (hors trajet)
  let context-label(key, anchor, body) = {
    let p = project(cities.at(key))
    circle(p, radius: 0.07, fill: ink, stroke: none)
    content(p, anchor: anchor, padding: 0.12, text(size: 7pt, fill: ink, body))
  }
  context-label("saguenay", "west", [Saguenay])
  context-label("trois-rivieres", "east", [Trois-Rivières])
  context-label("sherbrooke", "west", [Sherbrooke])

  // Trajet
  let stops = (
    "montreal",
    "quebec",
    "baie-comeau",
    "matane",
    "sainte-anne",
    "gaspe",
    "perce",
    "campbellton",
    "edmundston",
    "riviere-du-loup",
    "quebec",
    "montreal",
  )
  let path = stops.map(k => project(cities.at(k)))
  line(
    ..path,
    stroke: (paint: route.line, thickness: 1.8pt, join: "round", cap: "round"),
  )

  // Étapes du trajet
  let stop-label(key, anchor, body) = {
    let p = project(cities.at(key))
    circle(p, radius: 0.13, fill: white, stroke: 1.4pt + route.line)
    content(p, anchor: anchor, padding: 0.22, text(
      size: 8pt,
      fill: route.text,
      weight: "semibold",
      body,
    ))
  }
  stop-label("montreal", "north-west", [Montréal])
  stop-label("quebec", "north-west", [Québec])
  stop-label("baie-comeau", "south", [Baie-Comeau])
  stop-label("matane", "north", [Matane])
  stop-label("sainte-anne", "south", align(center)[Sainte-Anne-\ des-Monts])
  stop-label("gaspe", "south-west", [Gaspé])
  stop-label("perce", "west", [Percé])
  stop-label("campbellton", "north-west", [Campbellton])
  stop-label("edmundston", "north", [Edmundston])
  stop-label("riviere-du-loup", "south-west", [Rivière-\ du-Loup])

  // Rose des vents (nord)
  let n = (1.0, y-max - 3.0)
  line(
    n,
    (n.at(0), n.at(1) + 1.1),
    stroke: 1.4pt + ink,
    mark: (end: "stealth", fill: ink, stroke: ink, scale: 1.6),
  )
  content((n.at(0), n.at(1) + 1.25), anchor: "south", text(
    size: 9pt,
    fill: ink,
    weight: "bold",
  )[N])

  // Échelle
  let s = (0.6, y-max - 0.8)
  let bar = 100 / km-per-unit
  for i in range(2) {
    rect(
      (s.at(0) + i * bar, s.at(1)),
      (s.at(0) + (i + 1) * bar, s.at(1) + 0.15),
      fill: if i == 0 { ink } else { white },
      stroke: 0.6pt + ink,
    )
  }
  for i in range(3) {
    content((s.at(0) + i * bar, s.at(1) + 0.2), anchor: "south", text(
      size: 7pt,
      fill: ink,
    )[#(i * 100)])
  }
  content((s.at(0) + 2 * bar + 0.15, s.at(1) + 0.08), anchor: "west", text(
    size: 7pt,
    fill: ink,
  )[km])
})
