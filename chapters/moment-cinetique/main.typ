#import "../../common/lib.typ": *

= #moment-cinetique.Name
#learning-objectives((
  [Calculer #moment-cinetique.le de l'ensemble du corps],
  "Comprendre comment créer de la rotation",
  "Connaitre la dynamique de rotation en phase aérienne",
))


== #moment-cinetique.Name d'un solide
#moment-cinetique.article.Le#link("https://fr.wikipedia.org/wiki/Moment_angulaire")[#moment-cinetique.name]#footnote([Les termes _quantité de rotation ($arrow(q)$)_ et _moment cinétique ($arrow(sigma)$)_ sont deux termes sont acceptés; dans ce recueil de notes, nous utilisons le terme _#(moment-cinetique.name)_ avec le symbole $arrow(#moment-cinetique.symbol)$.]) est le paramètre cinétique de rotation qui correspond à la quantité de mouvement pour la translation.
#moment-cinetique.Il fait appel à la vitesse angulaire et au moment d'inertie.
#moment-cinetique.Le s'exprime simplement comme le produit de ces deux entités pour un solide rigide: $ arrow(#moment-cinetique.symbol)_O = I_O arrow(omega), $ expression qui se lit:
#quote[#moment-cinetique.le calculé#moment-cinetique.e en $O$ est égal#moment-cinetique.e au produit du moment d'inertie exprimé par rapport à un axe passant par $O$ avec la vitesse de rotation calculée selon ce même point.]
Une fois de plus, il faut prêter attention au point ou axe d'expression des entités en rotation.

== #moment-cinetique.Name du corps humain
#moment-cinetique.Le du corps fait appel #moment-cinetique.au de tous les segments mais son expression est plus complexe car #if moment-cinetique.feminine [toutes] else [tous] #moment-cinetique.les doivent être exprimé#moment-cinetique.es selon le même centre de rotation.
Ceci revient à prendre la somme #moment-cinetique.des calculé#moment-cinetique.es par rapport aux centres de masse segmentaires ainsi que le moment de leur quantité de mouvement.
Ce moment fait appel à un produit vectoriel entre le vecteur position du centre de masse segmentaire par rapport au centre de rotation et le vecteur quantité de mouvement du segment.
Pour illustrer l'expression mathématique, il faut comprendre que pour avoir une grande quantité de mouvement, il faut mettre en rotation les segments et que les segments distaux, ceux éloignés du centre de rotation, aient une grande vitesse.

#figure(
  scaled-include(path("media/moment-cinetique-corps.typ"), width: 85%),
  caption: [Méthode de calcul #moment-cinetique.du du corps humain : chaque segment contribue par sa propre rotation et par le moment de sa quantité de mouvement.],
)

== Création #moment-cinetique.du
Si on comprend facilement comment créer de la vitesse linéaire avec nos segments, il est plus difficile de se représenter la manière efficace pour créer #moment-cinetique.du surtout en ce qui concerne le moment de la quantité de mouvement.

=== Quantité de mouvement et blocage
Ce premier exemple avec le pingouin illustre le phénomène du croche-pied.
Une personne qui se déplace possède une certaine quantité de mouvement; lorsque que son pied se retrouve bloqué et devient un centre de rotation, ses segments distaux (tronc-tête-bras) ont toujours une quantité de mouvement qui crée #moment-cinetique.un vers l'avant… et elle tombe en tournant vers l'avant.

<_Toc82333039>Vidéo X.1. Rotation par quantité de mouvement et blocage #link("https://fr.youtube.com/watch?v=Rp8Inx5caSs&feature=related")\[1\]

Dans l'exemple ci-dessous le gymnaste réalise un salto avant à partir d'une course d'élan.
La quantité de mouvement de la course d'élan a pour effet la création #moment-cinetique.du lorsque les pieds viennent se bloquer sur le sol au moment de l'appel.
En observant la figure du bas, on remarque qu'il y a peu de changements de posture entre le début et la fin de l'appel.
Les segments ne sont pas mis en rotation de façon significative.
On remarque principalement l'extension des membres inférieurs à l'origine de l'impulsion verticale afin de donner une vitesse de décollage orientée vers le haut.
La création de la rotation sans course d'élan demande de bonnes qualités de coordination et de puissance musculaire.
De ce fait il est souvent plus simple d'apprendre à faire des acrobaties à partir une course d'élan rapide.

#figure(
  scaled-include(path("media/kinogramme-salto-elan.typ"), width: 100%),
  caption: [Lors d'un salto avant avec élan, #moment-cinetique.le provient principalement du moment de la quantité de mouvement acquise lors de la course.],
)

#video-figure(
  caption: [Lors d'un salto avant avec élan, #moment-cinetique.le provient principalement du moment de la quantité de mouvement acquise lors de la course.],
)[
  #todo[Trouver vidéo]
]

=== Mise en rotation des segments
Comme les segments sont liés les uns aux autres par des articulations, il est difficile de les mettre tous en rotation dans le même sens.
Dans la vidéo suivante, le trampoliniste peut créer #moment-cinetique.un important#moment-cinetique.e pour réaliser des triples saltos ou doubles saltos corps tendu.
Il ne possède pas initialement une quantité de mouvement horizontale car il doit rester au centre de la toile du trampoline.
Il doit alors mettre ses segments en rotation et accélérer les segments distaux (membres supérieurs et tronc) lors de la phase de contact.

#video-figure(caption: [Rotation mise en rotation des segments.])[
  #todo[https://fr.youtube.com/watch?v=S_Nns4CRknY&feature=related]
]

Lors d'un salto avant à l'arrêt, que l'on peut comparer à celui avec élan, on remarque que les segments distaux sont mis en rotation et balayent une large amplitude pour créer #moment-cinetique.le nécessaire à réaliser une rotation.

#figure(
  scaled-include(path("media/kinogramme-salto-sans-elan.typ"), width: 100%),
  caption: [Lors d'un salto avant sans élan, #moment-cinetique.le provient principalement #moment-cinetique.du de chacun des segments. Il faut aussi créer une grande vitesse avec les segments distaux.],
)

#video-figure(
  caption: [Lors d'un salto avant sans élan, #moment-cinetique.le provient principalement #moment-cinetique.du de chacun des segments.
    Il faut aussi créer une grande vitesse avec les segments distaux.],
)[
  #todo[Trouver vidéo]
]

== #moment-cinetique.Name en phase aérienne
La phase aérienne présente une cinématique en translation simple avec la conservation de la vitesse horizontale et une accélération verticale égale à la gravité quel que soit l'objet.
Pour la rotation la dynamique du mouvement présente aussi des caractéristiques intéressantes et qui permettent de prédire facilement la performance ou l'accident!

=== Théorème #moment-cinetique.du
Le parallèle du principe fondamental de la dynamique pour le mouvement en rotation est le théorème #moment-cinetique.du.
La relation est du même type avec des entités en rotation.
La somme des moments des forces extérieures appliquées à un système et calculées au point O est égale au moment dynamique du système.
Le moment dynamique est le produit du moment d'inertie avec l'accélération angulaire ou encore la dérivée par rapport au temps #moment-cinetique.du:
$
  sum_k arrow(M)_(O, arrow(F_"ext")) = I alpha = (dif arrow(#moment-cinetique.symbol)) / (dif t).
$

En phase aérienne seul le poids est appliqué au système.
Si on calcule le moment du poids exprimé par rapport au centre de masse, le résultat donne un vecteur nul; le poids est appliqué au centre de masse de ce fait le vecteur $arrow(G G)$ est nul:
$
  arrow(M)_(G, arrow(W)) = arrow(G G) and arrow(W) = arrow(0) and arrow(W) = arrow(0).
$

Comme le moment dynamique est la dérivée par rapport au temps #moment-cinetique.du, ce résultat implique que #moment-cinetique.le est constant#moment-cinetique.e ; #moment-cinetique.il ne varie pas lors d'une phase aérienne:

$
  sum_k arrow(M)_(O, arrow(F)_k) = arrow(M)_(G, arrow(W)) = (dif arrow(#moment-cinetique.symbol))/(dif t) = arrow(0) \
  "Si" (#moment-cinetique.symbol))/(dif t) = arrow(0) "alors" arrow(#moment-cinetique.symbol) = "Constante, donc" \
  arrow(#moment-cinetique.symbol) = I ω = "Constante".
$

On appelle ce principe la *conservation #moment-cinetique.du* en phase aérienne.

=== Varier le moment d'inertie
#moment-cinetique.Le est le produit du moment d'inertie par la vitesse angulaire.
En déplaçant les segments les uns par rapport aux autres, le moment d'inertie est modifié.
Cette modification va avoir un effet inversement proportionnel sur la vitesse de rotation car le produit des deux entités est constant.
Si le moment d'inertie augmente la vitesse angulaire diminue et inversement.

Dans la simulation ci-dessous, le personnage est mis en étant d'apesanteur, c'est-à-dire dans un environnement sans gravité.
De ce fait il ne chute pas.
Le personnage a #moment-cinetique.un initial#moment-cinetique.e  qu'il va conserver tout au long du mouvement (et indéfiniment si aucune force extérieure ne vient l'arrêter).
En adoptant une posture groupée, sa vitesse de rotation augmente en proportion avec la diminution du moment d'inertie.

#video-figure(
  caption: [Effet du changement de moment d'inertie sur la vitesse de rotation.],
)[
  #todo[Trouver vidéo]
]

Si on reprend les valeurs données à la @fig:inertia-moment-of-human, on remarque que le moment d'inertie passe de $12$ unités pour une position anatomique de référence à $4$ unités en position corps regroupé.
De ce fait la vitesse de rotation va augmenter selon la même proportion ($times 3$).
Si les bras sont initialement dans le prolongement du corps, le moment d'inertie est de #qty[15][kg m^2] et augmente encore la proportion.

Lorsque le gymnaste, plongeur ou trampoliniste exécute une acrobatie, il décolle le corps proche de l'extension à la suite de son impulsion.
Il peut ensuite venir en posture groupée pour accélérer sa rotation et ainsi effectuer plusieurs rotations.
Enfin il s'étend soit pour entrer dans l'eau soit pour préparer sa réception.


#figure(
  scaled-include(path("media/inertie-vitesse-angulaire.typ"), width: 85%),
  caption: [Variation de la vitesse angulaire en fonction du moment d'inertie : #moment-cinetique.le étant conservé#moment-cinetique.e, la vitesse angulaire est inversement proportionnelle au moment d'inertie.],
)

Une illustration de la conservation #moment-cinetique.du est aussi le cas d'un pivot sans frottement: le plateau tournant.
La rotation se produit selon un axe vertical.
Le rapprochement des bras le long de l'axe de rotation augmente la vitesse de rotation.

#video-figure(
  caption: [#moment-cinetique.Name sur un pivot parfait],
)[
  #todo[https://www.youtube.com/watch?v=UZlW1a63KZs&feature=related]
]


=== Analyse du saut en longueur
Si l'exemple précédent concerne les activités acrobatiques où l'on cherche à produire le maximum de rotations, dans de nombreux sports on cherche davantage à conserver un certain équilibre et ne pas tourner.
C'est le cas du saut en longueur par exemple.
L'athlète qui a une vitesse élevée de course va prendre un appui plus long sur un pied pour créer une impulsion verticale lors de l'appel.
Ce blocage entraîne la création d'#moment-cinetique.un vers l'avant.
L'athlète doit alors compenser #moment-cinetique.ce pour éviter que l'ensemble de son corps ne tourne vers l'avant.
Pour ce faire différentes stratégies existent.
La plus efficace utilisée par les champions combine un pédalage des jambes et une rotation des bras vers l'avant.
Expliquons en quoi cette technique est efficace.
La somme #moment-cinetique.des segmentaires donne #moment-cinetique.un global#moment-cinetique.e vers l'avant.
Pour éviter que le tronc tourne vers l'avant il faut que les segments éloignés du centre de masse (#ie, les membres supérieurs et inférieurs) tournent vers l'avant.

#interesting-note[
  Prenons un exemple numérique; #moment-cinetique.le au décollage est de $30$~unités $[#unit[kg m^2 / s]]$.
  #if moment-cinetique.feminine [Cette] else [Ce] #moment-cinetique.name total#moment-cinetique.e est une somme; on peut alors avoir la répartition suivante $15$ pour les membres supérieurs, $15$ pour les membres inférieurs et 0 pour le tronc.
  Dans ce cas le tronc ne tournera pas vers l'avant.
  L'animation suivante montre comment la rotation des bras vers l'avant entraîne la rotation du reste du corps vers l'arrière.
  Dans cet exemple, #moment-cinetique.le initial#moment-cinetique.e et durant tout le mouvement est #if moment-cinetique.feminine [nulle] else [nul] ; ainsi la somme #moment-cinetique.du des membres supérieurs (MS) et du reste du corps (RC) est nulle:
  $
    arrow(#moment-cinetique.symbol) = arrow(#moment-cinetique.symbol)_"MS" + arrow(#moment-cinetique.symbol)_"RC" = arrow(0).
  $
  Les membres supérieurs ayant une vitesse angulaire vers l'avant, ils créent #moment-cinetique.un qui est compensé#moment-cinetique.e par le reste du corps.

  #video-figure(
    caption: [Conservation #moment-cinetique.du lors de rotation de bras.],
  )[
    #todo[Trouver vidéo]
  ]

  Pour le pédalage, le phénomène est similaire.
  Les rotations combinées des membres inférieures (MI) correspondent à #moment-cinetique.un vers l'avant.
  De ce fait, si quelqu'un fait un mouvement de marche dans une condition d'apesanteur, le reste de son corps va tourner vers l'arrière:   $ arrow(#moment-cinetique.symbol) = arrow(#moment-cinetique.symbol)_"MI" + arrow(#moment-cinetique.symbol)_"RC" = arrow(0). $


  #video-figure(caption: [Marche dans une condition d'apesanteur.])[
    #todo[Trouver vidéo]
  ]
]

En saut en longueur, #moment-cinetique.le vers l'avant créé#moment-cinetique.e au décollage est compensé#moment-cinetique.e par les mouvements des membres pour conserver le tronc droit.
Les athlètes qui ont moins de vitesse de course et par conséquent #moment-cinetique.un en phase aérienne et une durée de vol plus faible se contentent souvent d'une flexion des genoux qui donne #moment-cinetique.un vers l'avant, une extension du haut du corps pour augmenter le moment d'inertie et des mouvements de bras.
