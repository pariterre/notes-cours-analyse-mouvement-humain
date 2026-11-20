// Données de l'exercice sur l'abduction des bras, partagées par le tableau de
// calcul (@tab:raising-arms) et les graphiques (abduction-bras-graphiques.typ).

#let abduction-dt = 0.05 // intervalle entre deux images (s)
#let abduction-mass = 6.4 // masse des deux membres supérieurs (kg) : 2 × 5 % de 64 kg

// Position verticale du centre de masse des membres supérieurs (m), mesurée
// à partir d'une caméra. Écrite en texte pour garder trois décimales à
// l'affichage.
#let abduction-positions = (
  "0.000",
  "0.000",
  "0.000",
  "0.001",
  "0.005",
  "0.016",
  "0.038",
  "0.078",
  "0.136",
  "0.212",
  "0.298",
  "0.384",
  "0.460",
  "0.518",
  "0.558",
  "0.580",
  "0.591",
  "0.595",
  "0.596",
  "0.596",
  "0.596",
)

/// Instant de l'image k (à partir de 0), écrit avec deux décimales
#let abduction-time(k) = {
  let hundredths = int(calc.round(k * abduction-dt * 100))
  let decimals = str(calc.rem(hundredths, 100))
  (
    str(calc.quo(hundredths, 100))
      + "."
      + if decimals.len() < 2 { "0" + decimals } else { decimals }
  )
}
