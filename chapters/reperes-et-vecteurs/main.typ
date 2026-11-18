#import "../../common/lib.typ": *

= Utilisation de repères et vecteurs en cinématique
<sec:reference-frame-and-vectors>

#learning-objectives((
  "Décrire le mouvement dans un référentiel",
  "Connaitre les règles de calcul des vecteurs",
))



L'analyse cinématique du mouvement humain et du sport a son origine avec #link("https://www.expo-marey.com/")[Marey] (1830-1904) et son brillant ingénieur #link("https://georges-demeny.blogspot.com/")[Demenÿ] (1850-1917) souvent qualifié comme l'inventeur oublié du cinéma.
Ces Français ont leur contemporain outre-Atlantique #link("https://fr.wikipedia.org/wiki/Eadweard_Muybridge")[Muybridge] (1830-1904) qui réalisa des expérimentations similaires sur le mouvement des hommes et des animaux.

== Axes et plans de mouvement
#see-handbook[Chapitre 2]

Certains mouvements peuvent s'analyser dans un seul plan ou selon un axe comme le golf dans le plan frontal, le baseball ou le disque dans le plan horizontal et les saltos, pagayage en canoë ou la course dans le plan sagittal.


#figure(caption: [Les plans pour analyser le mouvement], table(
  columns: 5,
  inset: 6pt,
  [*plan*], [*axe 1*], [*axe 2*], [*vue*], [*division*],
  [frontal], [vertical], [transversal], [face], [avant - arrière],
  [horizontal], [transversal], [sagittal], [dessus], [haut - bas],
  [sagittal], [sagittal], [vertical], [côté], [droite - gauche],
))

== Notion de vecteurs et de référentiels
Dans le chapitre précédent, nous avons abordé l'importance de définir un référentiel; nous allons illustrer l'intérêt et comment définir un référentiel.

Lorsque l'on dispose d'une carte, il est assez facile pour indiquer un trajet, un déplacement.
La carte apporte des informations de distance, grâce à l'échelle, de sens et direction.
Une fois la carte enlevée, il est toujours possible d'indiquer approximativement une position en donnant la distance et en utilisant les points cardinaux.


#figure(
  scaled-include(path("media/trajet-carte.typ"), width: 85%),
  caption: [Représentation d'un trajet sur une carte],
)

#interesting-note[
  Par exemple, Québec est à 250 km au nord-est de Montréal.
  La question qui demeure est: "mais où est Montréal?".
  En mathématiques comme il n'y a pas de carte on définit un repère qui a son origine (O) et des directions positive données par des flèches ou #link("https://fr.wikipedia.org/wiki/Vecteur")[vecteurs] unitaires (souvent notées x, y, z) qui pourraient correspondre à "droite, devant, haut" pour des déplacements.
]

L'origine associée aux vecteurs unitaires (1 vecteur si l'espace d'analyse à une dimension soit une droite, 2 vecteurs si l'espace est un plan et 3 vecteurs pour une analyse dans tridimensionnelle) définit un référentiel.
Il existe différents types de référentiel également appelés repères.
Nous allons nous concentrer sur les #link("https://fr.wikipedia.org/wiki/R%C3%A9f%C3%A9rentiel_galil%C3%A9en")[référentiels galiléens] (Galilée 1564-1642 un des fondateurs de la physique moderne) et #link("https://fr.wikipedia.org/wiki/Coordonn%C3%A9es_cart%C3%A9siennes")[cartésiens] (Descartes 1596-1650, un des promoteurs du rationalisme moderne).

=== Repère cartésien
Commençons par quelques définitions; un référentiel cartésien est définit par 1 point d'origine et une #link("https://fr.wikipedia.org/wiki/Base_orthonormale")[base orthonormée] (orthogonal + de norme 1), soit 3 vecteurs unitaires organisés dans le sens direct.
Un vecteur unitaire donne trois informations:
- une *direction*
- un *sens* positif (si un vecteur va dans le sens du vecteur unitaire il est positif et s'il va dans le sens opposé il est négatif)
- l'*unité* (le vecteur unitaire à une norme ou longueur égale à 1)

Les trois vecteurs sont *orthogonaux* (perpendiculaires) les uns par rapport aux autres et organisés selon le sens direct, c'est-à-dire qu'une rotation d'un quart de tours dans le sens inverse des aiguilles d'une montre selon l'axe $x$ amène $y$ vers $z$, la rotation selon $y$ amène $z$ vers $x$ et la rotation selon $z$ amène $x$ vers $y$.
On tourne toujours dans le même sens $x arrow y arrow z arrow x$ qui est appelé le sens direct ou sens inverse des aiguilles d'une montre.
On peut utiliser le moyen mnémotechnique de la "main droite" où $x$ est le pouce, $y$ l'index et $z$ le majeur.


#figure(
  scaled-include(path("media/repere-sens-direct.typ"), width: 90%),
  caption: [Un repère cartésien est orthonormé.
    Les vecteurs unitaires $x$, $y$, $z$ sont organisés dans le sens direct.],
)


#figure(
  scaled-include(path("media/main-droite.typ"), width: 55%),
  caption: [Technique de la main droite],
)

Les vecteurs unitaires définissent le sens positif; c'est arbitraire et ne va pas toujours avec le sens physique des évènements.
Il faut uniquement se baser sur le schéma et non pas le "bon sens" qui n'est pas le plus adéquat pour faire des calculs.

#interesting-note[
  Par exemple, trois voitures $A$, $B$ et $C$ sont sur l'autoroute 20, la voiture $A$ se trouve à #qty[175][km] de Montréal et roule à #qty[100][km / h] en direction de Montréal, la $B$ est à Montréal se déplace à #qty[100][km / h] en direction de Québec et la $C$ à mi-chemin roule en marche arrière à #qty[10][km / h] en direction de Montréal.
  Quelles valeurs de vitesse puis-je attribuer à ces trois voitures si je veux faire des calculs?

  Si la première réaction à avoir est d'exprimer les vitesses en #unit[m / s], la seconde consiste à définir un référentiel.


  Comme le problème ne fait intervenir qu'une direction (l'axe Montréal-Québec), on peut utiliser un référentiel à une dimension ou Montréal serait l'origine et $x$ le vecteur unitaire, positif dans le sens Montréal-Québec.
  Une fois que les voitures sont placées, il suffit de représenter les vecteurs-vitesse selon leur sens de déplacement.
  Les valeurs dans le repère choisi seront alors:

  $V_A = - 100 times 1000 / 3600 \= #qty[-27.8][m / s]$ \
  $V_B = + 100 times 1000 / 3600 \= #qty[27.8][m / s]$ \
  $V_C = - 10 times 1000 / 3600 \= #qty[-2.78][m / s]$

  Rappel, il y a #qty[1000][m] dans #qty[1][km] et $60 times 60$ secondes dans heure, soit #qty[3600][s], d'où le facteur $1000 / 3600$ pour convertir des #unit[km / h] en #unit[m / s].

  La valeur de la vitesse ne tient pas compte du fait que la voiture roule en marche avant ou arrière mais uniquement du sens positif choisi pour le référentiel.
  Le plus souvent ce sens positif sera choisi comme le sens du mouvement.

  #figure(
    scaled-include(path("media/repere-une-dimension.typ"), width: 85%),
    caption: [Repère à une dimension.
      Montréal correspond au point O et Québec au point Q.],
  )
]

=== Propriétés des vecteurs
Il n'est pas lieu de détailler toutes les #link("https://fr.wikipedia.org/wiki/Calcul_vectoriel_en_g%C3%A9om%C3%A9trie_euclidienne")[propriétés des vecteurs] mais d'en rappeler les principales qui serviront dans ce cours.

#figure(
  scaled-include(path("media/point-repere-3d.typ"), width: 55%),
  caption: [Point $M$ dans un repère cartésien $O X Y Z$.],
)

Pour situer le point $M$ dans un repère tridimensionnel, il faut connaître ses coordonnées (valeurs selon les trois axes).
Il est alors possible d'écrire $M$ par rapport à l'origine $O$, soit le vecteur $arrow(O M)$, par l'équation suivante: $arrow(O M) = x arrow(X) + y arrow(Y) + z arrow(Z)$, où $x$ est la première composante, valeur de $M$ selon l'axe $arrow(O X)$, $y$ et $z$ les composantes selon $arrow(O Y)$ et $arrow(O Z)$.

De la même façon dans un repère en deux dimensions, on peut calculer un vecteur entre deux points.

#figure(
  scaled-include(path("media/vecteur-ab-2d.typ"), width: 70%),
  caption: [Le vecteur $arrow(A B)$ dans la base $(O, arrow(i), arrow(j))$.],
)

Ce vecteur $arrow(A B)$ est définit par:
- sa direction: droite ($d$)
- son sens: de $A$ vers $B$
- sa norme, longueur ou intensité (distance entre $A$ et $B$)

Les positions $A$ et $B$ peuvent s'écrire en utilisant les vecteurs unitaires $arrow(i)$ et $arrow(j)$ comme: $arrow(O A) = x_A arrow(i) + y_A arrow(j)$ et $arrow(O B) = x_B arrow(i) + y_B arrow(j)$. Ainsi, le vecteur $arrow(A B)$ peut se définir par :
$ arrow(A B) = (x_B - x_A) arrow(i) + (y_B - y_A) arrow(j) $

L'écriture vectorielle est plus simple car elle évite d'exprimer les vecteurs unitaires ($arrow(i)$, $arrow(j)$ dans ce cas):
$ arrow(O A) = vec(x_A, y_A) "et" arrow(O B) = vec(x_B, y_B)"," $ où les valeurs dans le vecteur colonne
correspondent à l'ordre des vecteurs unitaires.
Il est possible à partir des composantes de $A$ et de $B$ de calculer le vecteur $A B$.
Il faut toujours utiliser la "formule" $"FIN" - "DEBUT"$, dans ce cas $B-A$:
$ arrow(A B) = vec(x_B - x_A, y_B - y_A) $

Pour calculer la norme du vecteur, nous utilisons le théorème de Pythagore: #quote[Dans un triangle rectangle plan, le carré de la longueur de l'hypoténuse (côté opposé à l'angle droit) est égal à la somme des carrés des longueurs des côtés de l'angle droit.]

Dans le plan, un vecteur est l'hypoténuse d'un triangle rectangle où les composantes en $x$ et $y$ sont les deux autres côtés:

#figure(
  scaled-include(path("media/triangle-rectangle.typ"), width: 55%),
  caption: [Triangle rectangle pour calculer la norme d'un vecteur à partir de ses composantes.],
)

Selon la figure on peut écrire la relation suivante: $A B^2 = A C^2 + B C^2$, et en déduire la longueur du vecteur (ou sa norme) par $A B = sqrt(A C^2 + B C^2)$.
Si on utilise une formulation vectorielle ça donne: $norm(arrow(A B)) = sqrt(norm(arrow(A C))^2 + norm(arrow(B C))^2)$.
Enfin pour revenir à l'exemple du vecteur _AB_ de composantes _x_ et _y_, la norme de AB s'écrit: $norm(arrow(A B)) = sqrt(x^2 + y^2)$.
Comme une norme est une longueur elle sera toujours positive.

Dans le cas d'un vecteur défini dans un repère cartésien tridimensionnel, la norme se calcule comme la racine carrée de la somme des composantes élevées au carré soit pour le vecteur $arrow(A B)$_:_
$ arrow(A B) = vec(x, y, z) $
nous obtenons $norm(arrow(A B)) = sqrt(x^2 + y^2 + z^2)$.

#interesting-note[
  Par exemple, le vecteur force $F_1$ est défini par
  $ arrow(F_1) = vec(40, -5, 10). $
  Sa norme sera
  $
    norm(arrow(F_1)) = sqrt(40^2 + (-5)^2 + 10^2) = sqrt(1600 + 25 + 100) = #qty[41.5][N].
  $
  L'unité dépend de la nature du vecteur.

  Faite de même pour le vecteur position $F_2 = vec(4, -50, 67)$ et le vecteur accélération $F_3 = vec(11, 30, -100)$.
]

Les vecteurs permettent de nombreuses opérations comme l'addition.
L'opposé d'un vecteur consiste à changer le signe des composantes:
$
                            arrow(A B) & = -arrow(B A) \
  vec(x_B - x_A, y_B - y_A, z_B - z_A) & = -vec(x_A - x_B, y_A - y_B, z_A - z_B)
$
Additionner deux vecteurs revient à additionner leurs composantes:
$ arrow(A) + arrow(B) = vec(x_A + x_B, y_A + y_B, z_A + z_B) $

La relation de Chasles est souvent utilisée pour additionner des vecteurs:
$ arrow(A B) + arrow(B C) = arrow(A C) $


Géométriquement, cela revient à positionner le second vecteur au bout du premier vecteur, puis de tracer le chemin du début du premier au bout du second.

#figure(
  scaled-include(path("media/relation-chasles.typ"), width: 55%),
  caption: [L'addition de deux vecteurs donne un vecteur résultant.],
)

En reprenant la notion d'opposé d'un vecteur et celle d'addition, il est aussi possible de soustraire des vecteurs: $arrow(A B) - arrow(C B) = arrow(A B) + arrow(B C) = arrow(A C)$.
Enfin une dernière relation que nous utiliserons très souvent est le produit d'un vecteur avec un scalaire $k$.
Il suffit dans ce cas de multiplier chacune des composantes par $k$:
$ k dot arrow(A B) = k vec(x, y, z) = vec(k x, k y, k z) $

L'intérêt du vecteur est de contenir en une même entité plusieurs dimensions qui sont liées les unes aux autres.
On ne dissocie pas, par exemple, un déplacement de #qty[5][km] vers le nord et #qty[3][km] vers l'ouest car c'est un même mouvement vers le nord-ouest.
Ce mouvement ne correspond pas à #qty[5][km] nord plus #qty[3][km] ouest mais un mouvement global qui est plus court!
Quand on se déplace dans Montréal on ne peut pas dire qu'on se trouve dans un espace bidimensionnel (vue sur la carte) car quelle que soient les rues que l'on prenne on va parcourir la même distance.
C'est un espace à deux fois une dimension.
On ne peut pratiquement pas se déplacement en diagonale sauf quelques exceptions comme la rue Sherbrooke.


#figure(
  scaled-include(path("media/espace-deux-dimensions.typ"), width: 80%),
  caption: [Différence entre un espace en deux dimensions et un espace en deux fois une dimension.],
)

=== Référentiel galiléen
Un *référentiel galiléen* est:
- un référentiel où le principe d'inertie est vérifié,
- un repère en translation rectiligne uniforme (#ie, vitesse linéaire constante) par rapport au référentiel héliocentrique (également appelé #link("https://fr.wikipedia.org/wiki/R%C3%A9f%C3%A9rentiel_%28physique%29#R.C3.A9f.C3.A9rentiel_de_Copernic")[référentiel de Copernic]).
- Tout repère en translation rectiligne uniforme par rapport à un référentiel galiléen est un référentiel galiléen

Le référentiel héliocentrique a pour origine le centre de masse du soleil (_Hélios_ est la personnification même du soleil dans la mythologie grecque) et les vecteurs directeurs pointent vers des étoiles très éloignées.
Ce référentiel est donc considéré comme fixe sur une échelle de temps humaine.

Rappelons que le principe d'inertie ou 1#super[ère] loi de Newton pose que tout corps conserve sa vitesse ou son état de repos tant que la résultante des forces extérieures est nulle.
En faisant également appel à la 2#super[ème] loi de Newton ($F = m a$), tant que la force est nulle, il n'y a pas d'accélération (si $F = 0$ alors $m a = 0$; mais comme la masse n'est pas nulle, alors $a = 0$).
Par exemple étant dans sa voiture sans accélérer, la voiture reste soit à l'arrêt soit conserve sa vitesse.

#interesting-note[
  Par exemple, la valise à roulettes dans le métro.
  Si on définit un référentiel associé au métro juste dans un coin d'une voiture.
  La valise posée au sol est soumise uniquement à son poids et la force de réaction du sol sur la valise.
  De ce fait elle devrait rester immobile tout au long du voyage selon la 1ère loi de Newton.
  Or lorsque le métro accélère et ralenti, la valise recule et avance.

  Comme le référentiel définit dans le train n'est pas en translation rectiligne uniforme, le principe d'inertie n'est pas vérifié.
  Les calculs deviendraient plus complexe, alors il est toujours préférable de définir le référentiel sur une partie immobile.
]

