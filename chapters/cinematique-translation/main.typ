#import "../../common/lib.typ": *

= Cinématique en translation
#learning-objectives((
  "Savoir calculer un déplacement, une vitesse, une accélération",
  "Déterminer le profil d'une vitesse par la méthode des pentes",
))

#see-handbook[Chapitre 7]

Le mouvement est toujours un mélange de translation et de rotation.
Il est préférable d'analyser ces deux aspects séparément.
Le mouvement comme toutes les entités en translation sont plus simples à appréhender et doivent être maîtrisées avant de poursuivre sur la rotation.

== Déplacement _versus_ distance parcourue
La cinématique repose sur des mesures de temps et de position.
La première notion à développer concerne le *déplacement*.
Un déplacement est une variation de position entre deux instants ou encore la distance en ligne droite entre la position finale et initiale vecteur.
Le déplacement ne tient pas compte de ce qu'il s'est passé entre les deux points de mesure.
La *distance parcourue* est la mesure du trajet total à partir du point de départ jusqu'à l'arrivée.
Elle est toujours plus longue ou égale au déplacement.
La distance parcourue est une notion théorique car il n'est pas possible d'en connaître avec certitude la valeur.
La distance parcourue n'est pas la longueur de la piste ou de la course par exemple car on n'a aucune certitude que l'élève ou l'athlète ait parcouru avec exactitude la trajectoire prévue.


#interesting-note[
  Par exemple, sur une piste d'athlétisme un élève court d'un point $A$ au point $B$. Sa distance parcourue est estimée à #qty[220][m].
  Son déplacement peut se calculer en connaissant les positions de $A$ et $B$:
  $ A = vec(60, 10) "et" B = vec(80, 80). $

  #figure(
    scaled-include(path("media/piste-deplacement.typ"), width: 90%),
    caption: [Distance parcourue _versus_ déplacement sur une piste d'athlétisme.],
  )

  Il est alors possible de calculer avec les valeurs numériques, le vecteur $arrow(A B)$ puis la norme de ce vecteur déplacement:
  $
          arrow(A B) & = vec(80 - 60, 80 - 10) = vec(20, 70) \
    norm(arrow(A B)) & = sqrt(20^2 + 70^2) = sqrt(400 + 4900) \
    norm(arrow(A B)) & approx #qty[72.8][m]
  $

  On voit bien que la distance est plus courte.
]

Pour avec le déplacement le plus précis il faut pouvoir mesurer la position très souvent et calculer le déplacement total comme la somme de petits déplacements.
Pour faire des calculs sur la cinématique du mouvement, il faut de nombreuses mesures de temps et positions correspondantes.

== Vitesse linéaire
Qualifier un athlète, une voiture, un mouvement, etc. de rapide fait appel à la notion de #link("https://fr.wikipedia.org/wiki/Vitesse")[vitesse].
Être rapide c'est effectuer un mouvement ou parcourir une distance dans un temps très court ou parcourir une grande distance dans temps imparti.
C'est le ratio de la distance avec le temps.

Comment peut-on mesurer la vitesse?

Dans de nombreuses activités sportives la vitesse est un paramètre de performance et plusieurs technologies existent pour la mesurer.
En athlétisme la vitesse peut se calculer à partir de la distance de la course et du temps mis par les athlètes; le temps est obtenu par chronométrage manuel ou électronique.
En tennis la vitesse maximale de la balle au service est mesurée par des radars.
Le compteur d'une voiture ou d'un vélo mesure la vitesse à partir d'un compteur d'impulsion; chaque tour de roue génère une impulsion.
Connaissant le nombre d'impulsion pour un temps donné et la circonférence de la roue, on en déduit la vitesse.

En cinématique, la *vitesse* ($arrow(v)$) est une grandeur vectorielle qui mesure pour un mouvement, le rapport de la distance parcourue au temps.
La vitesse moyenne est la variation de position ($Delta arrow(p)$) divisée par le temps écoulé ($Delta t$) pour la franchir:

$
  overline(V) = (Delta p) / (Delta t) = ("Position finale" - "Position initiale") / ("Instant final" - "Instant initial")
$

La notation avec la barre au-dessus du $V$ indique que c'est une valeur moyenne calculée entre deux instants, la valeur initiale et la valeur finale.

#interesting-note[
  Par exemple, calcul de la vitesse moyenne sur #qty[100][m] pour $t_i = #qty[0][s]$ et $t_f = #qty[10][s]$, où $t_i$ dénote le temps au début de la mesure et $t_f$ dénote le temps à la fin de la mesure.
  Les paramètres sont exprimés dans les unités internationales, il suffit d'appliquer la formule précédente:
  $
    overline(V) = (x_f - x_i)/(t_f - t_i) = (100 - 0)/(10 - 0) = #qty[10][m / s]
  $
]

#interesting-note[
  Autre exemple, à partir de la performance d'Usain Bolt au Championnat du Monde 2009 d'athlétisme, on peut calculer la vitesse moyenne de la course mais également tous les 20 mètres car on dispose des temps intermédiaires:

  #{
    show table.cell: it => {
      if it.x == 0 or it.x == 3 { strong(it) } else { it }
    }
    figure(caption: [Course de Usain Bolt (2009)], align(
      center,
    )[#block(fill: white, table(
        columns: 7,
        stroke: (x, y) => if x == 2 { (left: 1pt, right: 1pt) } else { 1pt },
        inset: 6pt,
        [Temps \ $[#unit[s]]$],
        [Distance \ $[#unit[m]]$],
        // Colonne d'espacement : une seule cellule sur toute la hauteur, sans fond
        table.cell(rowspan: 7)[],
        [Intervalles de #qty[20][m]],
        [Durée \ $[#unit[s]]$],
        [Vitesse \ $[#unit[m / s]]$],
        [Vitesse \ $[#unit[km / h]]$],

        [$0.00$], [$0$], [-], [-], [-], [-],
        [$2.89$], [$20$], [$0$ à #qty[20][m]], [$2.89$], [$6.92$], [$24.91$],
        [$4.64$], [$40$], [$20$ à #qty[40][m]], [$4.64$], [$11.43$], [$41.14$],
        [$6.31$], [$60$], [$40$ à #qty[60][m]], [$6.31$], [$11.98$], [$43.11$],
        [$7.92$], [$80$], [$60$ à #qty[80][m]], [$7.92$], [$12.42$], [$44.72$],
        [$9.58$],
        [$100$],
        [$80$ à #qty[100][m]],
        [$9.58$],
        [$12.05$],
        [$43.37$],
      ))
    ])
  }

  À partir des données de temps et distance, on produit le graphique ci-dessous.
  Juste en observant la courbe, et notamment les pentes, on remarque que la vitesse au départ est moins élevée (segment moins incliné, plus faible pente), alors que de $20$ à $100$ mètres les vitesses sont similaires (même pente).

  #figure(
    scaled-include(path("media/sprint-bolt.typ"), width: 80%),
    caption: [Performance de Bolt au 100 m avec temps intermédiaires tous les 20 mètres.],
  )

  Pour chaque intervalle, on calcule tout d'abord le temps écoulé, puis la vitesse moyenne: distance parcourue (#qty[20][m]) divisée par le temps écoulé.
  Pour le premier intervalle, cela donne:
  $
    overline(V_0) = (d_1 - d_0)/(t_1 - t_0) = (20 - 0) / (2.89 - 0) approx #qty[6.92][m / s].
  $

  On répète cette formule pour l'intervalle suivant:
  $
    overline(V_1) = (d_2 - d_1)/(t_2 - t_1) = (40 - 20) / (4.64 - 2.89) approx #qty[11.43][m / s].
  $
  Il est enfin possible d'exprimer cette vitesse qui est en #unit[m / s] en #unit[km / h]: #qty[1000][m] représente #qty[1][km] et #qty[1][h] représente #qty[3600][s].
  De ce fait #qty[6.92][m / s] représente $6.92 times 3600 / 1000 = #qty[24.912][km/h]$.
  Il est possible en cours d'éducation physique d'avoir plusieurs temps intermédiaires pour évaluer comment la vitesse varie selon les parties de la course et ainsi déterminer les points forts et les points faibles des élèves.
]

La *vitesse instantanée* est la dérivée du vecteur position par rapport au temps: $V = (dif x) / (dif t)$.

On utilise $dif t$ lorsque $Delta t$ devient très petit.
Cette formulation est davantage utilisée pour des calculs théoriques.
La vitesse instantanée fait appel à la notion de dérivés.

#figure(
  scaled-include(path("media/derivation-integration.typ"), width: 100%),
  caption: [Relation entre position, vitesse et accélération.],
)

#figure(
  caption: [Fonctions, dérivées et primitives utile en biomécanique],
  align(center)[#table(
      columns: 3,
      align: (col, row) => (auto, auto, auto).at(col),
      inset: 6pt,
      [primitive], [fonction], [dérivée],
      [½ x#super[2]], [x], [1],
      [ ], [x#super[n]], [n x#super[n-1]],
      [kx], [k], [0],
    )
  ],
)

== Dérivées: méthode des pentes
Il est possible de déterminer le profil de la vitesse à partir d'une courbe de la position au cours du temps.
La vitesse est la dérivée de la position par rapport au temps.
La méthode des pentes revient à tracer des tangentes (droite ayant un point de contact avec une courbe) en plusieurs points de la courbe de déplacement et d'estimer leur pente.
Plus les tangentes seront orientées vers le haut, plus la vitesse sera grande, une tangente horizontale sera synonyme de vitesse nulle et une tangente orientée vers le bas donnera une vitesse négative.

#figure(
  scaled-include(path("media/methode-pentes.typ"), width: 85%),
  caption: [Méthode des pentes pour estimer le profil de la vitesse : sur chaque segment, la pente de la courbe de position donne la vitesse.],
)

== Accélération linéaire
L'#link("https://fr.wikipedia.org/wiki/Acc%C3%A9l%C3%A9ration")[accélération] est la dérivée de la vitesse par rapport au temps (la vitesse de la vitesse).
C'est une notion moins simple à se représenter.
La meilleure représentation que l'on puisse en avoir est le fait d'être collé au dossier de son siège lors d'une forte accélération en voiture.
Par contre, en regardant un mouvement simple il est difficile d'avoir une idée de la courbe d'accélération au cours du temps.

#interesting-note[
  Par exemple, un doigt part de l'arrêt et se déplace en ligne droite de la gauche vers la droite puis d'arrête.
  J'essaie d'avoir une vitesse constante au milieu du geste.

  D'après vous quelle courbe décrit le mieux l'accélération de mon doigt? [rouge, vert ou bleu]

  #figure(
    scaled-include(path("media/acceleration-doigt-choix.typ"), width: 100%),
    caption: [Quelle courbe décrit l'accélération de mon doigt?],
  )
]

Si à présent on imagine que mon doigt est une voiture, alors la voiture accélère (accélération positive) pour atteindre une vitesse donnée depuis une position arrêtée, maintient cette vitesse (vitesse constante signifie aucune accélération), puis freine (accélération négative) pour revenir à l'arrêt.

A partir de la position au cours du temps, il est possible par la méthode des pentes de déterminer le profil des courbes de vitesse.
Par contre intuitivement, comme l'accélération est la seconde dérivée de la position, il est difficile d'en avoir une représentation juste.


#figure(
  scaled-include(path("media/cinematique-doigt.typ"), width: 75%),
  caption: [Cinématique du déplacement du doigt.],
)

En cinématique, l'*accélération* est une grandeur vectorielle qui indique pour un mouvement, si sa vitesse est constante, croissante ou décroissante.
L'accélération moyenne est la variation de vitesse ($Delta v$) divisée par le temps écoulé ($Delta t$) pour changer cette vitesse.
$
  overline(A) = (Delta v) / (Delta t) = ("Vitesse finale" - "Vitesse initiale") / ("Instant final" - "Instant initial")
$

L'accélération instantanée est la dérivée du vecteur vitesse par rapport au temps.

La notion d'accélération est liée par la seconde loi de Newton à celle de force.
Tous les mouvements qui partent et finissent à l'arrêt requiert accélération et décélération.
Plus la fréquence des mouvements sera grande, plus l'accélération devra être importante et sollicitera de ce fait les muscles pour produire la force associée l'accélération.

== Mouvements particuliers
Il existe plusieurs mouvements particuliers dont il fait connaître la cinématique.

=== Vitesse nulle
Si la vitesse en nulle tout au long du mouvement, il n'y a pas d'accélération et le système va conserver sa position initiale: si $v(t) = #qty[0][m / s]$, alors $a(t) = #qty[0][m / s^2]$ et $x(t) = x_i$.

=== Vitesse constante: mouvement rectiligne uniforme
Un mouvement rectiligne uniforme est un mouvement sans accélération.
La vitesse à tout moment est égale à la vitesse initiale: si $a(t) = #qty[0][m / s^2]$ alors $v(t) = v_i$.
Le déplacement sera linéaire au temps: $x(t) = v_i t + x_i$.
Lorsque l'on intègre l'accélération pour obtenir la vitesse puis la vitesse pour avoir la position au cours du temps, il ne faut pas oublier d'ajouter la condition initiale, c'est-à-dire la vitesse et la position initiales.
Prenons un exemple: un élève court à une vitesse constante de #qty[5][m / s] pendant #qty[12][s] alors qu'il avait une position initiale de #qty[4][m].
Quelle est sa position finale?
En une seconde il aura parcourue #qty[5][m]; en 2 secondes deux fois plus, soit #qty[10][m]; et en 12 secondes 12 fois plus soit #qty[60][m].
Sa position finale est $60 + 4 = #qty[64][m]$.
C'est pourquoi lorsqu'on définit un système il est important de donner son état initial (position et vitesse).

=== Accélération constante: mouvement rectiligne uniformément accéléré
Dans ce dernier cas, l'accélération est constante $a(t) = k$.
De ce fait la vitesse va être de plus en plus grande ou de plus en plus petite si l'accélération est négative.
La vitesse est linéaire: $v(t) = v_i + k t$.
Le déplacement devient plus compliqué car l'intégration de la vitesse amène des termes au carré (voir tableau V.1).
Le déplacement est $x(t) = x_i + v_i t + 1/2 a t^2$.
C'est une fonction polynomiale du second degré qui a la forme d'une parabole.
