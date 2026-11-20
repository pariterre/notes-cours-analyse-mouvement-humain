#import "../../common/lib.typ": *

= Chute libre

#learning-objectives((
  "Invalider les croyances sur la chute libre",
  "Déterminer les équations du mouvement en chute libre",
  "Connaitre les facteurs déterminant de la chute libre",
))

#see-handbook[Chapitre 6]

La #link("https://fr.wikipedia.org/wiki/Chute_libre,_cin%C3%A9matique")[chute libre] est un cas simple de la mécanique qui est très utile à connaître pour l'enseignement de l'éducation physique.
En effet, la chute libre ne signifie pas uniquement les activités avec de longues chutes comme les sauts en parachute ou plongeon depuis une falaise mais toutes les dynamiques où un système (#eg, athlète, balle, ballon) n'est plus en contact avec l'environnement.
De ce fait la course est une succession de phases de contact et de chutes libres, un lancer en athlétismes ou dans un sport collectif est également une phase de chute libre pour le projectile, etc.
Nous allons voir que, malgré le sens commun, tous les objets se comportent de la même façon en chute libre et que seuls les paramètres au décollage déterminent la cinématique... s'il n'y avait pas de frottement avec l'air.

#figure(
  caption: [Exemples de chute libre],
  kind: "video",
  supplement: "Vidéo",
)[
  #todo[https://www.youtube.com/watch?v=_MbqxJx_ups]
  #todo[https://www.youtube.com/watch?v=CGfPeL2K10I]
]

#interesting-note[
  Par exemple, prenons tout d'abord deux pièces une de #qty[2][\$] et une de #qty[0.10][\$].
  Les deux pièces ont des masses différentes.
  Laquelle tombe le plus vite?
  Le sens commun voudrait que la pièce de #qty[2][\$] soit plus "rapide"; il n'en est rien.
  La première expérience est de mettre les pièces l'une sur l'autre (#qty[2][\$] sous #qty[0.10][\$] puis le contraire) et de voir si les pièces se décollent.
  Ensuite il est possible de répéter le test en laissant #qty[1][cm] entre les pièces et de voir si cet espace est conserver ou pas.
  Le même type d'expérience peut être reproduit avec une bille d'acier et une feuille de papier pliées aussi petit que possible.

  En effet une feuille non pliée présente une grande résistance aérodynamique, partie de la mécanique qui fera l'objet d'un chapitre.
  Nous nous intéressons ici qu'à des systèmes soumis uniquement à leur poids.
]

== Le système en chute libre
Intéressons-nous à un boulet de masse $m$ en chute libre.
Il a été lancé à $t_i = #qty[0][s]$ avec une vitesse $v_i$ et un angle d'éjection $theta$.
On peut représenter tous ces paramètres dans le repère $x O y$ par le schéma suivant:

#figure(
  scaled-include(path("media/boulet-conditions-initiales.typ"), width: 80%),
  caption: [Conditions initiales d'un boulet en chute libre : position $(x_i, y_i)$, vitesse $arrow(v_i)$ et ses composantes, et poids $arrow(W)$.],
)


Lorsque seule la norme de la vitesse et l'angle d'éjection sont donnés, il faut calculer les composantes du vecteur vitesse, c'est-à-dire calculer la vitesse verticale et la vitesse horizontale en utilisant les formules trigonométriques dans le triangle rectangle.
On peut utiliser le moyen mnémotechnique *CAH SOH TOA* pour "_casse-toi_": #strong[C]osinus = #strong[A]djacent sur #strong[H]ypothénuse; #strong[S]inus \= #strong[O]pposé sur #strong[H]ypothénuse; #strong[T]angente \= #strong[O]pposé sur #strong[A]djacent.
Certaines personnes préfèrent *SOH CAH TOA*.

#figure(caption: [Rappel de la trigonométrie dans le triangle rectangle])[
  #grid(
    columns: (50%, 1fr),
    align: horizon,
    scaled-include(path("media/triangle-trigonometrie.typ"), width: 100%),
    $
      cos(theta) & = "adjacent" / "hypothénuse" = (A C)/(A B) \
      sin(theta) & = "opposé" / "hypothénuse" = (B C)/(A B) \
      tan(theta) & = sin(θ)/cos(θ) = "opposé" / "adjacent" = (B C)/(A C)
    $,
  )
]


Dans notre cas, nous obtenons les vitesses horizontale ($v_x$) et verticale ($v_y$) à partir du vecteur de vitesse ($v$) par:
$
  v_x = v cos(theta) \
  v_y = v sin(theta) \
$
où $v$ est l'hypothénuse, $v_x$ est le côté adjacent et $v_y$ est le coté opposé.

== Selon le principe fondamental de la dynamique
D'après le Principe Fondamental de la Dynamique, la somme des forces extérieures est égale au produit de la masse $m$ par l'accélération $a$ du centre de masse du système: $sum_k arrow(F_k) = m arrow(a)$.
La seule force appliquée au système étudié (on néglige les frottements aérodynamiques) est son poids ($arrow(W)$), soit $sum_k arrow(F_k) = arrow(W) = m arrow(g)$.
Des deux équations précédentes on obtient $m arrow(a) = m arrow(g)$ ou $arrow(a) = arrow(g)$ après avoir simplifié la masse.
L'accélération d'un corps en chute libre dépend donc uniquement de la gravité.
La masse, la forme ou la couleur n'interviennent pas dans l'équation du mouvement.
La gravité dans le repère $x O y$ que nous avons définie plus haut à pour valeur:
$arrow(a) = vec(0, -9.81) #unit[m/s^2]$, où $0$ correspond à l'accélération selon l'horizontale $x$ et $-9.81$ correspond à l'accélération selon la verticale $y$.
En d'autres mots, comme la gravité est verticale, dirigée vers le bas et de norme #qty[9.81][m / s^2], l'accélération horizontale est nulle et la composante verticale vaut $-9.81$ car le sens positif est orienté vers le haut.

Il est alors possible, en connaissant l'accélération au cours du mouvement et les conditions initiales, de calculer la vitesse et la position horizontale et verticales de l'objet à tout instant.
On se retrouve dans un cas de mouvement linéaire horizontal et un mouvement linéairement accéléré verticalement.

*Selon l'axe $O_x$* (horizontal), l'accélération est nulle $a_x (t) = 0$. Ainsi la vitesse à tout instant $t$ est égale à la vitesse de décollage $v_x (t) = v_x_i$.
La position horizontale est donc une fonction linéaire de la vitesse et du temps.
Il faut également ajouter la position initiale qui n'est pas toujours #qty[0][m]: $x(t) & =v_x_i t + x_i$.

Personne n'a jamais observé (dans des conditions sans vent) un objet en chute libre revenir en arrière ou subitement accélérer selon la direction horizontale.
On peut en extraire des conséquences directes pour le sport et l'éducation physique:

- il faut placer des tapis de réception qui tiennent compte de la durée de vol et la vitesse initiale;
- pour aller loin le projectile (disque, poids, etc.) doit avoir une grande vitesse horizontale et un temps de vol important;
- la position initiale a également son importance d'où l'importance de travailler sur des marques précises en sauts en longueur et en hauteur ou dans les lancers en athlétisme.
  Il faut tout autant tenir compte de la position verticale.
  L'importance de la position initiale sera développée dans le prochain chapitre sur la géométrie des masses.

*Selon l'axe $O_y$* (vertical), l'accélération est celle de la gravité $a_y (t) = -9.81$.
La vitesse va diminuer de plus en plus.
Le plus souvent l'objet est lancé avec une vitesse positive (orientée vers le haut), cette vitesse va diminuer au cours du temps sous l'effet de la gravité jusqu'à devenir nulle.
Le projectile a alors atteint le sommet de sa trajectoire.
Sa vitesse qui était positive puis nulle devient à présent négative; elle continue de décroitre jusqu'à toucher le sol.
L'expression de la vitesse verticale est $v_y (t) = v_y_i + (-9.81) t$.
Comme le mouvement de chute libre selon l'axe vertical est uniformément accéléré, l'expression de la position dépend du temps au carré: $y(t) = y_i + v_y_i t + 1/2 (-9.81) t^2$.

== Équation paramétrique
L'équation paramétrique de la chute libre est une équation qui donne la position verticale en fonction de la position horizontale, le temps est exclu de cette expression.
Pour simplifier le développement nous allons choisir l'origine du repère en $vec(x_0, y_0)$, soit les positions initiales ce qui donne $x_i = 0$ et $y_i = 0$.
Repartons des équations de positions horizontales et verticales en fonction du temps:
$
  cases(
    x = x_i + v_x_i t & = 0 + v_i cos(theta) t & = v_i cos(theta) t,
    y = y_i + v_y_i t + 1/2 a t^2 & = 0 + v_y sin(theta) t + 1/2 (-9.81) t^2 &= v_i sin(theta) t - 9.81/2 t^2
  )
$
Il est possible d'exprimer $t$ en fonction de $x$.
On divise de chaque côté par $v_i cos(theta)$:
$
  x / (v_i cos(theta)) = (v_i cos(theta) t )/ (v_i cos(theta)) \
  t = x / (v_i cos(theta))
$
Cette expression de $t$ remplace $t$ dans l'équation $y$:
$
  y = v_i sin(theta) (x / (v_i cos(theta))) + (-9.81)/2 (x / (v_i cos(theta)))^2 \
  y = (sin(theta) x) / cos(theta) + (-9.81 x^2) / (2 v_i^2 cos^2(theta))\
  y = tan(theta) x + (-9.81 x^2) / (2 v_i^2 cos^2(theta))
$

Ce qu'il faut remarquer c'est que l'équation est de la forme $y = a x^2 + b x$.
Cette équation qui prend la forme d'une parabole.
Au final, il est important de retenir que la chute libre est fonction de la position initiale, la vitesse d'éjection et son angle et la trajectoire décrit une parabole.

#interesting-note[
  *À retenir*

  Lorsqu'un système n'est soumis qu'à son poids (cas de la chute libre), son accélération est l'accélération de la gravité, accélération verticale, dirigée vers le bas (centre de la Terre) et de norme #qty[9.81][m / s^2].

  L'accélération de l'objet est indépendante de sa masse et sa forme.
  C'est un mouvement uniformément accéléré selon l'axe vertical et uniforme (vitesse constante) dans le plan horizontal.
  Enfin si l'on connait les paramètres d'éjection on peut calculer la trajectoire à tout instant, trajectoire qui est parabolique.
]

== Performance des projectiles
La performance d'un projectile peut être de nombreuses natures: distance horizontale, distance verticale, vitesse, temps passé en suspension, précision ou encore un critère mixte.

Dans certains sports comme le saut en longueur et le lancer de poids, la performance correspond à la *distance maximale*.
Il est assez facile d'augmenter la performance avec des élèves juste en travaillant sur la position au moment de l'éjection, en travaillant la prise de marque en saut en longueur ou en faisant une extension maximale de tout le corps.
L'angle d'éjection a également beaucoup d'importance.
Si théoriquement l'angle optimal est 40-45 degrés, les angles utilisés en saut en longueur varient entre 18 et 24 degrés et pour le lancer de poids autour de 40 degrés.

#figure(
  caption: [Lancer de poids],
  kind: "video",
  supplement: "Vidéo",
)[
  #todo[https://www.youtube.com/watch?v=qPZwXF1Xcpw]
]

En saut en hauteur et saut à la perche, les athlètes cherchent à atteindre la plus grande *hauteur*.
Les facteurs les plus importants sont la vitesse verticale d'éjection et la hauteur initiale.
Dans les activités acrobatiques on cherche à maximiser la *durée de vol* afin d'effectuer le maximum de saltos vrillés.
Ce paramètre dépend principalement de la vitesse verticale.
Enfin dans de nombreux sports, on recherche un compromis entre la vitesse et la précision comme au tennis, des passes au basket-ball ou football, un lancer au baseball, etc.
La précision est définie par les règles de jeu alors que la vitesse permet de prendre un avantage temporel sur l'adversaire.
Voici un exemple illustré de l'effet des paramètres d'éjection sur la performance en lancer de poids.

=== position initiale
La position verticale peut être améliorée en lâchant le poids en fin d'extension des membres inférieurs (être sur la pointe des pieds) et supérieurs.
La position horizontale peut être modifiée en venant placer le pied contre le buttoir.
Ces deux paramètres améliorent directement et linéairement la performance.

#figure(
  scaled-include(path("media/lancer-position-initiale.typ"), width: 100%),
  caption: [Effet de la position initiale sur la performance en lancer de poids (lancer de référence : #qty[12][m / s], 40°, lâché à #qty[2.2][m] de haut au niveau du butoir).],
)

=== vitesse et angle d'éjection
La vitesse est le paramètre qui augmente le plus la performance toutefois il faut à la fois la coordination et la force, pour de l'arrêt, pouvoir accélérer le poids.
Comme la vitesse du poids est la somme de la vitesse du tronc plus la vitesse de la main, il ne faut pas négliger la technique pour donner au corps une grande vitesse.
L'angle d'éjection est également important.
Il faut rechercher un angle autour de 40 degrés.

#figure(
  scaled-include(path("media/lancer-vitesse-angle.typ"), width: 100%),
  caption: [Effet de la vitesse et de l'angle de lâcher sur la performance en lancer de poids (même lancer de référence). Un écart de #qty[1][m / s] change la performance de plus de #qty[2][m], alors qu'un écart de 5° autour de 40° ne la change que de quelques centimètres.],
)

#figure(
  caption: [Animation sur l'effet de l'angle],
  kind: "video",
  supplement: "Vidéo",
)[
  #todo[https://www.youtube.com/watch?v=N0H-rv9XFHk&feature=related]
]
