#import "../../common/lib.typ": *

= Un bref aperçu des lois de Newton

#learning-objectives(
  (
    "Savoir énoncer les trois principes de Newton",
    "Avoir une représentation des trois principes du mouvement en translation",
  ),
)

#see-handbook[Chapitre 13.2]

Le versant de la biomécanique qui nous intéresse repose essentiellement sur les #link("https://fr.wikipedia.org/wiki/Lois_du_mouvement_de_Newton")[principes de Newton] (1642-1727).
Ces principes parfois appelés lois sont au nombre de trois:

- 1ère loi: Principe d'inertie
- 2ème loi: Principe fondamental de la dynamique en translation
- 3ème loi: Principe d'action --- réaction

L'objet ici est d'avoir une représentation de ces trois principes pas d'en comprendre les subtilités ou de savoir les appliquer.
Ils reviendront tout au long du cours.

== Principe d'Inertie
#quote[
  Tout corps persévère dans l'état de repos ou de mouvement
  uniforme en ligne droite dans lequel il se trouve, à moins que quelque
  force n'agisse sur lui, et ne le contraigne à changer d'état.
]

Donnons des exemples.
Lorsque l'on se déplace sur la glace en patins et qu'on arrête de patiner, on continue sa trajectoire en ligne droite et il faut une longue distance pour s'arrêter.
Personne ne se met à tourner subitement sans faire d'action.
Il est sera de même avec une voiture qui roule sur une plaque de glace ou fait de l'aquaplaning; le voiture ne ralentit pas et poursuit en ligne droite bien que l'on tourne le volant.
Dans ces deux cas la force de frottement entre le sol (e.g. glace) et les patins ou les pneus est très faible alors le principe d'inertie s'applique.
Un autre exemple est la trajectoire d'un satellite.
Les satellites qui sont au-delà de l'atmosphère n'ont pas besoin de force propulsive.
Selon la vitesse à laquelle ils sont mis en orbite, ils vont être géostationnaire, c'est-à-dire se déplaçant à la même vitesse de rotation que le Terre ou avoir une vitesse relative à la Terre.
Comme il n'y a pas d'air qui créerait une force frottement, ces satellites vont conserver leur vitesse jusqu'à ce qu'ils rencontrent un débris spatial!

#figure(
  caption: [Conservation du mouvement en microgravité],
  kind: "video",
  supplement: "Vidéo",
)[
  #todo[https://www.youtube.com/watch?v=0z2CaNvF0x4&feature=related]
  #todo[https://www.youtube.com/watch?v=N6ZJnIJRUCI&feature=related]
]

== Principe fondamental de la dynamique
#quote[
  Soit un corps de masse $m$ constante, l'accélération subie par ce corps dans un référentiel galiléen est proportionnelle à la résultante des forces qu'il subit, et inversement proportionnelle à sa masse.
]

L'équation associée à ce principe est $sum_i arrow(F_i) = m arrow(a)$ qui se lit: la somme (#sym.sum) des forces extérieures $F_i$ ("$i$" car il y a souvent plusieurs forces appliquées à un système) est égale au produit de la masse $m$ par l'accélération du centre de masse du système $a$.
La formulation mathématique est un moyen d'écrire moins tout en restant très précis dans le sens.
On peut décrire ce principe par des phrases plus compréhensibles:

- _Plus un objet est lourd plus il faudra de force pour l'accélérer._
  Ainsi, pour un même moteur, une voiture légère aura une meilleure accélération qu'une voiture lourde.
  Les meneurs en basket sont souvent plus petits que les autres joueurs et ont des capacités d'accélérations plus grandes du fait qu'ils sont plus légers.
- _Pour une même force un objet léger aura une plus grande accélération_.

#interesting-note[
  Par exemple, il suffit d'une règle et des billes de masses différentes.
  En poussant en même temps les billes à l'aide de la règle, je leur applique une force similaire qui va les accélérer.
  La bille de masse plus importante va avoir une accélération moindre donc une vitesse après la poussée moins importante et ira au final moins loin que la bille légère.

  #figure(
    scaled-include(path("media/billes-regle.typ"), width: 40%),
    caption: [Expérience simple de la seconde loi de Newton.
      Trois billes de masses différentes sont poussées en même temps par la même impulsion de force.
      Laquelle va le plus loin?],
  )
]


== Principe d'action-réaction
#quote[
  Tout corps $A$ exerçant une force sur un corps $B$ subit une force d'intensité égale, de même direction mais de sens opposé, exercée par le corps $B$.
]

Lorsque je m'adosse à un mur, j'exerce une force d'action contre le mur et le mur exerce la force opposée sur moi.
De même lorsque je suis debout j'applique une force sur le sol qui a sa réaction sur moi.
Pour savoir si on s'intéresse à l'action ou la réaction il est important de bien définir son système.

== Définir un système
Dans la seconde loi de Newton ou principe fondamental de la dynamique on s'intéresse aux forces externes appliquées sur un système et ce sera le plus souvent celles-ci qu'il faudra définir.
Si on s'intéresse au système _sujet_ alors les forces extérieures sont son poids (force toujours présente dans nos analyses) et la force de réaction du sol, c'est-à-dire la force que le sol exerce sur le sujet.

Pour ne pas oublier d'éléments il faut répondre à ceux quelques questions:
+ Quel est le *nom* du système?
  Quels sont les éléments compris dans ce système?
+ Dans quel #link("https://fr.wikipedia.org/wiki/R%C3%A9f%C3%A9rentiel_%28physique%29")[*référentiel*] se trouve-t-on? [La notion de référentiel est expliquée dans le  @sec:reference-frame-and-vectors]
+ Quel est *l'état* du système au temps initial $t_i = #qty[0][s]$ (ou d'autres instants connus)? [L'état correspond à la position et la vitesse dans le référentiel définit précédemment]
+ Quelles sont les *forces extérieures* appliquées au système? [Le poids sera toujours présent et dès qu'un système est en contact, il y a aura des forces de réaction].
  Il faut donc compter le nombre de contacts.

L'étape suivant consiste à faire un schéma pour regrouper toutes ces informations.
A partir de là on pourra commencer à réfléchir et répondre à des questions!
