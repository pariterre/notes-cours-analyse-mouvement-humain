// Poses du squat jump partagées par le kinogramme (Figure VIII.9) et la
// construction de la résultante cinétique (Figure VIII.10).
//
// Une pose est décrite par (hanche, genou, tronc, inclinaison) :
// - les pieds restent à plat : la cheville compense l'inclinaison du tibia
//   (genou - hanche) et l'inclinaison de tout le corps vers l'avant ;
// - l'inclinaison (`lean`) sert à placer le centre de masse au-dessus des
//   pieds.
//
// De t_i à t_f : le tronc se redresse (il recule et monte), les hanches
// avancent (les cuisses montent vers l'avant) et les tibias se redressent
// (les genoux reculent : les jambes montent vers l'arrière).

#let squat-start = (75deg, 105deg, 40deg, 5deg) // t_i (accroupi)
#let squat-end = (30deg, 50deg, 0deg, 7deg) // t_f (en extension)

#let squat-pose(hip, knee, trunk, lean) = (
  global: (pitch: lean),
  hip-r: hip,
  hip-l: hip,
  knee-r: knee,
  knee-l: knee,
  ankle-r: knee - hip + lean,
  ankle-l: knee - hip + lean,
  trunk: trunk,
  head: -5deg,
  shoulder-r: -20deg,
  shoulder-l: -20deg,
  elbow-r: 20deg,
  elbow-l: 20deg,
)

/// Pose interpolée entre t_i (u = 0) et t_f (u = 1)
#let squat-pose-at(u) = squat-pose(..squat-start.zip(squat-end).map(((a, b)) => a + (b - a) * u))
