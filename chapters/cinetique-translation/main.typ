#import "../../common/lib.typ": *
#import "media/abduction-bras-donnees.typ": abduction-positions, abduction-time

= Cinétique en translation
#learning-objectives((
  "Comprendre la relation entre impulsion et quantité de mouvement",
  "Calculer la variation de vitesse à partir des forces",
  "Calculer la quantité totale de mouvement",
))


== Résumer des paramètres cinétiques
<_Toc82333058>Tableau VIII.1. _Les paramètres cinétiques sont obtenus à partir des entités cinématiques et inertielles_

#{
  show table.cell: it => if it.x == 0 { strong[#it] } else { it }

  align(center)[#table(
    columns: 3,
    align: horizon,
    [], [Translation], [Rotation],

    table.cell(rowspan: 2)[Cinématique],
    [vitesse linéaire ($v$) *$[#unit[m/s]]$*],
    [vitesse angulaire ($omega$) $[#unit[rad / s]]$ ],
    [accélération linéaire ($a$) *$[#unit[m/s^2]]$*],
    [accélération angulaire ($alpha$) $[#unit[rad / s^2]]$ ],

    [Inertie],
    [masse ($m$) *$[#unit[kg]]$*],
    [Moment d'inergie ($I$) $[#unit[km m^2]]$ ],

    table.cell(rowspan: 2)[Cinétique],
    [quantité de mouvement \ $p = m v$ *$[#unit[kg m / s]]$*],
    [quantité de rotation / moment cinétique \ $q = sigma = I omega$ *$[#unit[kg m^2 / s]]$*],
    [quantité d'accélération \ *$[#unit[kg m / s^2]]$*],
    [moment dynamique \ $delta = I alpha$ *$[#unit[kg m^2 / s^2]]$*],
  )]
}

== Impulsion en translation
=== Impulsion élémentaire
Le vecteur est une force avec sa direction, son sens et sa norme.
Il est possible avec des outils appelés plateforme de force de mesurer la force d'action d'une personne sur le sol.
La plateforme mesure cette force pour les trois directions de l'espace et avec des fréquences très élevées: #eg, #qty[1000][Hz] ($1000$ valeurs de force par seconde).

#video-figure(caption: [Plateforme de force (anglais)])[
  #todo[https://www.youtube.com/watch?v=-1CqNEMj_iU]
]

Comme les composantes de la force ($F_x$, $F_y$ et $F_z$) sont connues, la norme de la force ainsi que la direction peuvent être calculée en utilisant respectivement le théorème de Pythagore et l'arc-tangente.

#interesting-note[
  Calculer la norme et la direction de la force $F$ dans le plan $x O y$.

  #figure(
    scaled-include(path("media/composantes-force.typ"), width: 75%),
    caption: [Vecteur force de norme #qty[5][N] orienté à #to-degree(36.9)],
  )

  #{
    set strong(delta: 0) // `strong` no longer bolds
    set table(fill: none) // no header colour

    align(center, table(columns: 2, gutter: 1em)[
      $
        norm(arrow(F))^2 = F_x^2 + F_y^2\
        norm(arrow(F)) = sqrt(4^2 + 3^2) = sqrt(25) = 5
      $
    ][
      $
        tan(theta) = frac(style: "horizontal", "opp", "adj") \
        theta = tan^(-1)(frac(style: "horizontal", 3, 4)) \
        theta approx #qty[0.6435][rad] approx #to-degree(36.9)
      $
    ])
  }
  $
    F = 5 "à" #to-degree(36.9)
  $
]

Selon le principe fondamental de la dynamique, l'accélération subie par un corps de masse $m$ dans un référentiel galiléen est proportionnelle à la résultante des forces qu'il subit, et inversement proportionnelle à sa masse: $sum_k arrow(F_k) = m arrow(a)$.
Comme ce sont des égalités vectorielles, l'accélération a la même direction que la force appliquée.
En cinématique, l'accélération est une grandeur vectorielle qui indique pour un mouvement, si sa vitesse est constante, croissante ou décroissante.
L'accélération moyenne est la variation de vitesse ($Delta v$) divisée par le temps écoulé ($Delta t$) pour changer cette vitesse: $overline(a) = (Delta v) / (Delta t)$ (voir @sec:acceleration-lineaire).
En appliquant ceci à l'équation associée au principe fondamental de la dynamique, nous avons:
$
  sum_k arrow(F_k) = m (Delta arrow(v)) / (Delta t).
$
Pour un exemple simple d'un athlète en contact avec le sol, la somme des forces extérieure sera la force de réaction du sol sur l'athlète plus le poids de l'athlète.

Une #link("https://fr.wikipedia.org/wiki/Force_%28physique%29")[force] est toujours appliquée sur une durée.
Le produit d'une force par son temps d'application est appelé *impulsion*.
Le terme _impulsion_ ne caractérise donc pas la phase de contact lors d'un saut mais une grandeur mécanique définie par l'équation $F Delta t$.
En réorganisant l'équation précédente en envoyant $Delta t$ de l'autre côté$ sum_k arrow(F_k) Delta t = m Delta arrow(v), $on retrouve l'impulsion ($F Delta t$).
En outre, le produit de la masse par la vitesse ($m arrow(v)$) est appelé #link("https://fr.wikipedia.org/wiki/Quantit%C3%A9_de_mouvement")[*quantité de mouvement*].
L'expression se lit donc:
#quote[L'impulsion de la somme des forces extérieures est égale à la variation de quantité de mouvement.]
La variation de vitesse peut tout autant s'écrire comme la différence entre la vitesse finale moins la vitesse initiale: $sum_k arrow(F_k) Delta t = m Delta (arrow(v_f) - arrow(v_i))$.
Il est donc possible de calculer la variation de quantité de mouvement en mesurant la force externe.
À l'inverse, une variation de quantité de mouvement nécessite la création de force.

#figure(
  scaled-include(path("media/impulsion-force.typ"), width: 50%),
  caption: [Impulsion d'une force.],
)<fig:impulse>

Calculer une impulsion revient à calculer l'aire sous la courbe de la force exprimée par rapport au temps.
Les aires peuvent être positives si elles sont au-dessus de l'axe du temps et négative si elles sont en dessous.
En observant des courbes de force, il est possible d'estimer la variation de quantité de mouvement.
Dans le premier exemple (figure ci-dessous), la force montre une impulsion positive suivie d'une impulsion négative.
L'impulsion (l'aire) totale est nulle; ça veut dire que la vitesse initiale et la vitesse finale sont identiques, il n'y a pas eu de variation de quantité de mouvement entre le début et la fin du mouvement.
Ce qui *ne* veut *pas* dire qu'il n'y a pas de déplacement entre le début et la fin.

#interesting-note[
  Illustrons cette impulsion par un mouvement: un sujet depuis une position en squat se relève.
  Au début du mouvement il n'a pas de vitesse (v #sub[i] \= 0 m/s) ensuite il y a une accélération vers de le haut (force positive) suivie d'une décélération pour finir en position droite immobile (v#sub[f] \= 0 m/s).
  La variation de vitesse est bien nulle et la personne a bougé.
  Le second exemple d'impulsion montre quant à lui une variation positive de la quantité de mouvement; l'aire globale est positive.
  La personne a augmenté sa vitesse.


  #figure(
    scaled-include(path("media/impulsions-signees.typ"), width: 90%),
    caption: [Force au cours du temps avec impulsion nulle (A) et impulsion positive (B)],
  )
]

=== Impulsion totale
Les impulsions ne ressemblent pas à un rectangle comme montré à la @fig:impulse mais présentent des variations complexes au cours du temps.
Si la plateforme de force mesure cette force de contact au cours du temps, il faut pouvoir en mesurer l'aire.
L'aire peut être estimée par plusieurs aires élémentaires (exemple des rectangles bleus sur la @fig:trapeze-approximation B).
Plus les *aires élémentaires* sont petites, plus le calcul de l'aire totale sera précise.
Il faut donc enregistrer la force à des fréquences élevées (#eg, #qty[1000][Hz]).
Une autre forme géométrique simple pour les aires élémentaires est le #link("https://fr.wikipedia.org/wiki/Trapeze")[trapèze] (surfaces vertes sur la @fig:trapeze-approximation C).

#figure(
  scaled-include(path("media/aires-elementaires.typ"), width: 95%),
  caption: [Aire sous la courbe (A) et son approximation par des rectangles (B) ou des trapèzes (C).],
)<fig:trapeze-approximation>


Pour calculer l'aire d'un trapèze, il faut deux valeurs de forces $F_k$ et $F_(k+1)$.
Ce calcul revient à calculer un rectangle qui aurait pour hauteur la moyenne de la force entre $F_k$ et $F_(k+1)$:
$ "Aire élémentaire à" t_k = A_k = (F_k + F_(k+1))/2 times (t_(k+1) - t_k). $
L'impulsion totale se définit alors comme la somme des impulsions élémentaires (un rectangle ou un trapèze)
$
  A = sum_(k=0)^(T-1) (F_k + F_(k+1))/2 times (t_(k+1) - t_k).
$

#interesting-note[
  Par exemple, si vous avez mesuré des forces externes consignées dans le tableau suivant, il est possible de calculer l'impulsion et la variation de vitesse.
  Les instants #qty[0.03][s] à #qty[0.09][s] sont écrits en filigrane pour vous laisser l'opportunité de le remplir en exercice.

  <_Toc82333059>Tableau VIII.2. _Calcul d'une impulsion à partir des données de force_

  #{
    let hide(body) = table.cell()[#text(fill: luma(70%), body)]

    set math.frac(style: "horizontal")

    align(center)[#block(fill: white, table(
        columns: 5,
        [Temps \ [#unit[s]]],
        [Force \ [#unit[N]]],
        [$Delta t_k$ \ $t_(k -1) - t_k$],
        [#set math.frac(style: "vertical")
          $ (F_k + F_(k+1))/2 $],
        [Impulsion \ [#unit[N s]]],

        [0.00], [0], [---], [---], [---],
        [0.01], [40], [$0.01-0.00 = 0.01$], [$(0+40) / 2 = 20$], [0.2],
        [0.02], [60], [$0.02-0.01 = 0.01$], [$(40+60) / 2 = 50$], [0.5],

        [0.03],
        [120],
        hide[$0.03-0.02 = 0.01$],
        hide[$(60+120) / 2 = 90$],
        hide[0.9],

        [0.04],
        [150],
        hide[$0.04-0.03 = 0.01$],
        hide[$(120+150) / 2 = 135$],
        hide[1.35],

        [0.05],
        [200],
        hide[$0.05-0.04 = 0.01$],
        hide[$(150+200) / 2 = 175$],
        hide[1.75],

        [0.06],
        [130],
        hide[$0.06-0.05 = 0.01$],
        hide[$(200+130) / 2 = 165$],
        hide[1.65],

        [0.07],
        [140],
        hide[$0.07-0.06 = 0.01$],
        hide[$(130+140) / 2 = 135$],
        hide[1.35],

        [0.08],
        [130],
        hide[$0.08-0.07 = 0.01$],
        hide[$(140+130) / 2 = 135$],
        hide[1.35],

        [0.09], [50], [$0.09-0.08 = 0.01$], [$(130+50) / 2 = 90$], [0.9],

        [0.10], [0], [$0.10-0.09 = 0.01$], [$(0+50) / 2 = 25$], [0.25],

        table.cell(
          fill: interesting-note-background-color,
          stroke: (left: 0pt, bottom: 0pt),
          colspan: 3,
        )[],
        table.cell(
          fill: interesting-note-background-color,
          stroke: (left: 0pt, bottom: 0pt),
          align: right,
        )[*Impulsion totale*],
        [*$10.2$*],
      ))
    ]
  }

  Si l'athlète a une masse de #qty[70][kg], sachant que l'impulsion est égale à la quantité de mouvement, sa variation de vitesse sera de:
  $
    q = m Delta v \
    Delta v = q / m \
    Delta v = 10.2 / 70 approx #qty[0.146][m/s].
  $
  L'unité d'une impulsion est #unit[N x] comme c'est le produit de la force par le temps.
  Or, la force est aussi une quantité d'accélération c'est-à-dire le produit de la masse par l'accélération qui s'exprime en #unit[kg m / s^2].
  En multipliant la force par le temps on retombe également sur l'unité de la quantité de mouvement #unit[kg m / s], soit le produit de la masse par la vitesse.
]

=== Saut vertical
Il est alors possible uniquement à partir de la mesure de la force de calculer la variation de vitesse, voire la vitesse finale si l'on connaît la vitesse initiale.
En saut vertical, par exemple, deux athlètes de même masses peuvent obtenir la même performance, c'est-à-dire la même vitesse de décollage ou encore la même élévation du centre de masse, avec des techniques très différentes.
Un sportif peut partir avec les genoux très fléchis et avoir une extension de toute la chaîne inférieure alors qu'un autre atteindra la même performance avec une courte impulsion uniquement avec une flexion plantaire.

#interesting-note[
  Deux sportifs réalisent un saut vertical.
  Ils partent avec une vitesse nulle et pèsent #qty[70][kg].
  Le premier athlète exerce sur le sol une force verticale moyenne de #qty[1336][N] sur une durée d'impulsion de #qty[300][ms] (#qty[0.300][s]).
  Le second athlète a une impulsion plus brève (#qty[130][ms]) mais applique une force moyenne de #qty[2186][N]. Quelles sont les vitesses verticales d'éjection des deux sportifs? (prendre $g = #qty[9.8][m / s^2]$)

  Pour connaître la variation de vitesse du centre de masse au moment du décollage, il faut considérer l'impulsion de la somme des forces extérieures.
  Les forces extérieures appliquées au système sont le poids ($arrow(W)$) du sujet \[force verticale dirigée vers le bas (négative) d'intensité $arrow(W) = m arrow(g) = 70 times 9.8 = #qty[686][N]$\] et la force de réaction du sol sur l'athlète \[force verticale dirigée vers le haut (positive) d'intensité moyenne #qty[1336][N] ou #qty[2186][N]\].
  La somme des forces donne alors pour le premier athlète $1336 - 686 = #qty[650][N]$ et $2186 - 686 = #qty[1500][N]$ pour le second.

  #figure(
    scaled-include(path("media/forces-saut-vertical.typ"), width: 60%),
    caption: [Forces appliquées à l'athlète],
  )

  L'impulsion est alors calculée comme la force résultante moyenne multipliée par la durée de son application soit $650 times 0.3 = #qty[195][N s] "et" 1500 times 0.13 = #qty[195][N s]$.
  On remarque dès à présent que la variation de vitesse des deux sportifs sera identique.
  L'étape qui vient alors est d'estimer la vitesse au décollage: $arrow(F) Delta t = m Delta arrow(v) = #qty[195][N s]$.
  La variation de vitesse s'exprime comme l'impulsion divisée par la masse:
  $Delta arrow(v) = q / m = 195 / 70 approx #qty[2.786][m /s]$.
  Comme la vitesse avant d'entamer l'impulsion est nulle $arrow(v_i) = 0$, la vitesse finale au décollage sera de: $Delta arrow(v) = arrow(v_f) - arrow(v_i) = 2.786 - 0 = #qty[2.786][m /s]$.

  #figure(
    scaled-include(path("media/impulsions-equivalentes.typ"), width: 80%),
    caption: [Deux impulsions apportant la même variation de vitesse],
  )

]

#interesting-note[
  *À retenir*
  Pour augmenter l'impulsion et par conséquent la variation de vitesse, il faut augmenter la force appliquée (#eg, en faisant de la musculation pour améliorer la force maximale ou en mobilisant les segments libres) et/ou augmenter le temps d'application de cette force (#eg, trouver des techniques pour rester en contact avec l'environnement).
]


=== Pré-appel au saut en longueur
La vitesse de la course d'élan en saut en longueur à l'approche de la planche avoisine les #qty[10][m / s].
A cette vitesse la durée de chaque appui est très courte et rend difficile la création d'une vitesse verticale, paramètre déterminant dans la performance en saut en longueur.
Le pré-appel a pour objectif de préparer l'appel en abaissant le centre de masse.

#figure(caption: [Saut en longueur.])[
  #todo[https://www.youtube.com/watch?v=9N7qMqx9rNs&feature=related]
]

Si l'athlète ralentit légèrement durant cette phase, il arrivera sur la planche avec la jambe d'appel plus fléchie.
Il aura ainsi plus de temps pour créer une force verticale, ainsi augmenter son impulsion et par conséquent sa performance.
Comme la durée reste très courte, la force verticale doit être très intense et tous les segments coordonnés pour la création de l'accélération vers le haut.
Pour simplifier le mouvement, la course d'élan a pour objectif d'avoir une vitesse horizontale importante alors que l'athlète s'organise durant le pré-appel et l'appel pour créer la vitesse verticale.
Il en résulte un angle d'éjection autour de #to-degree(20).

#figure(
  scaled-include(path("media/saut-longueur-pre-appel.typ"), width: 100%),
  caption: [Abaissement du corps lors du pré-appel en saut en longueur],
)

#interesting-note[
  Le record du monde de saut en longueur mesuré comme distance la plus courte entre la planche d'appel et les marques dans le sable est détenue par Mike Powell (USA) avec #qty[8.95][m] en 1991 chez les hommes et Galina Chistyakova (Union Soviétique) chez les femmes en 1988 avec #qty[7.52][m].
]

== Contributions segmentaires
=== Quantités de mouvement et d'accélération
L'expression de la position du centre de masse avait mis en évidence que chaque segment contribue en fonction de sa masse et sa position: $ m arrow(O G)= sum_(k=1)^n m_k arrow(O G_k). $
Le centre de masse est donc un point mobile.
Si on dérive cette expression pour obtenir le produit de la masse par la vitesse du centre de masse, en d'autres termes la quantité de mouvement du corps, nous obtenons l'expression suivante:$ m arrow(v)= sum_(k=1)^n m_k arrow(v_k), $
qui se lit
#quote[la quantité de mouvement du corps, ou résultante cinétique, est égale à la somme des quantités de mouvement de chacun des segments.]
Une fois de plus on remarque que chaque segment contribue en fonction de sa masse et la vitesse de son centre de masse.
Par exemple, si je réalise un squat jump sans ou avec les bras, la performance sera différente car lorsque j'utilise mes bras, ceux-ci ajoutent des quantités de mouvements pour améliorer la performance.
Dans de nombreuses activités la vitesse peut être augmentée juste en utilisant les segments libres: #eg, lancer les bras pour sauter, lancer le genou vers le haut lors d'un saut sur une jambe, lancer ses bras vers l'avant lors de la course.
Comme le tronc représente plus de $50%$ de la masse totale, il est important de donner des consignes sur son mouvement, sa vitesse qui conditionne grandement la performance des mouvements en translation.

Il en est de même pour les quantités d'accélération, produit de la masse par l'accélération; la quantité d'accélération du corps (ou la somme des forces extérieures d'après le principe fondamental de la dynamique) est égale à la somme des quantités d'accélération segmentaires:$ m arrow(a)= sum_(k=1)^n m_k arrow(a_k). $

L'analyse de la phase d'impulsion d'un saut vertical permet d'illustrer la résultante cinétique.
Le modèle choisi ici est simplifié; l'athlète est modélisé par les pieds, les jambes, les cuisses et le complexe tronc-tête-membres supérieurs.
Le mouvement est analysé dans le plan sagittal et considéré symétrique --- les segments à gauche et à droite sont considérés comme un seul corps (#eg, jambes \= jambe droite + jambe gauche).
Dans le cas d'une application numérique d'un tel exercice il ne faut pas oublier que l'athlète a toutefois deux cuisses, deux jambes, etc.
Par exemple, le segment cuisses représente $2 times 10%$ de la masse totale soit #qty[14][kg] pour un sujet de #qty[70][kg].
Rappelons que la somme des masses segmentaires doit toujours donner la masse totale du sujet et dans le cas d'utilisation d'un modèle proportionnel la somme des masses relatives est égale à $1$ ou $100%$.
La résultante cinétique ou quantité de mouvement d'un système multicorps est la somme pour tous les segments du produit de la masse du segment par la vitesse de son centre de masse.
Cette somme est égale à la masse totale du système par la vitesse de son centre de masse.

L'analyse cinématographique du mouvement en deux ou trois dimensions donne la position des articulations au cours du temps.
En associant ces données à un modèle anthropométrique, la position des centres de masse de chacun des segments est obtenue.
Par exemple, le modèle proportionnel de Winter (1990) place les centres de masse segmentaires le long du segment, défini par ses articulations proximale et distale, à une distance qui correspond à un pourcentage donné de la longueur du segment (voir @sec:modeles-anthrometriques).
Une fois la position des centres de masse segmentaires connue au cours du temps, il est possible de calculer leur vitesse en utilisant une technique de différence finie:
$
  v_k = (p_(k+1) - p_(k-1)) / (t_(k+1) - t_(k-1)).
$


Pour connaître la quantité de mouvement de chaque segment ($arrow(p_k)$), il suffit de multiplier la masse du segment ($m_k$) par la vitesse de son centre de masse ($arrow(v_k)$).
La quantité de mouvement, grandeur vectorielle, est le produit d'un scalaire positif (la masse) par un vecteur vitesse.
Il aura de ce fait les mêmes direction et sens que le vecteur vitesse.
Seule sa norme est différente.
La résultante dynamique est finalement la somme de ces vecteurs quantités de mouvement ($p = sum_(k=1)^n p_k$).
Comme le tronc a une masse importante (près de $50%$ de la masse du corps), la quantité de mouvement du tronc est souvent importante dans les mouvements sportifs.
D'un point de vue graphique la somme de vecteurs se représente en mettant les vecteurs les uns après les autres.
Le vecteur résultant commence avec le début du premier vecteur pour se terminer à l'extrémité du dernier.
La résultante cinétique, ou quantité de mouvement totale du système, s'applique au centre de masse.

#figure(
  scaled-include(path("media/kinogramme-squat-jump.typ"), width: 90%),
  caption: [Kinogramme de la phase d'impulsion d'un squat jump ($t_i$ est le temps initial et $t_f$ le temps final)],
)

#figure(
  scaled-include(path("media/resultante-cinetique.typ"), width: 100%),
  caption: [Construction graphique de la résultante cinétique],
)

Nous allons à présent travailler à partir d'un exemple sur les quantités d'accélérations.
Nous avons vu que tout segment contribue par son accélération à l'accélération du centre de masse en fonction de sa masse.
Par conséquent la quantité d'accélération produit un changement des forces extérieures.
Le mouvement choisi sollicite uniquement les bras dans un mouvement d'abduction de #to-degree(180) en #qty[1][s].

#video-figure(
  caption: [Dynamique (cinématique et force) d'une abduction des bras (animation au ralenti durée réelle du mouvement 1 s)],
)[
  #todo[Trouver vidéo]
]

#interesting-note[
  Exercice:

  - Quel est le plan du mouvement?
  - Décrire le mouvement (articulations, mouvements articulaires, axe de rotation)
  - Quelles sont les forces externes?
  - Par simple observation:
    - Quelle est la vitesse initiale? et la vitesse finale?
    - Quelle est la variation totale de vitesse? et l'impulsion des forces extérieures?
    - Dans quelle direction et sens se déplace le centre de masse?
    - Quelle composante de la force de réaction va être affectée?
    - Remplir le tableau en sachant que le sujet pèse #qty[64][kg].
      On utilise le modèle anthropométrique de Winter (voir @table:winter): un membre supérieur est $5%$ de la masse totale.

  Le mouvement est analysé dans le plan frontal par un sujet de #qty[64][kg], c'est une abduction des bras depuis la position anatomique de référence.
  Cette rotation d'axe antéropostérieur se produit au niveau de l'articulation de l'épaule.
  D'un point de vue anatomique se mouvement sollicite les articulations glénohumérale, scapulothoracique et sternoclaviculaire.
  Les forces externes appliquées au système "sujet" sont son poids ($arrow(W)$) et la force de réaction au sol ($arrow(R)$).
  Les vitesses à l'instant initial ($v_i = #qty[0][m / s]$) et à l'instant final sont nulles ($v_f = #qty[0][m / s]$).
  La variation de vitesse entre le début et la fin est par conséquent nulle ($Delta v = #qty[0][m / s]$) de même que l'impulsion totale de la résultante des forces ($arrow(p) = #qty[0][N s]$).
  Comme les bras se déplacent vers le haut, le centre de masse se déplace sur un axe vertical vers le haut en rapport avec la position des centres de masses des membres supérieurs et de leur masse relative.
  Comme les bras sont sans mouvement au début et à la fin, ce mouvement d'abduction demande des accélérations positives puis négatives pour initier puis freiner le mouvement.
  De par les accélérations des membres supérieurs dans le plan frontal, la composante verticale de la réaction au sol va être modifiée en rapport avec les masses accélérées (principe fondamental de la dynamique).

  La vitesse et l'accélération se calculent par différence finie, c'est-à-dire en utilisant l'image avant ($k-1$) et l'image après ($k+1$).
  Il faut ensuite calculer la masse des membres supérieurs ($"MS"$) en utilisant le modèle anthropométrique pour un sujet de masse $m = #qty[64][kg]$:
  $
    m_"MS" = 64 times 5% times 2 = #qty[6.4][kg].
  $
  La quantité d'accélération du corps est la somme des quantités d'accélération segmentaires
  $ m arrow(a)= sum_(k=1)^n m_k arrow(a_k). $
  Dans cet exercice, seuls les membres supérieurs sont en mouvement, le reste du corps a une accélération nulle ($arrow(a_k) = 0$).
  De ce fait la somme des forces extérieures est égale à la quantité d'accélération des membres supérieurs:
  $
    sum_j F_j = m arrow(a) = sum_(k=1)^n m_k arrow(a_k) = m_"MS" times arrow(a_"MS") + arrow(0) \
    sum_j F_j = m_"MS" times arrow(a_"MS").
  $

  La résultante des forces ($sum_j F_j$) est la somme du poids ($arrow(W)$) et de la réaction au sol ($arrow(R)$) nous pouvons écrire:
  $ arrow(W) + arrow(R) = m_"MS" arrow(a_"MS"). $
  Pour obtenir l'intensité de la réaction au sol, le poids peut être soustrait des deux côtés de l'équation, et substituée (par $arrow(W) = m arrow(g)$, où "m" est la masse du corps et $g$ est $9.8$):
  $
    arrow(R)=m_"MS" times arrow(a_"MS") - arrow(W) \
    arrow(R)=m_"MS" times arrow(a_"MS") - m arrow(g)
  $

  Vous pouvez utiliser le @tab:raising-arms pour vous pratiquer.
  #[
    #show figure: set block(breakable: true)

    #figure(
      caption: [Table de calcul pour l'exercice sur l'abduction des bras. La colonne $"CM"_"MS"_y$ représente une mesure fait à partir d'une caméra],
      align(center)[#block(fill: white, table(
          columns: 6,
          fill: (x, y) => if x <= 2 or y == 0 { table-header-color },
          [Image],
          [Instant \ $[#unit[s]]$],
          [$"CM"_"MS"_y$ \ $[#unit[m]]$],
          [$v_"MS"$ \ $[#unit[m / s]]$],
          [$a_"MS"$ \ $[#unit[m / s^2]]$],
          [$m times a#sub[y]$],

          // Lignes générées à partir des données partagées avec les graphiques
          ..abduction-positions
            .enumerate()
            .map(((k, position)) => (
              [#(k + 1)],
              [#abduction-time(k)],
              [#position],
              [],
              [],
              [],
            ))
            .flatten(),
        ))
      ],
    )<tab:raising-arms>
  ]

  En affichant la colonne de temps contre les autres, vous obtenez:
  #figure(
    scaled-include(path("media/abduction-bras-graphiques.typ"), width: 90%),
    caption: [Cinématique (position, vitesse, accélération) du centre de masse des membres supérieurs et, en bas à droite, leur quantité d'accélération],
  )
]
