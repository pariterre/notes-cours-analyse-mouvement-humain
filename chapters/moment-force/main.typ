#import "../../common/lib.typ": *


= Moments de force
#learning-objectives((
  "Savoir calculer un moment de force",
  "Connaitre l'intérêt des différents types de levier",
))

Le #link("https://fr.wikipedia.org/wiki/Moment_de_force_%28m%C3%A9canique%29")[*moment de force*] ($arrow(M)$) est l'aptitude d'une force à faire tourner un système mécanique autour d'un point donné qu'on nomme pivot.
Il se calcule comme le produit vectoriel du bras de levier (vecteur $arrow(O M)$) et de la force ($arrow(F)$): $arrow(M_(arrow(F),O)) = arrow(O M) and arrow(F)$.
Le calcul de tous les moments (#eg, moment de la quantité de mouvement, moment de force) fait intervenir un
#link("https://fr.wikipedia.org/wiki/Produit_vectoriel")[produit vectoriel].
Cette notion sera donc utile par la suite.
Le produit vectoriel de deux vecteurs donne un vecteur qui est perpendiculaire au plan formé par les deux vecteurs: $arrow(C) = arrow(A) and arrow(B)$

#figure(
  scaled-include(path("media/produit-vectoriel.typ"), width: 45%),
  caption: [Le produit vectoriel de $arrow(A)$ et $arrow(B)$ donne un vecteur $arrow(C)$ perpendiculaire au plan formé par $arrow(A)$ et $arrow(B)$.],
)


L'expression vectorielle peut se trouver par le moyen mnémotechnique présenté par la figure ci-dessous.
Il suffit d'écrire les vecteurs sous forme de deux colonnes, de barrer la première ligne, celle des $x$, et de répéter les composantes pour obtenir deux colonnes de 5 lignes.
Ensuite chaque composante se calcule comme la soustraction de deux produits.

#figure(
  scaled-include(path("media/produit-vectoriel-methode.typ"), width: 70%),
  caption: [Moyen mnémotechnique pour retrouver l'expression d'un produit vectoriel.],
)

Lorsque l'on travaille dans le plan $x O y$ par exemple, le vecteur moment cinétique ou du moment de la quantité de mouvement est porté par l'axe $O_z$, celui qui est perpendiculaire au plan $x O y$.
En développant l'expression du produit vectoriel entre $arrow(a)$ et $arrow(b)$ en mettant les composantes en $z$ égales à zéro, on retrouve uniquement une composante en $z$ pour le vecteur $C$.

$
  vec(x_C, y_C, z_C) =
  vec(x_A, y_A, 0) and vec(x_B, y_B, 0) =
  vec(y_A dot.op 0 - 0 dot.op y_B, 0 dot.op x_B - x_A dot.op 0, x_A dot.op y_B - y_A dot.op x_B) =
  vec(0, 0, x_A dot.op y_B - y_A dot.op x_B).
$

== Paramètres du moment de force
L'intensité d'un moment de force dépend de trois paramètres que nous allons illustrer par l'exemple d'une clé qui desserre un écrou.
Pour augmenter l'effort créé par la main sur l'écrou via la clé (un levier), on peut tout d'abord éloigner la main du centre de rotation.
Dans ce cas on joue sur la longueur du bras de levier.
Une autre possibilité est d'augmenter l'intensité de la force que l'on applique sur la clé.
Enfin selon l'orientation de la force est importante, il est préférable que la force soit appliquée perpendiculairement au bras de levier.
Dans ce cas précis, toute la force sert à faire tourner.
Si la force n'est pas perpendiculaire, seule une partie contribue au moment de force tandis que l'autre est une force de traction-compression inutile.

#figure(
  scaled-include(path("media/cle-moment.typ"), width: 80%),
  caption: [Comment augmenter l'intensité d'un moment de force?],
)

La norme du produit vectoriel se calcule comme le produit des normes des vecteurs avec la valeur absolue du sinus de l'angle formé par les deux vecteurs.
L'intensité peut se représenter comme la surface formée par les deux vecteurs; plus les vecteurs sont longs et forment un angle droit plus la surface est importante.
Le sinus d'un angle de #to-degree(90) vaut $1$ et cette valeur tend vers $0$ si l'angle devient aigu ($sin(#to-degree(0))$) ou obtus ($sin(#to-degree(180))$).

#figure(
  scaled-include(path("media/produit-vectoriel-aire.typ"), width: 100%),
  caption: [L'intensité d'un produit vectoriel dépend de la norme des vecteurs et de l'angle formé par les deux vecteurs.],
)


Il est possible de grouper le bras de levier apparent avec le sinus de l'angle pour obtenir le bras de levier réel, c'est-à-dire la plus courte distance (distance perpendiculaire) entre le centre de rotation et la droite qui porte le vecteur force ou grouper la force avec le sinus de l'angle pour obtenir la force effective c'est-à-dire la composante de la force qui est perpendiculaire au bras de levier.
Des exemples de ces deux méthodes sont montrés à la figure ci-dessous.


#figure(
  scaled-include(path("media/bras-levier-force-effective.typ"), width: 90%),
  caption: [Représentation graphique de l'expression de l'intensité d'un moment : le $sin theta$ se regroupe soit avec le bras de levier, soit avec la force.],
)

== Leviers
#see-handbook[Chapitre 3]

Le levier fait partie des huit machines simples (#ie, levier, roue, poulie, coin, plan incliné, vis, engrenage et treuil).
Un levier est une pièce rigide, allongée, généralement en liaison pivot qui permet de transformer un mouvement.
Le centre de rotation est appelé le point d'appui et le bras de levier est la distance séparant une extrémité de son point d'appui.
Le bras de levier du côté de la force motrice est dit bras de force et celui du côté de la résistance, bras de résistance.

#figure(
  scaled-include(path("media/levier-composantes.typ"), width: 75%),
  caption: [Composantes d'un levier de type inter-appui.],
)

Selon la disposition des éléments du levier, il est possible de déplacer de lourdes charges (#eg, une brouette) ou de créer de grand déplacement (#eg, la plupart des articulations du corps humain).
Il existe trois types de leviers: inter-appui, inter-moteur et inter-résistant.

#figure(
  include "media/leviers-avantages.typ",
  caption: [Avantage mécanique ou cinématique des leviers.],
)

Pour avoir un équilibre statique, il faut que la somme des forces extérieures et la somme des moments des forces extérieures soient nulles; ce sont des égalités vectorielles.

On retrouve ces deux conditions lorsque l'on analyse un système de leviers en équilibre.
En rapport avec le produit vectoriel, le moment d'une force est soit positif soit négative dépendamment du référentiel et du sens dans lequel la force ferait tourner le système.

#interesting-note[
  Par exemple, dans la figure ci-dessous, il suffit d'imaginer dans quel sens tournerait l'objet autour du point $O$ si une force $arrow(F)$ était appliquée.
  Le sens positif faisant tourner de $x$ vers $y$, les moments de force $F_5$ et $F_6$ sont positifs alors que ceux de $F_1$, $F_2$ et $F_4$ sont négatifs. Le moment de $F_3$ est nul, car sa droite d'action passe par $O$.

  #figure(
    scaled-include(path("media/signe-moments.typ"), width: 80%),
    caption: [Le signe des moments de forces extérieures dépend du sens dans lequel elles feraient tourner l'objet autour de $O$ (bleu : positif; rouge : négatif).],
  )
]

Dans un système de leviers, on trouve trois forces: la résistance ($arrow(R)$) (#eg, la charge que l'on veut déplacer), la force motrice ($arrow(F)$) (#eg, la force que l'on doit produire) et la réaction au niveau du point d'appui.
Pour qu'il y ait équilibre dans un premier temps il faut que la somme de ces trois forces soit égale à $0$.
Dans l'exemple ci-dessous, la résistance et la force motrice sont des forces négatives (orientées vers le bas) alors la réaction au niveau du point d'appui sera positive.
Elle est opposée à la somme des deux autres.

#figure(
  scaled-include(path("media/levier-equilibre.typ"), width: 65%),
  caption: [Le moment de la résistance $arrow(R)$ par rapport à $O$ est positif et celui de la force $arrow(F)$ négatif; la réaction en $O$ compense $arrow(R) + arrow(F)$.],
)

On remarque que la résistance provoque un moment de force positif calculé au point d'appui ($O$) alors que la force motrice entraîne un moment négatif.
Comme la réaction (force positive représentée en violet) est appliquée en $O$, son bras de levier est nul et par conséquent son moment vaut zéro.

#figure(
  scaled-include(path("media/levier-vitesses.typ"), width: 55%),
  caption: [Les vitesses des extrémités d'un levier sont proportionnelles aux bras de levier.],
)


Si à présent on s'intéresse à la cinématique, le rapport des bras de levier présente également un avantage.
Dans ce cas, un faible déplacement appliqué au bras le plus cours entraîne un plus grand déplacement pour le bras le plus long.
Comme ces deux déplacements se produisent en même temps, la vitesse est proportionnelle au rapport des bras de levier.
Par exemple, le déplacement à une vitesse de #qty[1][m / s] d'un bras de #qty[1][m] entrainera une vitesse de $frac(style: "horizontal", 3, 1) times #qty[1][m / s]$ pour un bras de #qty[3][m].
Un levier permet de transformer un déplacement, une vitesse ou une accélération selon le rapport de ses bras de levier.
Nous allons illustrer la manière dont le corps humain est conçu ainsi que plusieurs outils courants pour bénéficier des avantages mécaniques (force versus cinématique) des systèmes de leviers par une classification en levier inter-appui, levier inter-résistant et levier inter-moteur.

=== Levier inter-appui
Dans ce premier type de levier, le point d'appui est entre la force motrice et la résistance, comme dans l'exemple précédent.
C'est le cas présenté dans les figures ci-dessus.

#figure(
  scaled-include(path("media/leviers-inter-appui.typ"), width: 90%),
  caption: [Exemples de leviers inter-appui.],
)

Dans le cas de la paire de ciseaux, plus l'objet à couper est loin du pivot et plus il faudra de force pour le couper.
Pour bénéficier de l'avantage mécanique on rapproche spontanément l'objet à couper.

=== Levier inter-résistant
Un levier inter-résistant est caractérisé par la résistance placée entre la force motrice et le pivot.
Ces leviers sont plutôt présents dans des mécanismes créés par l'humain (#eg, la brouette) car ils présentent un avantage mécanique important.
L'intensité de la force que la personne doit développer est plus faible que celle de la résistance.
Dans le cas de la brouette, il est possible de soulever une charge bien plus importante que l'on pourrait porter sur son dos ou à bout de bras.
Par contre dans le corps humain on rencontre peu de leviers de type inter-résistant.

#image(
  "../../../notes-de-cours-old/word/media/image182.png",
  width: 2.620779746281715in,
  height: 1.756576990376203in,
)

#figure(
  scaled-include(path("media/brouette.typ"), width: 60%),
  caption: [Exemple de levier inter-résistant : l'équilibre d'une brouette.],
)

<_Toc82332987>Figure IX.11. _Exemple de leviers inter-résistant._

Le rapport $frac(style: "horizontal", b, a)$ montre l'avantage mécanique de ce type de levier.

=== Levier inter-moteur
Dans ce type de leviers, la force motrice est au milieu.
Ils sont les plus nombreux dans l'appareil locomoteur.
Le bras de résistance n'est pas en faveur d'une grande efficacité; mais le point d'application de la force, proche de l'axe, engendre des mouvements plus amples.
Ils présentent un avantage cinématique.

D'une façon générale, les rapports entre bras de force et bras de résistance sont en faveur de la cinématique.
Comme le muscle se contracte sur une faible amplitude (quelques centimètres) il faut que le rapport des bras de levier permette un plus grand déplacement pour effectuer tous les gestes de la vie quotidienne.
En contrepartie de ce faible raccourcissement musculaire, les muscles sont capables de générer de très grandes forces pour pouvoir déplacer des objets lourds.
On comprend aisément comment des différences interindividuelles sur les insertions musculaires et longueurs des segments peuvent conduire à des capacités physiques très différentes, et ce, pour une même masse musculaire.


#interesting-note[
  _Exercice:_ Calculer la force musculaire du brachial pour maintenir un cube de $#qty[0.1][m]$ de côté et de masse volumique $#qty[3058][kg / m^3]$.
  Le bras de levier résistant est de $#qty[30][cm]$ et les bras de levier des forces musculaires sont $#qty[24][mm]$ (sujet de gauche) et $#qty[44][mm]$ (sujet de droite).

  #figure(
    scaled-include(path("media/bras-levier-brachial.typ"), width: 80%),
    caption: [Effet du bras de levier sur la force musculaire : même charge, insertion du brachial à #qty[24][mm] (gauche) ou #qty[44][mm] (droite) du coude.],
  )

  _Attention il faut mettre toutes les entités en unités internationales._

  Le moment de force du cube est le produit de son poids (produit de la masse par la gravité) par le bras de levier.
  La masse volumique ($rho$) est le ratio de la masse ($m$) d'un objet par unité de volume ($V$), soit $rho = frac(style: "horizontal", m, V)$.
  On trouve donc la masse en isolant m dans l'équation :
  $
    V = 0.1 times 0.1 times 0.1 = #qty[0.001][m^3] \
    m = rho V \
    m = 0.001 times 3058 = #qty[3.058][kg]m
  $
  Ceci équivaut à un poids de $arrow(W_"cube") = 3.058 times 9.891 = #qty[30][N]$.
  Le moment du poids s'écrit donc:
  $ M_"cube" = arrow(W_"cube") times d_"cube" = 30 times 0.3 = #qty[9][N m]. $
  On sait que $M_"cube"$ est égale à $M_"muscle"$ qui est le produit de la force musculaire $F_"muscle"$ par le bras de levier ($d_"muscle"$) soit :
  $
    "Pour le sujet 1:" M_2 = F_"muscle" times 0.024 = 9\
    "Pour le sujet 2:" M_2 = F_"muscle" times 0.044 = 9.
  $
  On est déduit la force musculaire:
  $
    "Pour le sujet 1:" F_"muscle" = 9 / 0.024 = #qty[375][N] \
    "Pour le sujet 2:" F_"muscle" = 9 / 0.044 = #qty[205][N].
  $
]
