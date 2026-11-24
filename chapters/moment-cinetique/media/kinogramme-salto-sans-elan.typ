#import "kinogramme-salto.typ": *


// Salto avant sans élan (à l'arrêt) : pas de quantité de mouvement à
// « bloquer ». Pendant l'appel, les segments distaux (bras, tronc) balaient
// une grande amplitude vers l'avant et le bas pour créer le moment cinétique.
// L'appel commence corps en extension, bras tendus derrière la tête; les
// jambes fléchissent, puis s'étendent pendant que les bras passent à l'avant
// et que le corps bascule vers l'avant.

// Poses clés de l'appel (hanche, genou, tronc, inclinaison, épaule)
#let keys = (
  (0deg, 0deg, -8deg, 0deg, 200deg), // extension, bras derrière la tête
  (45deg, 65deg, 10deg, 8deg, 170deg), // flexion des jambes, bras levés
  // Décollage : genoux encore légèrement fléchis, corps basculé, bras à
  // hauteur de la tête; centre de masse au-dessus de l'avant-pied
  (25deg, 15deg, 25deg, 13deg, 140deg),
)

/// Pose de l'appel à l'instant u (de 0 à 1), interpolée entre les poses clés
#let appel-at(u) = {
  let k = calc.min(int(u * (keys.len() - 1)), keys.len() - 2)
  let local = u * (keys.len() - 1) - k
  grounded-between(keys.at(k), keys.at(k + 1), local)
}

// Réception debout, un peu plus fléchie qu'avec élan
// Inclinaison choisie pour que le centre de masse soit au milieu des pieds
#let landing = grounded(30deg, 40deg, 10deg, 6.5deg, 90deg)

#let (x-takeoff, x-landing) = (2.7, 13.6)

#salto-kinogram(
  (
    // Appel
    (appel-at(0), place-feet(0.0)),
    (appel-at(0.5), place-feet(1.3)),
    (appel-at(1), place-feet(x-takeoff)),
    // Phase aérienne : le centre de masse décrit une parabole
    ..flight(
      (
        // Juste après le décollage : les jambes commencent à peine à se fléchir
        airborne(55deg, 50deg, 45deg, 120deg, 20deg),
        airborne(155deg, 120deg, 130deg, 60deg, 60deg),
        airborne(225deg, 120deg, 130deg, 60deg, 60deg),
        airborne(295deg, 90deg, 100deg, 80deg, 40deg),
        airborne(322deg, 65deg, 70deg, 90deg, 30deg), // ouverture
        airborne(350deg, 40deg, 45deg, 100deg, 20deg),
      ),
      com-on-ground(appel-at(1), x-takeoff),
      com-on-ground(landing, x-landing),
      1.4,
      adjust: (0, 0, 0, 0, -0.15, -0.35), // fin du vol un peu plus basse
    ),
    (landing, place-feet(x-landing)),
  ),
  appel: (0, 2),
  detail-spacing: 1.55,
  detail: range(7).map(i => appel-at(i / 6)),
  phases: (
    (3, 8, [phase aérienne]),
    (9, 9, [réception]),
  ),
)
