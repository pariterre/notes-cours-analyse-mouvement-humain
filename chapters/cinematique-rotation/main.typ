#import "../../common/lib.typ": *



= Cinématique en rotation
#learning-objectives((
  "Calculer des déplacements, vitesses, accélérations angulaires",
  "Utiliser la technique des différences finies",
  "Établir le lien entre rotation et translation",
))

#see-handbook[Chapitre 7]

== Rotation
La rotation se mesure dans le langage courant en degrés ou en tours ou révolutions par minute.
En biomécanique il est préférable d'effectuer les calculs en radians et une fois le résultat obtenu on peut le convertir dans une unité plus commune pour avoir une meilleure représentation du phénomène.

En sachant que #qty[1][tour] représente #to-degree(360) ou $2 pi #unit[rad] "ou" #unit[radians]$ ($pi approx 3.1416$), il est possible par un produit en croix d'exprimer tout angle d'une unité dans une autre.

#interesting-note[
  Par exemple, une rotation de #to-degree(30) équivaut à $30/360 times 2 pi = pi / 6 approx #qty[0.52][rad]$.

  En utilisant le produit en croix on écrit: $360 x = 2 pi times 30$, soit en divisant des deux côtés par $360$, on obtient $x = 2 pi times 30 / 360$

  // Produit en croix : les cases en diagonale (même couleur) se multiplient
  #figure(caption: [Produit en croix.], kind: image)[
    #grid(
      columns: 2,
      column-gutter: 2em,
      align: horizon,
      table(
        columns: (5em, 5em),
        align: center + horizon,
        inset: 10pt,
        stroke: 1pt + palette.neutral.line,
        fill: (x, y) => if calc.odd(x + y) { palette.gold.fill } else {
          palette.blue.fill
        },
        table.cell(colspan: 2, inset: 0pt)[],
        // première ligne vide : pas d'en-tête en gras
        text(fill: palette.gold.text)[#to-degree(360)],
        text(fill: palette.blue.text)[$2 pi$],
        text(fill: palette.blue.text)[#to-degree(30)],
        text(fill: palette.gold.text)[$x$],
      ),
      $
        #text(fill: palette.gold.text)[$360 times x$] = #text(fill: palette.blue.text)[$2 pi times 30$]
      $,
    )
  ]
]

Pour savoir si une rotation est positive ou négative, on s'en remet toujours au repère (voir @fig:orthonormal-reference-frame).
Sur la @fig:gymnastic-rotation, le gymnaste tourne dans le sens direct (de $x$ vers $y$) autour de la barre fixe d'un angle de #to-degree(120).
C'est une rotation de $+#to-degree(120)$ selon l'axe $O_z$.
_Pouvez-vous calculer cet angle en radians?_

#figure(
  scaled-include(path("media/gymnaste-barre.typ"), width: 40%),
  caption: [Rotation d'un gymnaste en barre fixe],
)<fig:gymnastic-rotation>


== Vitesse et accélération angulaires
Tout comme pour les vitesses et accélérations linéaires, les dérivées de la position angulaire se calculent en utilisant une variation de rotation sur une variation de temps.
Pour les vitesses et accélérations moyennes nous avons:

$
  overline(omega) = (dif theta) / (dif t) = ("Rotation finale" - "Rotation initiale") / ("Instant initial" - "Instant final")
$
et
$
  overline(alpha) = (dif omega) / (dif t) = ("Vitesse angulaire finale" - "Vitesse angulaire initiale") / ("Instant initial" - "Instant final")
$
où, $overline(omega)$ est la vitesse angulaire moyenne et $overline(alpha)$ est l'accélération angulaire moyenne.
Nous notons les vitesses et accélérations angulaires instantanées par $omega = (dif theta) / (dif t)$ et $alpha = (dif omega) / (dif t)$.

L'utilisation d'une caméra vidéo permet de faire des premiers calculs car nous disposons à la fois du temps (une caméra capture un nombre défini d'images par seconde) et de l'image ce qui permet d'estimer la position linéaire et angulaire.

#interesting-note[

  #figure(
    caption: [Quadruple salto arrière au trapèze],
    kind: "video",
    supplement: "Vidéo",
  )[
    #todo[https://www.youtube.com/watch?v=RyS6Z7qoXrE]
  ]

  Par exemple, calculons la vitesse moyenne pour ce quadruple salto arrière.
  Il ya $18$ images espacées de #qty[0.1][s].
  Si on considère qu'à l'image $1$, $t_i=0$ s et que la rotation est de $1/4$ de salto, la dernière image correspond à $t=#qty[1.7][s]$ avec $4$ saltos.
  La vitesse moyenne est alors $(4-0.25) / (1.7-0) = #qty[2.2][rev / s]$ ou encore  #qty(quantity-separator: none)[792][#sym.degree / s] ou #qty[13.82][rad/s].

  #figure(
    scaled-include(path("media/salto-sequence.typ"), width: 100%),
    caption: [Séquence d'un quadruple salto arrière avec une image toutes les #qty[0.1][s]. La vitesse en $k = 7$ se calcule à partir des images $k - 1$ et $k + 1$.],
  )
]

L'avantage d'utiliser une caméra vidéo est de pouvoir calculer une vitesse moyenne pour chaque image en utilisant l'image d'avant (noté $k-1$) et l'image d'après (notée $k+1$).
Par exemple si on s'intéresse à l'image $k=7$ alors on utilisera les informations de position et de temps des images $6$ (soit, $7-1$) et $8$ (soit, $7+1$).
Il suffit alors de calculer les vitesses et accélérations en utilisant les formules présentées auparavant:

$
  omega_k=(theta_(k+1)-theta_(k-1))/(t_(k+1)-t_(k-1))=(theta_(k+1)-theta_(k-1))/(2 Delta t) \
  alpha_k=(omega_(k+1)-omega_(k-1))/(t_(k+1)-t_(k-1))=(omega_(k+1)-omega_(k-1))/(2 Delta t)
$

où $Delta t$ correspond à la période d'acquisition soit l'inverse de la fréquence.
Comme il faut une image avant et une image après, on ne peut pas calculer la vitesse à la première et à la dernière image.

#interesting-note[
  Par exemple, si on a une caméra vidéo à 25 images par seconde, la période est $1/25 #unit[s]$ soit #qty[0.02][s].
  On peut à nouveau utiliser le produit en croix:

  #figure(
    caption: [Calcul de la durée d'une image pour une caméra à 25 Hz.],
    box(fill: white, align(center)[#table(
        columns: 2,
        align: (col, row) => (auto, auto).at(col),
        inset: 6pt,
        [$25$ images], [$1$ seconde],
        [$1$ image], [$x$],
      )
    ]),
  )
]

== Cinématique angulaire --- cinématique linéaire
#see-handbook[Chapitre 7.5]

Il existe une relation entre la cinématique angulaire et la cinématique linéaire, qui provient de l'expression de la circonférence d'un cercle en fonction de son rayon: $l = 2 pi R$. En fait il est possible de calculer l'arc de cercle décrit par une rotation (#ie, une variation d'angle) par
$d = Delta theta R$, où la rotation est exprimée en radians.
Au lieu de prendre $2 pi$ qui correspond à un tour complet on introduit dans la formule uniquement l'arc de cercle du déplacement angulaire.
En connaissant le temps mis pour effectuer la rotation ou décrire l'arc de cercle, les vitesses angulaires et linéaires peuvent être calculées:
$
  "de" overline(v) = (Delta d) / (Delta t)"," \
  "on substitue" d=R Delta theta "et" omega=(Delta theta)/ (Delta t) \
  "pour obtenir" overline(v) = (R Delta theta) / (Delta t)
$

Le vecteur vitesse est tangent à la trajectoire et sa norme dépend du rayon et de la vitesse angulaire.
En terme d'application, pour augmenter la vitesse linéaire il faut soit augmenter la vitesse de rotation soit augmenter le rayon.
C'est pourquoi il faut avoir les bras tendus lors d'un lancer de disque pour avoir la plus grande vitesse d'éjection possible.

#figure(
  scaled-include(path("media/vitesse-angulaire-lineaire.typ"), width: 50%),
  caption: [Relation entre vitesse angulaire et vitesse linéaire.],
)

La seconde information qui est importante est le fait que la vitesse linéaire est tangentielle à la rotation; ce vecteur vitesse est perpendiculaire au rayon.
Examinons les conséquences à travers le lancer du marteau.
Dans tous les lancers en rotation il faut connaître le moment adéquat pour lâcher le projectile pour qu'il prenne la trajectoire désirée.
Une fois lâcher le projectile suivra une trajectoire parabolique en fonction des paramètres d'éjection.

#interesting-note[
  Par exemple, après plusieurs rotations de plus en plus rapides, à quel moment [1 à 6] l'athlète doit-il lâcher le marteau pour avoir la meilleure performance?

  #figure(
    scaled-include(path("media/lancer-marteau.typ"), width: 55%),
    caption: [Quand faut-il lâcher le marteau pour qu'il retombe dans l'aire de réception?],
  )
]

Comme la vitesse linéaire est tangente à la trajectoire, à l'instant du lâcher le projectile va avoir cette vitesse initiale.
L'objet va donc partir dans une direction perpendiculaire au rayon.
Au lancer de marteau ou disque, il ne faut pas lâcher l'objet en 4 ou 5 sinon le projectile terminera dans la cage de sécurité ou très proche de l'élève qui serait à côté.
Comme la représentation des concepts mécaniques est souvent erronée chez les élèves, il faut anticiper leur comportement.
Les élèves peuvent avoir tendance à lâcher le disque trop tard et ainsi ne pas avoir la trajectoire voulue, ce qui pourrait être dangereux.
Il est alors important de travailler la gestion des trajectoires sur des mouvements de rotation avant de rechercher la performance en donnant des repères visuels (#ie, de réception).
Il ne faut pas oublier que plus le mouvement de rotation est rapide pour augmenter la performance, plus une erreur sur l'instant du lâcher aura des conséquences sur la trajectoire.
Il faut alors laisser suffisamment d'espace entre les lanceurs et les placer avec un léger décalage antéropostérieur les uns par rapport aux autres.

#figure(
  caption: [Lancer de marteau et de disque],
  kind: "video",
  supplement: "Video",
)[
  #todo[https://www.youtube.com/watch?v=GJHAdSqCjuk&feature=related]
  #todo[https://www.youtube.com/watch?v=Lh50gF5l0dw]
]

Les records en disque sont de #qty[74.08][m] ($"masse" = #qty[2][kg]$) chez les hommes par Jürgen Schult en 1986 et #qty[76.80][m] ($"masse" = #qty[1][kg]$) chez les femmes par Gabriele Reinsch en 1988 ce qui correspond à des vitesses d'éjection supérieures à #qty[25][m / s].

En lancer de marteau le record est de #qty[86.74][m] détenu par Yuriy Sedykh depuis 1986 ($"masse" = #qty[7.257][kg]$) et #qty[77.80][m] par Tatyana Lysenko en 2006 par les femmes ($"masse" = #qty[4][kg]$).
L'aire de réception correspond à un secteur de #to-degree(34.92).

#interesting-note[
  Par exemple, il est souvent difficile de se rendre compte de la vitesse linéaire due à un système en rotation.
  Nous allons juste montrer à travers la rotation d'une éolienne comme le rayon est un facteur important.

  Le diamètre d'une éolienne est de #qty[50][m] (soit un rayon de #qty[25][m]).
  La figure provient d'une vidéo à #qty[25][Hz], où seule une image sur trois est représentée (1 #strike[2 3] 4 #strike[5 6] 7 #strike[8]...).

  Approche:
  + numéroter les images
  + calculer le temps à chaque image (image $1$, $t = #qty[0.0][s]$)
  + calculer la vitesse moyenne de rotation
  + calculer la vitesse linéaire en bout de pale

  #figure(
    scaled-include(path("media/eolienne-sequence.typ"), width: 100%),
    caption: [Séquence d'images d'une éolienne à Cap-Chat (rotation dans le sens direct). Le point rouge marque le bout d'une pale.],
  )
]

Une autre application intéressante dans le milieu sportif de la relation entre vitesse angulaire et vitesse linéaire est le pédalage.
Le *développement* d'une bicyclette est la distance parcourue par celle-ci lors d'un tour de pédalier.
Le *braquet* est la combinaison entre le nombre de dents sur le plateau et le nombre de dents sur le pignon.
Le braquet induit un développement, en prenant en compte la taille de la roue motrice (arrière).

#{
  let pedalling = $frac(style: "horizontal", 90, 60)$

  interesting-note[
    A partir des données de grandeur de vélo, il est possible de calculer la vitesse de déplacement du vélo.

    #figure(
      scaled-include(path("media/velo-transmission.typ"), width: 80%),
      caption: [Données d'un problème de développement en vélo.],
    )

    Vitesse de rotation du plateau ($omega_("plateau")$) en radians par seconde ($1$ tour correspond à $2 pi$ et $1$ minute à $60$ secondes)
    $
      omega_("plateau") = pedalling times 2 pi approx #qty[9.4][rad / s]
    $

    Vitesse linéaire de la chaîne ($v_("chaine")$)
    $
      v_("chaine") & = r_("plateau") times omega_("plateau") \
      v_("chaine") & = 0.1 times pedalling times 2 pi approx #qty[0.94][m / s]
    $

    Vitesse de rotation du pignon ($omega_("pignon")$)
    $
      omega_("pignon") & = v_("chaine") / r_("pignon") \
      omega_("pignon") & = (0.1 times pedalling times 2 pi) / r_("pignon") approx #qty[31.4][rad/s]
    $

    Vitesse du vélo ($v_("vélo")$)
    $
      v_("vélo") & = R times omega_("pignon") \
      v_("vélo") & = R times ω_("plateau") times frac(style: "horizontal", r_("plateau"), r_("pignon")) \
      v_("vélo") & = 0.35 times (0.1 times pedalling times 2 pi) / 0.03 \
      v_("vélo") & approx #qty[11][m/s], "soit" #qty[39.6][km/h]
    $
  ]
}

Il faut remarquer dans le calcul que l'on n'utilise pas les valeurs numériques arrondies des résultats précédent ce qui entrainerait une propagation des erreurs.
Il faut garder toutes les décimales du résultat pour le calcul suivant.
Sachez également que votre calculatrice garde en mémoire plus de chiffres qu'elle n'affiche; alors faites les calculs à la suite.
La vitesse du vélo dépend donc du braquet ($frac(style: "horizontal", r_("plateau"), r_("pignon"))$), du diamètre de la roue ($R$) et de la vitesse de pédalage ($omega_("plateau")$).
Ce petit calcul peut être intéressant lors d'achat de vélo ou pour donner des consignes sur le plateau et le pignon que les élèves devraient utiliser pour certaines parties d'un parcours et ainsi avoir un bon rendement physiologique.

On parle souvent de #link("https://fr.wikipedia.org/wiki/Force_centrifuge")[force centrifuge] quand on évoque la rotation.
Cette force que l'on ressent quand on fait tourner une fronde ou un saut plein d'eau, sous-entend qu'il y a une accélération.
Pour obtenir une trajectoire circulaire, il faut qu'il y ait une accélération vers le centre du cercle, c'est-à-dire une accélération #link("https://fr.wikipedia.org/wiki/Force_centrip%C3%A8te")[centripète].
La force centrifuge est la réaction de la force centripète.

Utilisons la @fig:tangent-acceleration pour montrer la relation entre la vitesse de rotation et l'accélération centripète.
La vitesse est perpendiculaire au rayon.
Si on dessine le vecteur vitesse à deux instants $k-1$ et $k+1$ pour calculer l'accélération en $k$, on remarque que l'angle entre les deux vecteurs correspond à l'angle balayer lors de la rotation (car les vecteurs sont perpendiculaires au rayon).
Par construction géométrique on montre que la variation de vitesse et par conséquent que l'accélération est dirigée vers le centre; c'est une accélération centripète.
La norme de l'accélération se calcule par: $a_R = (Delta v)/(Delta t) = r omega^2$


#figure(
  scaled-include(path("media/acceleration-centripete.typ"), width: 100%),
  caption: [Accélération centripète à vitesse angulaire constante.],
)<fig:tangent-acceleration>

Si la vitesse de rotation n'est pas constante alors une accélération tangentielle apparait également qui a comme norme $a_T = r alpha$.
