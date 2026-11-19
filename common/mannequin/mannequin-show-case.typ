// Aperçu du mannequin complet (femme et homme) sous plusieurs angles.
#import "mannequin.typ": mannequin
#import "@preview/cetz:0.4.1"

Female:
#cetz.canvas(length: 1cm, {
  mannequin(view: (azimuth: 0deg), name: "face", sex: "female")
  mannequin(
    origin: (3, 0),
    view: (azimuth: -90deg),
    name: "profil",
    sex: "female",
  )
  mannequin(origin: (6, 0), view: (azimuth: 180deg), name: "dos", sex: "female")
  mannequin(
    origin: (9, 0),
    view: (azimuth: -35deg, elevation: 10deg),
    pose: (shoulder-r: (abduction: 90deg)),
    name: "trois-quarts",
    sex: "female",
  )
})

Male :
#cetz.canvas(length: 1cm, {
  mannequin(view: (azimuth: 0deg), name: "face", sex: "male")
  mannequin(
    origin: (3, 0),
    view: (azimuth: -90deg),
    name: "profil",
    sex: "male",
  )
  mannequin(origin: (6, 0), view: (azimuth: 180deg), name: "dos", sex: "male")
  mannequin(
    origin: (9, 0),
    view: (azimuth: -35deg, elevation: 10deg),
    pose: (shoulder-r: (abduction: 90deg)),
    name: "trois-quarts",
    sex: "male",
  )
})
