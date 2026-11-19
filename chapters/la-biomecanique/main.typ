#import "../../common/lib.typ": *

= Biomécanique et Mécanique

#learning-objectives((
  "Avoir un aperçu large de la biomécanique",
  "Connaître les sous-disciplines de la mécanique",
  "Différencier masse, poids, gravité",
  "Savoir retrouver l'unité d'une entité mécanique",
))

#tague-questions([
  - "Tague (Encore) ce livre de biomécanique"
    - Chapitre 1: Q15, 19, 20
    - Chapitre 36
])

== Définir la biomécanique
La biomécanique est un vaste champ.
Le chapitre 1 du #Livre vous donne un large aperçu.
Le cadre de ce cours va se restreindre aux applications sportives de la biomécanique en s'intéressant particulièrement à la technique (performance), aux équipements et aux causes des blessures.

#figure(
  scaled-include(path("media/diversite-biomecanique.typ"), width: 85%),
  caption: [Diagramme résumé de la diversité en biomécanique],
)

== Petit regard sur la mécanique
La science en amont de la biomécanique est la mécanique des systèmes multicorps (science du mouvement des systèmes composés de plusieurs corps articulés).
La mécanique se divise elle-même en plusieurs sous-disciplines que l'on peut étudier séparément pour des questions de simplicité:

#figure(
  scaled-include(path("media/sous-disciplines-mecanique.typ"), width: 60%),
  caption: [Sous-disciplines de la mécanique],
)

La *cinématique* (on retrouve _cinéma_) est l'étude du mouvement des corps en faisant abstraction des causes de ce mouvement.
Elle fait appel à la mesure ce que l'enseignant peut voir: position, vitesse de déplacement et #link("https://fr.wikipedia.org/wiki/Acc%C3%A9l%C3%A9ration")[accélération] pour des mouvements en translation (aussi dits linéaires) ou en rotation (angulaires).
Si ces entités cinématiques font partie de la vie quotidienne (#eg, vitesse d'une course, longueur d'un saut), elles ont des définitions précises et sont liées entre-elles par des relations mathématiques.

La *géométrie des masses* s'intéresse quant à elle à la répartition de la matière des corps.
S'il est facile de connaître sa masse totale à l'aide d'un pèse-personne, il est tout autant important en biomécanique de connaître la masse de chacun des segments (#eg, bras, pied, tête) ainsi que l'équivalent de la masse en rotation, le moment d'inertie.
Il sera aussi question à ce moment du cours d'utiliser le bon langage et par exemple ne pas confondre le poids et la masse.

Lorsque l'on associe la cinématique à la géométrie des masses, on obtient la *cinétique*.
La cinétique est l'étude du mouvement en considérant leurs inerties (masse et moment d'inertie).
Lancé une balle de tennis ou une boule de 7.26 kg en athlétisme ne demande pas les mêmes qualités!
De même un tapis ne va pas avoir la même déformation si un enfant ou un adulte tombe dedans.
Les termes associés à la cinétique sont quantité de mouvement (pour des mouvements en translation), quantité de rotation ou moment cinétique (pour des mouvements angulaires) et l'énergie cinétique.

La dernière sous-discipline est l'analyse des *forces* qui sont les causes du mouvement.
Que ce soit les forces développées par les muscles ou la force de contact entre le pied et le sol lors de la course, les forces sont des entités abstraites qu'il n'est pas aisé de mesurer lors d'un cours d'éducation physique.

La description complète du mouvement et de ses causes, c'est-à-dire à la fois l'analyse du mouvement et des forces, s'appelle la dynamique.
Des principes existent pour lier la cinétique aux forces qui ont été énoncées par Newton et Euler.
C'est pourquoi ces principes portent le nom de 2#super[nde] loi de Newton (ou principe fondamental de la dynamique) et principe d'Euler (ou théorème du moment cinétique).

== Quelques information avant le mouvement
Le langage mathématique peut sembler bien austère pour certains avec des #link("https://fr.wikipedia.org/wiki/Alphabet_grec#Les_principales_lettres")[lettres grecques], des scalaires, des vecteurs et autres entités qui ont chacune leurs règles de calcul.
Certains #link("https://fr.wikipedia.org/wiki/Table_des_symboles_math%C3%A9matiques")[symboles] ou lettres sont couramment utilisés pour représenter une entité physique : $m$ pour la masse, $v$ pour la vitesse, $alpha$, $beta$, $gamma$ (_alpha_, _beta_, _gamma_) pour des angles, etc.
Toutefois $alpha$ symbolise parfois un angle et d'autres fois l'accélération angulaire, $gamma$ un angle ou une accélération linéaire.
Ainsi chaque terme doit être défini et il est plus important d'avoir une représentation d'un théorème et des exemples pour illustrer ses conséquences plutôt qu'une succession de lettres et opérateurs mathématiques que l'on peut retrouver aisément dans un formulaire.

=== Unités du Système International
Les entités physiques se mesurent et se quantifient.
Chaque valeur numérique doit être associée avec leur unité.
Comme il existe différents systèmes d'unité (#eg, système métrique, système impérial) il existe des normes internationales.
Dans le système international les unités fondamentales sont le *mètre* $[#unit[m]]$ (unité de distance), le *kilogramme* $[#unit[kg]]$ (unité de masse) et la *seconde* $[#unit[s]]$ (pour le temps).
Toutes les autres unités découlent de ces trois unités fondamentales.
Il va alors falloir *convertir* toutes les grandeurs de distance, masse et temps en $[#unit[m]]$, $[#unit[kg]]$ et $[#unit[s]]$ avant d'effectuer tous les calculs.
Il est possible de retrouver l'unité d'un paramètre si l'on connait son expression mécanique.

#interesting-note[
  Prenons l'exemple de la vitesse.
  Pour calculer la vitesse d'un coureur il faut connaître la distance parcourue et le temps mis pour la parcourir.
  On calcule ainsi la vitesse comme la distance $[#unit[m]]$ divisée par le temps $[#unit[s]]$.
  La vitesse a donc comme unité $["m/s"]$ ou $"m.s"^(-1)$ (un exposant négatif signifie "diviser par").
]

On pourrait répéter cet exemple sur des entités comme la surface, le volume, l'impulsion, le moment cinétique, etc.
#figure(two-columns-table(
  [Surface],
  [$[#unit[m^2]]$],
  [Volume],
  [$[#unit[m^3]]$],
  [Vitesse],
  [$"[m/s]"$, $"[m·s"^(-1)"]"$],
  [Accélération],
  [$"[m/s/s]"$, $"[m/s"^(2)"]"$, $"[m·s"^(-2)"]"$],
))

Un exemple plus complexe est la force.
Selon la seconde loi de Newton, que nous détaillerons par la suite, la force est égale au produit de la masse $[#unit[kg]]$ par l'accélération $[#unit[m s^-2]]$.
Plutôt que d'écrire ou dire $[#unit[kg m s^-2]]$ l'unité de la force a été appelée le Newton #unit[N] tel que #qty[1][N] par définition est égale à #qty[1][kg m s^-2].
D'autres unités sont utiles à connaître et reprennent parfois le nom d'illustres scientifiques:


#figure(two-columns-table(
  [Angle radian],
  [$[#unit[rad]]$],

  [Vitesse angulaire],
  [$[#unit[rad / s]]$],

  [Force (#Newton)],
  [$[#unit[N]] = [#unit[kg m / s^2]]$],

  [Fréquence (#Hertz)],
  [$[#unit[Hz]] = [#unit[1 / s]]$],

  [Pression (#Pascal)],
  [$[#unit[Pa]] = [#unit[N / m^2]]$],

  [Travail & énergie (#Joule)],
  [$[#unit[J]] = [#unit[N m]] = [#unit[W s]] = [#unit[kg m^2 / s^2]]$],

  [Puissance (#Watt)],
  [$[#unit[W]] = [#unit[J / s]]$],
))

Le #Newton, #Watt, #Pascal, #Joule ou #Hertz sont toutes des unités qui portent le nom de scientifiques illustres et s'écrivent de ce fait en majuscule à la différence des autres qui sont en minuscule.

=== Poids masse et gravité

#see-handbook[Chapitre 3.1]


Bien qu'ils soient utilisés à tort et à travers dans le langage courant, ces termes ont un sens précis en biomécanique.
La #link("https://fr.wikipedia.org/wiki/Masse")[*masse*] est une propriété fondamentale de la matière et s'exprime en kilogrammes (kg).
C'est-à-dire que la masse ne change quelle que soit notre position sur Terre ou sur la Lune.
Le #link("https://www.techno-science.net/?onglet=glossaire&definition=1676")[*poids*] est l'action qui s'exerce sur un corps immobile au voisinage de la Terre.
Cette *force* s'applique au centre de gravité du corps et sa direction est verticale dirigée vers le bas.
Le poids s'exprime en Newton $["N"]$: c'est une force.
Le poids $arrow(P)$ d'un objet est proportionnel à sa masse m:
$ arrow(P)= m arrow(g) $


où $g$ est le vecteur de gravité d'intensité $#qty[9.8][m / s^2]$.
La gravité est une accélération.
On retrouve le produit masse par accélération qui donne une force.

#figure(
  scaled-include(path("media/vecteur-poids.typ"), width: 50%),
  caption: [Représentation du vecteur poids],
)

L'intensité de la gravité $norm(arrow(g))$ (notez les doubles barres verticales qui désigne la norme, longueur ou intensité d'un vecteur) dépend de la constante universelle de la gravitation  ($G = #qty[6.67310e-11][UI]$), de la masse de la Terre ($M = #qty[5.98e24][kg]$) et de la distance entre l'objet et le centre de masse de la Terre ($R$).
Voici le développement mathématique pour les plus curieux.

La norme du poids est égale au produit de la constante universelle de gravitation notée G, de la masse de la terre $M$ et de la masse de l'objet de masse $m$, le tout divisé par la distance qui sépare les centres de masse des deux objets, $R$, au carré: $norm(arrow(P)) = (G M m) / R^2$.

D'après la définition du vecteur poids ($arrow(P) = m arrow(g)$), il est possible d'écrire $norm(m arrow(g)) = (G M m) / R^2$ et ainsi, en divisant par la masse de l'objet des deux côtés de l'équation, on obtient: $norm(arrow(g)) = (G M) / R^2$.

Par cette équation on montre que la gravité n'est pas la même sur tous les points de la Terre car la Terre n'est pas exactement ronde et qu'il y a des points plus ou moins hauts.
De même, la gravité ne sera pas la même sur une autre planète comme sa masse et son rayon sont différents.

#interesting-note[
  Par exemple, avec les informations données précédemment vous pouvez calculer l'intensité de la gravité au niveau de la mer latitude #to-degree(0) c'est-à-dire à l'équateur ($R = #qty[6356.75][km]$) puis latitude #to-degree(90) (comme la Terre n'est pas ronde du fait de sa rotation sur elle-même $R = #qty[6378.135][km]$) ou encore la gravité sur la Lune ($M = #qty[7.349e22][kg]$ et $R = #qty[1737.3][km]$).
  N'oubliez pas d'exprimer les distances dans l'unité internationale le $[#unit[m]]$ tel que #qty[1][km] représente #qty[1000][m].
]

#figure(
  scaled-include(path("media/gravite-latitude.typ"), width: 80%),
  caption: [Intensité de la gravité selon la latitude],
)

Dans la majorité des calculs si l'intensité de la gravité n'est pas donnée on prend #qty[9.8][m / s^2] ou #qty[9.81][m / s^2].
On peut répéter ce calcul pour d'autres planètes du système solaire et on obtiendra les valeurs moyennes suivantes:

#figure(two-columns-table(
  [Saturne],
  [$g = #qty[8.96][m / s^2]$],

  [Jupiter],
  [$g = #qty[23.12][m / s^2]$],

  [Neptune],
  [$g = #qty[11.5][m / s^2]$],

  [Mars],
  [$g = #qty[3.69][m / s^2]$],

  [Lune],
  [$g = #qty[1.622][m / s^2]$],
))

#complementary-questions[
  + La cinématique est l'étude du mouvement des corps en :
    + faisant abstraction des causes du mouvement
    + considérant les causes du mouvement

]

