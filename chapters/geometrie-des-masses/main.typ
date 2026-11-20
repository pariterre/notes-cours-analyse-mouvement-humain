#import "../../common/lib.typ": *
#import "./media/winter-table.typ": winter-table
#import "./media/trampoliniste.typ": (
  trampoliniste-exemple, trampoliniste-jambe, trampoliniste-vierge,
)

= Géométrie des masses
#learning-objectives((
  "Définir le centre de masse du corps",
  "Savoir placer graphiquement le centre de masse en utilisant une table anthropométrique",
  "Analyser les techniques sportives au regard de la position du centre de masse",
  "Définir le moment d'inertie d'un corps",
))

#see-handbook[Chapitre 4]

Le corps humain peut être considéré comme un système de segments articulés; ce n'est pas un corps rigide ni un point.
Son analyse en devient tout de suite plus complexe car il faut connaître la cinématique de chacun des segments ainsi que leur inertie pour pouvoir estimer leur contribution dans le geste.

== Anthropométrie
L'anthropométrie désigne toute technique de mesure des particularités dimensionnelles de l'homme.
Elle a été développée par #link("https://fr.wikipedia.org/wiki/Alphonse_Bertillon")[Alphonse Bertillon] (1853-1914), criminologue français, qui avait déterminé que 14 mensurations permettaient de reconnaître un individu sur 286 millions.
Son système anthropométrique a été utilisé jusque dans les années 1970 en France par la police.
L'anthropométrie aussi simple soit-elle, a son utilité dans de nombreux domaines:
- suivi de la croissance des enfants en ayant des valeurs normalisées (moyennes et écart-type obtenus sur une large population) de la taille et de la masse en fonction des âges;
- ergonomie et design industriel pour mettre en place des postes de travail qui correspondent aux dimensions des personnes et ainsi diminuer la fatigue, augmenter la productivité et éviter les troubles musculo-squelettiques;
- plus largement sur la conception d'équipements qu'ils soient sportifs ou de toute autre nature;
- en orthopédie, des mesures sont prises sur des pièces osseuses dans le cas d'implantation de prothèse osseuses ou segmentaires;
- en biomécanique l'anthropométrie est indispensable pour faire des calculs de la dynamique du mouvement.

En biomécanique l'anthropométrie a pour objectif de déterminer la #link("https://fr.wikipedia.org/wiki/Masse")[masse], la position des #link("https://fr.wikipedia.org/wiki/Barycentre_%28physique%29")[centres de masse] et les #link("https://fr.wikipedia.org/wiki/Moment_d%27inertie")[moments d'inertie] de chacun des segments que l'on appelle paramètres inertiels segmentaires.

== Centre de masse
En physique et en mécanique, le centre de masse (ou #link("https://fr.wikipedia.org/wiki/Barycentre_(physique)")[barycentre]) d'un solide est le centre des masses.
C'est en quelque sorte le point d'équilibre d'un solide, le point que l'on trouve sans en connaître le nom lorsqu'on s'amuse à mettre en équilibre sur son doigt un objet quelconque.
Il est important de connaitre sa position car c'est le point d'application du poids.
Ce point est appelé également centre d'inertie et, dans notre cas (en biomécanique), il coïncide avec le centre de gravité.
Nous emploierons de ce fait l'un des trois termes pour parler de la même entité.

#figure(
  scaled-include(path("media/equilibre-barre.typ"), width: 70%),
  caption: [Le centre de masse est trouvé lorsque l'objet est en équilibre],
)

Si l'on a deux corps $1$ et $2$ de masse $m_1$ et $m_2$ et de position $G_1$ et $G_2$ par rapport à l'origine $O$, l'équilibre s'obtient quand: $m_1 arrow(O G_1) = - m_2 arrow(O G_2)$.
La position du centre de masse $G$ du système se calcule alors comme une moyenne pondérée:
$
  m arrow(O G) = m_1 arrow(O G_1) + m_2 arrow(O G_2),\ " avec" m = m_1 + m_2. \
  arrow(O G) = m_1 / m arrow(O G_1) + m_2 / m arrow(O G_2)
$

où $frac(style: "horizontal", m_1, m)$ est appelé la masse relative du segment $1$, c'est-à-dire sa contribution à la masse totale ($m$).
Par exemple la cuisse représente environ 10% de la masse d'une personne.

#figure(
  scaled-include(path("media/barycentre-levier.typ"), width: 70%),
  caption: [Le barycentre ou centre de masse est toujours plus proche de la partie lourde],
)

Le corps humain a bien entendu plus de deux segments alors on peut généraliser l'expression de deux segments à $n$ segments:
$
  m arrow(O G) = m_1 arrow(O G_1) + m_2 arrow(O G_2) + ... + m_n arrow(O G_n)
$
où $m$ est la masse totale $m = m_1 + m_2 + ... + m_3$.
En introduisant l'opérateur mathématique pour la somme discrète (sigma $Sigma$) pour les segments de $1 "à" n$ on obtient la formulation suivante:
$
  m arrow(O G) = sum_(k=1)^n m_k arrow(O G_k).
$
Cette expression se lit:
#quote[
  Le produit de la masse totale par le vecteur position du centre de masse est égale à la somme des segments $k$ pour $k$ allant de $1 "à" n$ du produit de la masse du segment par le vecteur position de son centre de masse.
]

En divisant par la masse totale, on obtient finalement la position du centre de masse de la personne:
$
  arrow(O G) = sum_(k=1)^n m_k / m arrow(O G_k)
$
Cette expression qui se lit:
#quote[
  Le vecteur position du centre de masse d'un système est égale la somme des segments $k$ pour $k$ allant de $1 "à" n$ du produit de la masse *relative* du segment par le vecteur position de son centre de masse.
]

Comme les segments ont davantage de masse musculaire proche de l'extrémité proximale, le centre de masse des segments est le plus souvent plus proche de l'extrémité proximale que de l'extrémité distale.
On peut situer approximativement le centre de masse d'un segment sur l'axe longitudinal du segment un peu avant la moitié de sa longueur.

#figure(
  scaled-include(path("media/centres-masse-segmentaires.typ"), width: 50%),
  caption: [Les centres de masse segmentaires sont à l'intérieur du segment et sont les points d'application du poids],
)

Ce qu'il faut retenir c'est que la position du centre de masse du corps humain dépend de la position de chacun des segments affectée de sa masse.
On comprend dès lors que le centre de masse se déplace en même temps que les segments.
Si les centres de masse segmentaires sont à l'intérieur du segment, le centre de masse du corps humain peut se situer hors du corps; c'est un point immatériel!
En position anatomique de référence, le centre de masse se situe à l'intérieur de l'abdomen à la hauteur du nombril.
Il existe toutefois une différence entre les hommes et les femmes.
Les hommes ayant plus de masse musculaire au niveau du thorax, la position du centre de masse se situe en moyenne à une hauteur correspondant à 57% de la taille.
Les femmes ont une valeur plus proche de 55% compte tenu d'une morphologie différente avec des masses plus importantes au niveau du bassin et des cuisses.
Ces positions sont bien entendu variables selon les sujets.

#figure(
  scaled-include(path("media/centre-masse-homme-femme.typ"), width: 95%),
  caption: [Position moyenne du centre de masse en position anatomique de référence],
)

== Modèles anthropométriques
<sec:modeles-anthrometriques>
Il existe plusieurs méthodes expérimentales pour déterminer les paramètres inertiels segmentaires.
Le volume des segments s'obtiennent en les plongeant dans un liquide (#eg, de l'eau) et en mesurant l'augmentation de volume (technique d'immersion).
La masse est ensuite obtenue en multipliant le volume par une masse volumique moyenne.
Des pesées dans différentes configurations permettent aussi d'avoir des informations partielles sur la masse et position du centre de masse.

Des techniques d'imagerie médicale sont également utilisées pour déterminer les volumes des tissus osseux, musculaires et adipeux.
En appliquant une valeur de masse volumique pour chaque type de tissu il est alors possible d'estimer les paramètres inertiels segmentaires avec précision.
Cette technique reste toutefois coûteuse.
La technique la plus courante reste l'utilisation de tables ou modèles anthropométriques.

On distingue deux grandes catégories de modèles anthropométriques.
Les premiers sont dits proportionnels car les paramètres inertiels segmentaires sont calculés à partir de régressions linéaires, les seconds sont appelés géométriques car les paramètres inertiels segmentaires proviennent d'une modélisation des segments en formes géométriques plus ou moins complexes.

Le modèle anthropométrique *proportionnel* le plus utilisé est certainement celui proposé par Winter (1990).
Les équations de régression proposées sont souvent fonction d'une seule variable, à savoir la masse totale du corps.
Le @table:winter regroupe les paramètres utiles pour le calcul de la position du centre de masse.


#figure(
  caption: [Modèle anthropométrique de Winter (1990) pour les masses segmentaires et la position des centres de masse],
  align(center)[#winter-table
  ],
)<table:winter>

#interesting-note[
  Par exemple la cuisse représente $0.100$ (soit $10%$) de la masse totale et son centre de masse se situe à $0.433$ (soit $43.3%$) de la longueur de la cuisse définie par son extrémité proximale, le centre articulaire de la hanche; et son extrémité distale est l'axe de rotation du genou.
]

Les modèles les plus complexes sont de type *géométrique* comme ceux d'Hanavan (1964), de Jensen (1978) et de Hatze (1980), qui considèrent le corps humain comme une chaîne arborescente de respectivement 15, 16 et 17 volumes polyarticulés.
Les formes irrégulières des segments sont modélisées par des formes géométriques simples et diverses (#eg, troncs de cônes, boules).
Ils nécessitent de nombreuses mesures anthropométriques (256 pour le modèle de Hatze) entre des longueurs, profondeurs, largeurs et périmètres.


Il est important de noter dans cette table que le segment tête-cou-tronc représente presque 60% de la masse totale.
Ainsi tous les mouvements qui mettent en jeu le tronc avec de grandes accélérations vont nécessiter de grandes forces.
Par exemple pelleter de la neige fraiche peut entrainer des maux de dos car pensant que la neige est légère, on adopte parfois un rythme trop soutenu sans penser qu'à chaque mouvement on accélère toute la masse de son tronc, bien plus lourd que la neige.

== Exemple détaillé
Où se situe le centre de masse de la jambe?
En utilisant la table de Winter et l'image il est possible d'estimer la position du centre de masse du segment.


La première chose à faire est de repérer les centres articulaires (extrémités proximale et distale) donnés par la table de Winter.
Pour la cuisse il faut repérer l'axe du genou et la malléole latérale.
Ensuite on trace le segment qui joint les deux extrémités.
Le plus souvent ce trait suit l'axe longitudinal du segment.
L'étape suivante consiste à mesurer la longueur du segment ($l_("jambe") = #qty[31.5][mm]$); cette longueur multipliée par le rapport donné par la table (position relative du CM) permet de placer le centre de masse du segment.
Pour la jambe on utilise la valeur $0.433$, soit $31.5 times 0.433 = #qty[13.6][mm]$.
On mesure alors depuis l'extrémité proximale la distance obtenue pour placer le centre de masse sur l'axe du segment.
Après projection de la position obtenue sur les axes du repère, il suffit de mesurer les coordonnées.
On peut répéter cet exemple aux différents segments corporels et, en utilisant les masses relatives, trouver la position du centre de masse global.

Où se situe le centre de masse de la trampoliniste?
En utilisant la table de Winter et un modèle à trois segments (membres supérieurs, membres inférieur, tête-cou-tronc) il est possible d'estimer la position du centre de masse du corps.

#figure(
  grid(
    columns: 2,
    column-gutter: 1em,
    row-gutter: 0.5em,
    trampoliniste-jambe(height: 1.7in), trampoliniste-exemple(height: 1.7in),
    [A)], [B)],
  ),
  caption: [Estimation du centre de masse de la trampoliniste (#qty[1.61][m], #qty[55][kg]). A) Placement du centre de masse de la jambe. B) Centres de masse segmentaires du modèle à trois segments],
)


Il faut tout d'abord placer les centres articulaires: la hanche et l'épaule pour le segment tronc-tête-cou, l'épaule et le poignet pour les membres supérieurs et la hanche et la cheville pour les membres inférieurs.
Pour éviter des confusions entre les extrémités proximales et distales il est préférable de dessiner les vecteurs segments orientés (flèche) vers l'extrémité distale.
Une fois les centres de masse segmentaires placés comme dans l'exemple précédent, on mesure leurs coordonnées.
On va utiliser le tableau suivant pour estimer la position du centre de masse du corps de la trampoliniste.

<_Toc82333057>Tableau VII.2. _Calcul de la position du centre de masse du corps_

#{
  align(center)[#table(
      columns: 9,
      fill: (x, y) => {
        if y < 2 { table-header-color } else if (x == 2 or x == 6) and y < 5 {
          table-header-color
        }
      },
      align: horizon,
      inset: 6pt,
      table.cell(rowspan: 2)[Segment],
      [longueur \ $(#unit[mm])$],
      [position \ relative du CM],
      [distance $(#unit[mm])$],
      table.cell(colspan: 2, [Position centre \ de masse
        \ $(#unit[mm])$]),
      [Masse relative],
      // [$m_k / m arrow(O G_k)$],
      // [],
      table.cell(colspan: 2, [Contribution au centre de masse
        \ $(#unit[mm])$]),

      table.cell(fill: table-header-color)[$l$],
      table.cell(fill: table-header-color)[$r$],
      table.cell(fill: table-header-color)[$r times l$],
      table.cell(fill: table-header-color)[$O G_x$],
      table.cell(fill: table-header-color)[$O G_y$],
      table.cell(fill: table-header-color)[$frac(style: "horizontal", m_k, m)$],
      table.cell(fill: table-header-color)[$m_k O G_x$],
      table.cell(fill: table-header-color)[$m_k O G_y$],

      [MI], [57], [0.447], [25.5], [48], [29], [$2 times 0.161$], [15.5], [9.3],
      [TT], [39], [0.66], [25.7], [84], [19], [0.578], [48.6], [11.0],
      [MS],
      [36.5],
      [0.53],
      [19.3],
      [123],
      [34.5],
      [$2 times 0.05$],
      [12.3],
      [3.5],

      table.cell(colspan: 5, stroke: none, []),
      table.cell(colspan: 2, stroke: none)[
        $ arrow(O G) = sum_(k=1)^n m_k / m arrow(O G_k) $],
      [*76.4*],
      [*23.8*],
    )
  ]
}

Chaque segment contribue à la position globale du centre de masse en fonction de sa position et sa masse.
On multiplie la masse relative de chaque segment par la position de son centre de masse ($m_k / m arrow(O G_k)$) en $x$ et $y$.
La somme des contributions de chaque segment donne la position du centre de masse.
Dans cet exemple on remarque qu'en prenant les extrémités du tronc, le segment dessiné ne suit pas le tronc à cause de la lordose lombaire de la trampoliniste dans cette posture d'extension.
Il serait plus précis d'utiliser un modèle qui segmente le tronc en plusieurs parties (#ie, pelvis, abdomen, thorax).

#figure(
  trampoliniste-vierge(),
  caption: [Image vierge pour le calcul de la position du centre de masse de la trampoliniste (#qty[1.61][m], #qty[55][kg])],
)

== Application à des performances sportives
L'exercice précédent montre la méthode pour positionner le centre de masse global d'un sportif.
Il est à présent intéressant de voir comment dans les activités physiques, les athlètes déforment leur corps, adoptent des postures pour améliorer la performance juste par le fait que la position du centre de masse dépend de la position des segments et de leur masse relative.
Avant de détailler le franchissement en saut en hauteur et l'entre-deux en basket-ball, revenons sur les conditions initiales d'une chute libre.
Nous avons vu que la trajectoire en chute libre dépend de la vitesse et de la position initiales.
Il est alors possible d'avoir des gains en performance uniquement en modifiant sa posture au décollage.
En levant les bras et le genou de la jambe libre, le centre de masse est plus haut ce qui va améliorer la performance en saut en longueur ou saut en hauteur par exemple.

=== Saut en hauteur
L'objectif en saut en hauteur est de franchir une barre horizontale la plus haute possible à partir d'une course d'élan et d'une impulsion sur un pied.
Parmi les techniques apparues au cours des années (#eg, ciseaux, rouleau ventral, rouleau costal et _fosbury flop_), seul le _fosbury flop_ est encore utilisé en compétition.
Les autres techniques, bien que moins performantes, comme le ciseau présentent des avantages pédagogiques car elles sont plus simples à acquérir et certainement moins dangereuses mais restent moins performantes.
Ceci s'explique par la distance entre le centre de masse de l'athlète et la barre lors du franchissement.

Le record du monde actuel de la discipline est détenu par le Cubain Javier Sotomayor avec un saut à #qty[2.45][m] en 1993.
Le record féminin est détenu par la Bulgare Stefka Kostadinova avec un saut à #qty[2.09][m] en 1987 à Rome lors des Championnats du monde d'athlétisme.

Le saut en hauteur est un cas de chute libre avec obstacle où il faut maximiser la hauteur.
La performance dépend de trois paramètres:
+ la hauteur du centre de gravité au décollage: il faut la maximiser;
+ l'élévation du centre de gravité après le décollage: il faut la maximiser;
+ la différence de hauteur entre la barre et le centre de masse: il faut la minimiser sans qu'une partie du corps ne touche la barre au point de la faire tomber.

#figure(caption: [Saut en hauteur], kind: "video", supplement: "Vidéo")[
  #todo[https://www.youtube.com/watch?v=IclEQA48IOE]
]

Il faut également que l'apex, #ie, le point le plus haut, de la trajectoire se produise au niveau de la barre (dans le plan horizontal).
Cette succincte analyse du mouvement permet de montrer que la position du corps lors du franchissement est un facteur important de la performance pour minimiser la distance entre la barre et le centre de masse.
Avec une technique de ciseaux, le centre de masse est loin de la barre; cette technique demande d'avoir une vitesse de décollage plus grande que la technique de rouleau ventral ou _fosbury flop_.
L'avantage était toutefois de pouvoir se réceptionner dans le sable sur ses pieds aux temps où les tapis de réception n'existaient pas.
En _fosbury flop_, le centre de masse passe très proche de la barre.
Ainsi pour une même impulsion (#ie, les mêmes qualités physiques), la performance sera meilleure de plusieurs centimètres.

#figure(
  scaled-include(path("media/techniques-saut-hauteur.typ"), width: 90%),
  caption: [Position du centre de masse selon plusieurs techniques de saut],
)

=== Basket-ball --- soccer
Le second exemple est l'entre-deux en basket ou la tête en soccer.
Plus généralement on se pose la question de "comment aller toucher plus haut possible avec sa main ou sa tête?"
Le fait de lever les bras déplace la position du centre de masse vers le haut.
Pour un sujet de #qty[1.70][m], un bras en flexion complète (#ie, dans le prolongement du corps) va entraîner une élévation d'environ #qty[3][cm] et deux bras de #qty[6][cm].
La trajectoire du centre de masse en phase aérienne est déterminée au décollage.
Quelles sont les conséquences de la posture?
On voit qu'au sol (Figure ci-dessous A) selon la position des bras, le centre de masse est plus ou moins haut.
Imaginons qu'ils sautent de la même façon avec la même élévation du centre de masse et qu'ils n'adoptaient pas la même posture au plus haut de leur trajectoire.
En regardant la figure (B) ci-dessous, on remarque qu'en alignant les trois personnages par leur centre de masse, ils n'atteignent pas la même hauteur avec leur tête et leur main.
D'avoir les bras le long du corps permet d'atteindre plus haut avec sa tête; abaisser un bras permet de toucher plus avec sa main qu'avec les deux bras en l'air et, ainsi, de gagner un entre-deux.

#figure(
  scaled-include(path("media/bras-leves.typ"), width: 85%),
  caption: [Avantage de jouer avec la position des segments pour aller plus haut avec sa main ou sa tête lors d'un saut. A) Au sol, lever les bras élève le centre de masse. B) Centres de masse alignés : hauteur atteinte par la tête et par la main],
)

== Moment d'inertie
=== Notion
Le moment d'inertie quantifie la résistance d'un corps soumis à une mise en rotation (ou plus généralement à une accélération angulaire), et a pour grandeur physique $[#unit[kg m^2]]$.
C'est l'analogue de la masse inertielle qui, elle, mesure la résistance d'un corps soumis à une accélération linéaire.
Son expression est $I_O = m d^2$.
Le moment d'inertie calculé au point $O$ est égale à la masse ($m$) multipliée par la distance ($d$) au *carré*.
La notion du centre de rotation est importante.
Dès qu'on calcule des paramètres en rotation, il faut donner le centre de rotation.
Il faudrait être capable de calculer pour chaque point matériel d'un objet le moment d'inertie et en faire la somme pour connaître le moment d'inertie de l'objet.

#interesting-note[
  Le moment d'inertie d'un marteau est-il différent si on le calcule par rapport au bout du manche ou au niveau de la tête?
  En d'autres termes, est-il plus facile de mettre en rotation un marteau en le tenant par la manche ou la tête?

  #figure(
    scaled-include(path("media/marteau-inertie.typ"), width: 70%),
    caption: [Le moment d'inertie du marteau n'est pas le même selon si on le prend par le manche ($O_1$) ou la tête ($O_2$)],
  )

  $
    "Inertie en" O_j = I_O_j = m_1 d_1^2 + m_2 d_2^2 + ... + m_15 d_15^2
  $

  Si on s'intéresse au moment d'inertie calculé en $O_1$; les éléments légers du manche sont proches alors que les masses lourdes sont éloignées.
  Le produit de la masse par la distance au carré pour ces éléments donne une grande valeur.
  Par contre si on calcule le moment d'inertie en $O_2$, les masses lourdes sont proches alors le produit par la distance au carré donne une petite valeur.
  Les masses éloignée sont légères ce qui résulte dans un petit moment d'inertie:

  De façon plus concrète, il est plus facile d'accélérer un marteau en le prenant par la tête que pas le manche.
]

Comme on ne peut pas s'intéresser à chaque point matériel d'un objet, on introduit la notion de rayon de giration, comme si toute la masse du solide était concentrée en un point à la distance $d$ par rapport au centre de rotation.

=== Moment d'inertie du corps humain
Pour la suite du cours, il est important de connaître des valeurs de moment d'inertie du corps dans divers postures.
On remarque que le moment d'inertie en posture groupée, selon un axe transversal est trois fois plus petit qu'en posture droite.
Il sera alors trois fois plus facile de mettre le corps en rotation dans cette posture groupée.
Le moment d'inertie selon l'axe longitudinal est le plus faible, le simple fait d'écarter les bras qui représentent seulement $10%$ de la masse totale double le moment d'inertie car ce paramètre fait intervenir la distance au carré.
Enfin le plus grand moment d'inertie est pour l'axe antéropostérieur.
En effet les masses sont plus éloignées de cet axe que de l'axe transversal.
Prenons par exemple les épaules; la distance entre l'axe de rotation et l'épaule est plus grande de face que de profil.
L'Homme est en général plus large qu'épais!


#figure(
  scaled-include(path("media/moments-inertie-postures.typ"), width: 75%),
  caption: [Moments d'inertie calculés par rapport au centre de masse pour diverses postures. En haut : axe transversal (droit, carpé, groupé). En bas : axe longitudinal (bras le long du corps, bras écartés) et axe antéropostérieur],
)
