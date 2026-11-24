#import "kinogramme-salto.typ": *


// Salto avant avec élan : la posture change peu pendant l'appel; le moment
// cinétique vient surtout de la quantité de mouvement de la course,
// « bloquée » par l'appui des pieds.

// Appel (hanche, genou, tronc, inclinaison, épaule) : bras levés, ils bougent
// peu; au décollage, les bras sont à hauteur de la tête
#let appel-start = (30deg, 40deg, -5deg, -2deg, 160deg)
#let takeoff = (5deg, 5deg, 5deg, 12deg, 135deg)
// Réception debout, jambes légèrement fléchies
// Inclinaison choisie pour que le centre de masse soit au milieu des pieds
#let landing = grounded(15deg, 20deg, 5deg, 4.6deg, 90deg)

#let (x-takeoff, x-landing) = (4.0, 13.9)

#salto-kinogram(
  (
    (running("r"), place-feet(0.0)),
    // Dernière foulée : les bras montent déjà pour préparer l'appel
    (running("l") + (shoulder-r: 110deg, shoulder-l: 110deg, elbow-r: 25deg, elbow-l: 25deg), place-feet(1.4)),
    (grounded(..appel-start), place-feet(2.9)),
    (grounded(..takeoff), place-feet(x-takeoff)),
    // Phase aérienne : le centre de masse décrit une parabole
    ..flight(
      (
        // Juste après le décollage : tronc encore assez vertical, jambes à
        // peine fléchies
        airborne(40deg, 50deg, 45deg, 130deg, 20deg),
        airborne(135deg, 120deg, 130deg, 60deg, 60deg),
        airborne(210deg, 120deg, 130deg, 60deg, 60deg),
        airborne(285deg, 90deg, 100deg, 80deg, 40deg),
        airborne(315deg, 65deg, 70deg, 90deg, 30deg), // ouverture
        airborne(345deg, 40deg, 45deg, 100deg, 20deg),
      ),
      com-on-ground(grounded(..takeoff), x-takeoff),
      com-on-ground(landing, x-landing),
      1.5,
      adjust: (0, 0, 0, 0, -0.15, -0.35), // fin du vol un peu plus basse
    ),
    (landing, place-feet(x-landing)),
  ),
  appel: (2, 3),
  // De l'arrivée des pieds à leur décollage
  detail: range(6).map(i => grounded-between(appel-start, takeoff, i / 5)),
  phases: (
    (0, 1, [course d'élan]),
    (4, 9, [phase aérienne]),
    (10, 10, [réception]),
  ),
)
