#import "../../common/lib.typ": *

= Approche énergétique de mouvement humain
#learning-objectives((
  "Connaitre les différentes formes d'énergie",
  "Comprendre les principes de conservation et dissipation d'énergie",
  "Être capable de calculer le travail des actionneurs",
  "Comprendre les différences entre puissance métaboliques, puissance des actionneurs et puissance des efforts externes",
))

== Qu'est-ce que l'énergie
Ce chapitre se base en partie sur la #link("https://fr.wikipedia.org/wiki/Thermodynamique")[*thermodynamique*], science de la chaleur ou science des grands systèmes en équilibre.
Cette science fait appel à la notion d'énergie, terme qui nous utilisons tous les jours mais qui a une définition précise en physique.
L'énergie est la capacité d'un système à produire un travail entrainant un mouvement, de la lumière ou de la chaleur; l'énergie s'exprime en Joules (#unit[J]).

- La *première loi* de la thermodynamique stipule que l'énergie est toujours conservée; Les évènements sont des transformations de certaines formes d'énergie en d'autres formes.
- La *seconde loi* dit qu'une transformation n'est pas réversible car il y a toujours une part d'énergie gaspillée sous forme de chaleur.
  Ce phénomène est appelé #link("https://fr.wikipedia.org/wiki/Entropie")[entropie].
  De ce fait toute l'énergie contenue dans le pétrole ne peut pas être transformée en énergie mécanique pour faire avancer l'automobile ou toute l'énergie contenue dans les aliments ne peut pas être utilisée pour produire un effort musculaire.
  La chaleur libérée lors de la transformation permet de réchauffer l'habitacle l'hiver, doit être diffusée par le radiateur l'été ou permet de maintenir le corps à une température entre $37$ et $#to-degree(39)#unit[C]$.


#figure(
  scaled-include(path("media/entropie-conversions.typ"), width: 80%),
  caption: [Phénomène d'entropie : la conversion d'une forme d'énergie en une autre s'accompagne toujours de pertes sous forme de chaleur.],
)

L'unité la plus commune dans la vie de tous les jours pour parler d'énergie est la #link("https://fr.wikipedia.org/wiki/Calorie")[calorie].
En regardant dans un ouvrage de diététique ou directement sur les emballages des aliments il est facile de savoir s'il est préférable de manger une pomme ou une poutine pour un petit encas.
Une calorie correspond à l'énergie nécessaire pour élever la température de $1$ gramme d'eau de $14.5$ à $#to-degree(15.5)#unit[C]$, ce qui équivaut à #qty[4.186][J].
Le plus souvent les informations diététiques sont données en #unit[Cal] (avec un #unit[C] majuscule) qui équivaut en fait à #qty[1000][cal], #qty[1][kcal] ou encore #qty[4186][J].

La chaîne est longue entre l'énergie chimique contenue dans les aliments et le travail mécanique externe qui est donné à titre indicatif sur les ergomètres (vélo stationnaire, rameur, etc.) des salles de sport.
Une fois les aliments digérés et métabolisés pour régénérer l'ATP celle-ci par arrachement d'un phosphate va libérer de l'énergie qui est utilisable par les cellules musculaires.
Une partie de cette énergie libérée sert au maintien de la température corporelle; la contraction musculaire peut elle-même créer un excédent de chaleur qui sera évacuée par un processus de sudation.
Un autre partie de l'énergie sert simplement à résister à la gravité, ne pas tomber.
Ensuite le mouvement est créé par des contractions musculaires; toutefois il existe des co-contractions pour préserver l'intégrité des articulations.
C'est-à-dire que pour un mouvement de flexion les muscles fléchisseurs seront fortement activés mais les extenseurs auront une activité, notamment à l'approche des butées articulaires, qui demande de l'énergie.
La fluidité de mouvement humain repose en partie sur ces co-contractions qui ne sont pas efficaces pour le rendement.
L'énergie du mouvement proprement dit ou énergie cinétique peut être alors estimée par une analyse biomécanique et le travail mécanique est la dernière forme d'énergie qui témoigne de l'énergie mécanique échangée avec l'environnement.
Au final environ trois quart de l'énergie est dissipée sous forme de chaleur.


#figure(
  scaled-include(path("media/puissance-chaine.typ"), width: 100%),
  caption: [De la puissance métabolique à la performance.],
)


== Énergie mécanique
On s'intéresse à différents types d'énergie en mécanique.
Tout d'abord l'#link("https://fr.wikipedia.org/wiki/%C3%89nergie_potentielle_de_pesanteur")[énergie potentielle de pesanteur]: $E_"PP" = m g Delta h$, soit le produit de la masse par la gravité (#ie, le poids) par la hauteur.
Plus un objet est lourd et haut, plus son énergie potentielle de pesanteur est importante.
Il est important de comprendre que l'énergie est une entité à "échanger, transformer".
De ce fait quand on calcule l'énergie potentielle il faut exprimer la hauteur par rapport à une référence (d'où le $Delta$) qui correspondrait à une position où il est y aurait plus de possibilité d'échange.
Par exemple, si on analyse la chute d'un enfant sur un tapis en escalade on prendra comme référence le dessus du tapis et non le sol.

Il en est de même pour #link("https://fr.wikipedia.org/wiki/%C3%89nergie_potentielle_%C3%A9lastique")[l'énergie potentielle élastique] qui se calcule par $E_"PE" = 1 / 2 k Delta x^2$, où k est la raideur du ressort exprimée en #unit[N / m] et $Delta x$ est la variation de la longueur par rapport à l'état de repos.

L'énergie qui correspond au mouvement est appelée énergie cinétique ($E_"C"$) et se décompose en énergie cinétique de translation ($E_"CT"$) et de rotation ($E_"CR"$):
$
  E_"C" = E_"CT" + E_"CR" \
  E_"C" = 1/2 m v^2 + 1/2 I omega^2.
$

On retrouve dans ces expressions les deux composantes des paramètres cinétiques: l'inertie (soit, $m$ et $I$) et la vitesse (soit, $v$ et $omega$).
Il faut noter que la vitesse est au carré.
Si la masse influe sur l'énergie, la vitesse est le paramètre le plus important.

#interesting-note[
  Exercices

  + Calculer l'énergie potentielle de pesanteur ($E_"PP"$) d'un mètre cube l'eau retenue par le barrage Manic-2, sachant que l'eau chute de #qty[70][m] avant d'atteindre les turbines.

    #figure(
      scaled-include(path("media/barrage-manic2.typ"), width: 100%),
      caption: [Barrage hydroélectrique en coupe : l'eau du réservoir chute de #qty[70][m] avant d'atteindre la turbine.],
    )

    $
      E_"PP" = m g h \
      m "d'un mètre cube d'eau" = #qty[1000][kg] \
      E_"PP" = 1000 times 9.81 times 70 \
      E_"PP" = 686" "700 #unit[J] "ou" #qty[686.7][kJ]
    $

  + Calculer l'énergie potentielle de pesanteur d'un plongeur de la tour du #qty[10][m], en assumant un plongeur de #qty[60][kg].

    #figure(
      scaled-include(path("media/plongeon-10m.typ"), width: 45%),
      caption: [Plongeur en haut de la tour de #qty[10][m]; la hauteur est mesurée à partir de la surface de l'eau.],
    )
    $
      E_"PP" = m g h \
      E_"PP" = 60 times 9.81 times 10 \
      E_"PP" = #qty[5886][J] "ou" #qty[5.9][kJ]
    $

    Ainis, même si le plongeur réchauffe l'eau de la piscine à chacun de ses sauts, l'eau du barrage est potentiellement plus efficace pour la production d'électricité ($#qty[686.7][kJ] > #qty[5.9][kJ]$).

  + Calculer l'énergie cinétique de translation d'une voiture (#qty[960][kg]) roulant à #qty[198][km / h], d'un bus (#qty[12][tonnes]) roulant à #qty[108][km / h] et d'une mouche (#qty[20][mg]) volant à #qty[9.72][km / h].

    #{
      set math.frac(style: "horizontal")
      [
        Il faut tout d'abord mettre toutes les grandeurs en unités internationales (#unit[kg] et #unit[m/s]).
        La voiture roule à $198 times 1000 / 3600 = #qty[55][m/s]$, le bus a une masse de $12 * 1000 = 12" "000#unit[kg]$ et roule à $108 times 1000 / 3600 = #qty[30][m/s]$ et la mouche de $20 / 1000 / 1000 = #qty[0.000020][kg]$ vole à $9.72 times 1000 / 3600 = #qty[2.7][m/s]$.
      ]
    }

    On peut alors calculer les énergies cinétiques de translation par l'expression:
    $ E_"CT" = 1/2 m v^2 $

    $
      "Voiture" & => 1/2 times 960 times 55^2 = #qty[1452][kJ] \
      "Autobus" & => 1/2 times 12" "000 times 30^2 = #qty[5400][kJ] \
       "Mouche" & => 1/2 times 0.00002 times 9.72^2 = #qty[7.29e-8][kJ] \
    $

    Bien que le bus roule presque deux fois moins vite que l'automobile comme sa masse est très importante son énergie cinétique est plus élevée.
    La mouche quant à elle, très légère et lente, a conséquemment une énergie cinétique de translation très faible.
]

=== Énergie totale
L'énergie totale ($E_"T"$) du corps humain est à la somme de l'énergie potentielle de pesanteur ($E_"PP"$), l'énergie cinétique de translation ($E_"CT" = 1/2 m v^2$) et l'énergie cinétique de rotation ($E_"CR" = 1/2 I omega^2$):
$
  E_"T" = E_"PP" + E_"CT" + E_"CR" \
  E_"T" = m g h + 1/2 m v^2 + 1/2 I omega^2.
$

Cette énergie demeure constante tant qu'aucune force extérieure n'est en jeu.
De ce fait, l'énergie à tout instant est la même; on peut écrire que l'énergie à l'instant final est égale à celle de l'instant initial:
$
  E_"T"_i = E_"T"_f.
$

#interesting-note[
  Prenons l'exemple d'un pendule illustré par la @vid:dropping-ball ci-dessous.
  Le boulet du pendule est lâché sans vitesse dans une position donnée.
  A cet instant, le boulet possède uniquement de l'énergie potentielle de pesanteur et aucune énergie cinétique.
  #video-figure(caption: [Exemple de conservation de l'énergie, le pendule.])[
    #todo[https://www.youtube.com/watch?v=6XZPhUn5BN4&feature=related]
  ]<vid:dropping-ball>
  Une fois lâché, l'énergie potentielle se transforme progressivement en l'énergie cinétique pour revenir en énergie potentielle.
  En l'absence de frottement avec l'air, le boulet effectuerait ce mouvement de pendule indéfiniment passant d'énergie potentielle en énergie cinétique.
  Ainsi, on note qu'une force de frottement produit un travail négatif qui réduit l'énergie du système jusqu'à l'arrêt de celui-ci.

  #figure(
    scaled-include(path("media/pendule-energie.typ"), width: 90%),
    caption: [Dans un système conservatif comme le pendule, l'énergie potentielle devient de l'énergie cinétique puis revient à l'état d'énergie potentielle; l'énergie totale reste constante.],
  )
]

== Travail d'une force
Une première façon de concevoir le travail ($W$) est simplement la variation d'énergie ($Delta E$) d'un système :
$
  W = Delta E.
$
Ainsi, modifier l'énergie potentielle de pesanteur ($E_"PP"$) ou cinétique ($E_"C"$) est toujours le résultat d'un travail.
Conséquemment, si déplacer un objet ne résulte pas en un changement d'énergie, alors le travail réalisé est nul.

Selon le théorème de l'énergie cinétique, la variation de l'énergie cinétique totale d'un système en mouvement ($Delta E_"C"$) est égale à la somme des travaux pour les déplacements élémentaires réels, de toutes les forces intérieures ($W_F_"int"$) et extérieures ($W_F_"ext"$) appliquées aux points d'un système:
#todo[Discuter avec Mickaël]
$
  Delta E_"C" = W_F_"int" + W_F_"ext".
$
Le travail des forces externes correspond par exemple au travail du poids ou des forces de frottements, c'est-à-dire au travail de toutes les forces qui sont appliquées sur le système.
Le travail des forces internes correspond au travail des actionneurs du mouvement c'est-à-dire au travail des forces musculaires.

Le travail d'une force dépend de celle-ci (la force) et du déplacement de son point d'application.
*Une force dont le point d'application ne bouge pas ne produit pas de travail.*
Dans la figure ci-dessous, la force $arrow(F)$ produit un travail car elle se déplace de $A$ vers $B$.
Le déplacement est le vecteur $arrow(u)$.

#figure(
  scaled-include(path("media/travail-force.typ"), width: 70%),
  caption: [La force $arrow(F)$ produit un travail car son point d'application se déplace de $A$ vers $B$.],
)

Le travail de cette force se calcule à l'aide du #link("https://fr.wikipedia.org/wiki/Produit_scalaire")[produit scalaire] du vecteur force par le vecteur déplacement#footnote([
  Voir un peu plus bas dans le document pour une définition du produit scalaire.
  Pour l'instant, il faut simplement savoir que le produit scalaire peut se calculer par le produit des normes des vecteurs par le cosinus de l'angle entre ces deux vecteurs.
]):
$
  W = arrow(F) dot arrow(u) = norm(arrow(F)) cos(theta) times norm(arrow(u)).
$
Tel que l'équation le montre, le produit scalaire peut s'exprimer comme le produit de trois entités: l'intensité du déplacement ($norm(arrow(u))$), l'intensité de la force ($norm(arrow(F))$), et le cosinus de l'angle entre la force et le déplacement ($cos(theta)$), ou en d'autres mots la portion de $arrow(F)$ alignée avec $arrow(u)$.
Le cosinus de l'angle détermine le signe (positif ou négatif du travail) car les intensités de la force et du déplacement sont positive (ce sont des normes).
En reprenant le #link("https://fr.wikipedia.org/wiki/Cercle_trigonom%C3%A9trique")[cercle trigonométrique], on remarque que le cosinus varie de 1 à (-1).

#figure(
  scaled-include(path("media/travail-cosinus.typ"), width: 70%),
  caption: [Le signe du travail dépend du cosinus de l'angle $theta$ entre la force et le déplacement : positif (moteur) de #to-degree(0) à #to-degree(90), nul à #to-degree(90) et négatif (résistant) au-delà.],
)

Lorsque la force et le déplacement ont strictement la même direction et le même sens, le cosinus vaut~$1$; lorsque la force est perpendiculaire au déplacement, le cosinus est nul de ce fait tout le produit est nul.
*Une force appliquée perpendiculairement au déplacement ne travaille pas.*
Ces trois cas sont illustrés à la @fig:work-of-forces par les forces $arrow(F_1)$, $arrow(F_2)$ et $arrow(F_3)$ avec le déplacement $arrow(u)$ de $A$ vers $B$.
Ce qui donne les expressions suivantes:
$
  W_1 = arrow(F_1) dot arrow(u) = norm(arrow(F_1)) cos(theta_(u,1)) times norm(arrow(u)) = norm(arrow(F_1)) &times & 1 &times norm(arrow(u)) \
  W_2 = arrow(F_2) dot arrow(u) = norm(arrow(F_2)) cos(theta_(u,2)) times norm(arrow(u)) = norm(arrow(F_2)) &times -&1 & times norm(arrow(u)) \
  W_3 = arrow(F_3) dot arrow(u) = norm(arrow(F_3)) cos(theta_(u,3)) times norm(arrow(u)) = norm(arrow(F_3)) &times & 0 &times norm(arrow(u))
$

#figure(caption: [La force F1 produit un travail positif (moteur),
  la force F2 un travail négatif (résistant) et la force F3 un travail nul.])[
  #scaled-include(path("media/travail-trois-forces.typ"), width: 75%)
]<fig:work-of-forces>


Nous avons dit plus haut que le travail peut se calculer comme le produit scalaire entre le vecteur force et le vecteur déplacement.
Le produit scalaire est une opération spécifique entre deux vecteurs.
Il se note par le point central : $arrow(a) dot arrow(b)$, c'est pour cela qu'il est appelé _dot product_ en anglais.
Le nom français renseigne sur la nature du résultat, c'est un scalaire.
En d'autres termes, le produit scalaire entre deux vecteurs donne un nombre.
Il se calcule de la manière suivante:
$
  arrow(a) dot arrow(b) = vec(x_A, y_A, z_A) dot vec(x_B, y_B, z_B) = x_A x_B + y_A y_B + z_A z_B,
$
soit la somme des produits des composantes.

#interesting-note[
  On pourrait, par exemple, reprendre les vecteurs ($arrow(F_1)$, $arrow(F_2)$, $arrow(F_3)$ et $arrow(u)$) de la figure précédente et leur donner des valeurs numériques:
  $
    arrow(F_1) = vec(100, 0, 0)", " arrow(F_2) = vec(-100, 0, 0)", " arrow(F_3) = vec(0, -50, 0) "et" arrow(u) = vec(2, 0, 0).
  $

  En appliquant le produit scalaire, on obtient les travaux suivant:
  $
    arrow(F_1) dot arrow(u) = F_1_x u_x + F_1_y u_y + F_1_z u_z &= &100 &times 2 + &0 &times 0 + 0 times 0 = & 200 \
    arrow(F_2) dot arrow(u) = F_2_x u_x + F_2_y u_y + F_2_z u_z &= -&100 &times 2 + &0 &times 0 + 0 times 0 = - & 200 \
    arrow(F_3) dot arrow(u) = F_3_x u_x + F_3_y u_y + F_3_z u_z &= &0 &times 2 - &50& times 0 + 0 times 0 = & 0 \
  $
]

Une façon équivalente de calculer le produit scalaire est celle présentée précédemment, soit de prendre le produit des normes et de le multiplier par le cosinus de l'angle entre les vecteurs:
$
  arrow(a) dot arrow(b) = norm(arrow(a)) cos(theta_(a,b)) times norm(arrow(b)).
$
Les deux représentations peuvent être utiles selon l'outil de mesure utilisé.

#interesting-note[
  Bien que les deux définitions semblent très différentes, elles arrivent tout de même au même résultat.
  Pour s'en convaincre, on peut reprendre encore une fois les valeurs de l'exemple précédent.
  $
    arrow(F_1) dot arrow(u) = norm(arrow(F_1)) cos(theta_(F_1,u)) times norm(arrow(u)) &=& 100 &times &1 &times 2 = &200 \
    arrow(F_2) dot arrow(u) = norm(arrow(F_2)) cos(theta_(F_2,u)) times norm(arrow(u)) &=& 100 &times -&1 &times 2 = -&200 \
    arrow(F_3) dot arrow(u) = norm(arrow(F_3)) cos(theta_(F_3,u)) times norm(arrow(u)) &=& 50 &times &0 &times 2 = &0 \
  $

]

Si l'on applique à présent le produit scalaire pour calculer le travail du poids#footnote([Attention de ne pas confondre l'abbréviation de "travail" $W$ à celle du "poids" $arrow(W)$.]) ($W_arrow(W)$) lors d'un déplacement donné ($arrow(d)$), nous obtenons l'expression suivante:
$
  W_arrow(W) = arrow(W) dot arrow(d) = vec(0, 0, -m g) dot vec(d_x, d_y, d_z) = 0 d_x + 0 d_y - m g d_z = -m g d_z.
$
Comme le poids n'a qu'une composante selon l'axe vertical, le poids ne fait un travail que dans la direction verticale.
Le corollaire est que les déplacements dans le plan horizontal ne travaillent pas, car ce sont des déplacements qui sont perpendiculaire à la force.
En assumant le fait que $d$ est un déplacement qui a débuté au point $A$ et s'est terminé au point $B$, on peut décomposer le déplacement vertical de la façon suivante: $d_z = h_B - h_A$, où $h_A$ et $h_B$ sont les hauteurs initiales et finales.
Après développement et réarrangement de l'expression du travail du poids, on obtient:
$
  W_arrow(W) = -m g d_z = - m g (h_B - h_A) = -m g h_B + m g h_A \
  W_arrow(W) = m g h_A - m g h_B.
$
Il apparait alors deux expressions de l'énergie potentielle de pesanteur ($E_"PP" = m g h$) qui correspondent aux positions $A$ et $B$.
Le travail du poids est donc l'opposé de la variation d'énergie potentielle entre $A$ et $B$ (début moins la fin): $W_arrow(W) = E_"PP"_A - E_"PP"_B$.

#figure(
  scaled-include(path("media/travail-poids.typ"), width: 65%),
  caption: [Travail du poids de $A$ vers $B$ : le poids étant vertical et constant, seul le déplacement vertical compte, quel que soit le chemin suivi.],
)

Dans le mouvement humain, dû à sa nature temporelle, la force ainsi que le déplacement ne peuvent pas uniquement se représenter par deux vecteurs.
Comme pour les analyses précédents, on va s'intéresser à des petits intervalles de temps, où il est possible de mesurer à la fois le déplacement et la force, qui regroupés dans une image complète du phénomène étudié.
Dans le cas du travail, le travail calculé sur un petit intervalle de temps s'appelle travail élémentaire et se note: $Delta W = arrow(F) Delta arrow(u)$.
Le travail total est la somme des travaux élémentaires, ou l'intégrale si $Delta arrow(u)$ est infiniment petit ($d arrow(u)$) :
$
  W = sum_(t=0)^T arrow(F_t) dot Delta arrow(u)_t "ou" W = integral_(t_i)^t_f arrow(F)(t) dot d arrow(u).
$
Le travail élémentaire peut être positif, négatif ou nul selon les intervalles de temps.

#figure(
  scaled-include(path("media/travaux-elementaires.typ"), width: 85%),
  caption: [Travaux élémentaires de la force $arrow(F)$ entre $A$ et $B$. Le chemin est ici découpé en quatre déplacements, mais ce découpage est arbitraire : plus les déplacements sont petits, plus le calcul est précis. Sur chacun, le travail élémentaire peut être positif ou négatif.],
)


== Puissance
Lorsque l'on parle de la puissance on a souvent en tête le produit de la force par la vitesse : $P = arrow(F) dot arrow(v)$.
Une autre façon de concevoir la puissance est de la définir par la quantité d'énergie ($Delta E$) par unité de temps ($Delta t$) fournie par un système à un autre.
La puissance correspond donc à un débit d'énergie.
$
  P = (Delta E) / (Delta t).
$
Or, nous avons vu que le travail est une variation d'énergie ($W = Delta E$) :
$
  P = (Delta E) / (Delta t) = W / (Delta t).
$
Ainsi, deux systèmes de puissance différente pourront fournir le même travail (#ie, dépenser la même énergie) mais le système le plus puissant sera le plus rapide.
En reprenant l'expression du travail d'une force comme étant le produit scalaire de la force par le déplacement, nous pouvons écrire que la puissance est le produit scalaire de la force par la vitesse:
$
  P = W / (Delta t) = (arrow(F) dot Delta arrow(d)) / (Delta t) = arrow(F) dot (Delta arrow(d)) / (Delta t) \
  "or" (Delta arrow(d)) / (Delta t) "est la définition de la vitesse" arrow(v)\
  P = arrow(F) dot arrow(v)
$
On retrouve bien l'expression classique, à savoir que la puissance est le produit d'une force par une vitesse.

Cette expression est propre à un mouvement en translation.
La puissance d'une façon générale correspond au produit d'une grandeur d'effort (force, moment de force ou coupe, pression, tension, etc.) par une grandeur de flux (respectivement vitesse, vitesse angulaire, débit, intensité du courant, etc.).
Dans le cadre de la mécanique humaine, seules les deux premières expressions nous intéressent:
$
  P_"Translation" = arrow(F) dot arrow(v) \
  P_"Rotation" = arrow(M) dot arrow(omega).
$
Lorsque l'on parle de la puissance articulaire, seul le produit du moment articulaire ou couple articulaire par la vitesse angulaire de l'articulation nous intéresse car le point d'application des forces entre les différents segments ne bouge pas.
En effet on modélise les articulations comme étant des pivots ou des sphéroïdes, c'est-à-dire que les segments ne font que tourner les uns par rapport aux autres, il n'y a pas de translation.

L'unité de la puissance est le Watt $[#unit[W]]$ tel que $#qty[1][W] = #qty[1][J / s]$.
La puissance des moteurs thermiques (#eg, dans les voitures) est exprimée en #link("https://fr.wikipedia.org/wiki/Cheval-vapeur")[cheval-vapeur] pour l'aspect concret et éviter de donner des puissances en Watt avec beaucoup de chiffres.
Un cheval-vapeur $[#unit[ch]]$ correspond à $#qty[1][ch] approx #qty[735.4][W]$ dans le système métrique et $#qty[1][hp] approx #qty[745.7][W]$ dans le système impérial (horse power).
Comme on peut également parle de cheval-vapeur électrique européen ou britannique et d'âne-vapeur, on s'en tiendra aux Watts!

Pour une articulation, la puissance est le produit scalaire entre le moment articulaire ($arrow(M)$) (l'effort à l'articulation généré par toutes les forces musculaires qui croissent l'articulation) et la vitesse angulaire ($omega$).
C'est donc une seule valeur qui rend compte de la puissance de l'articulation selon tous les degrés de liberté.

Prenons l'exemple du mouvement de flexion (positive) --- extension (négative) à l'épaule.
On peut avoir quatre cas s'il y a du mouvement (sinon la puissance est nulle):


<_Toc82333061>Tableau XII.1. _Puissances articulaires: effort concentrique versus excentrique_

#align(center)[#table(
    columns: 3,
    [],
    [Vitesse positive \ (mouvement de flexion)],
    [Vitesse négative \ (mouvement d'extension)],

    [Moment positif \ (effort de flexion)],
    [Effort concentrique de flexion \ _puissance positive_],
    [effort excentrique de flexion \ _puissance négative_],

    [Moment négatif \ (effort d'extension)],
    [effort excentrique d'extension \ _puissance négative_],
    [effort concentrique d'extension \ _puissance positive_],
  )
]

Lorsque la vitesse du mouvement et l'effort ont le même sens (même signe), c'est un effort concentrique et s'ils sont de sens opposés c'est un effort excentrique.
Une contraction concentrique est lorsque les fibres musculaires produisent de la force alors qu'elles se raccourcissent.
A l'opposé la contraction excentrique est une production de force par les fibres musculaires alors que celle-ci s'allonge; elles résistent ou ralentissent un mouvement.

Dans le cas d'une articulation où plusieurs muscles agissent simultanément avec des actions qui peuvent s'opposer (#eg, co-contraction), on s'intéresse à la puissance globale.

#interesting-note[
  Par exemple, calculer la puissance articulaire à l'épaule et au coude pour un mouvement de flexion --- extension (avec la flexion est positive) et interpréter le mouvement.

  Pour l'épaule : \
  - vitesse articulaire $arrow(omega)_"Épaule" = #qty[34][rad/s]$ \
  - moment articulaire $arrow(M)_"Épaule" = #qty[67][N m]$
  Pour le coude : \
  - vitesse articulaire $arrow(omega)_"Coude" = #qty[-45][rad/s]$ \
  - moment articulaire $arrow(M)_"Épaule" = #qty[34][N m]$


  La puissance à l'épaule est égale à
  $
    P_"Épaule" = arrow(M)_"Épaule" dot arrow(omega)_"Épaule" = 34 times 67 = #qty[2278][W]
  $
  C'est un effort de flexion concentrique c'est-à-dire que les fléchisseurs du bras (#eg, grand pectoral, faisceau antérieur du deltoide) produisent de la force musculaire pour générer un effort de flexion qui entraine le déplacement du bras dans cette même direction.

  Au coude, la puissance est de
  $
    P_"Coude" = arrow(M)_"Coude" dot arrow(omega)_"Coude" = -45 times 34 = #qty[-1530][W]
  $
  C'est un effort de flexion excentrique.
  Le biceps brachial et le brachial antérieur produisent un effort de flexion sur le coude toutefois cette force n'est pas suffisante pour déplacer le bras en flexion car la vitesse du bras est négative ce qui implique que le coude s'étend.
]



== Dépense énergétique
Le calcul de la dépense énergétique fait appel soit au théorème de l'énergie cinétique soit aux puissances articulaires.
Rappelons le théorème de l'énergie cinétique:
#quote[
  La variation de l'énergie cinétique totale d'un système en mouvement est égale à la somme des travaux pour les déplacements élémentaires réels, de toutes les forces intérieures et extérieures appliquées aux points d'un système: $Delta E_"C" = W_F_"int" + W_F_"ext"$.
]

Considérons deux forces extérieures: le poids ($arrow(W)$) et une force de contact ($arrow(F)$).
Pour que la force de contact travaille, il faut que son point d'application se déplace (si le déplacement est nul alors le travail est nul) c'est-à-dire qu'il y a glissement.
Le travail des forces externes peut donc être défini par la somme du travail du poids et de la force externe:
$
  W_F_"ext" = W_arrow(W) + W_arrow(F)
$
La variation d'énergie cinétique devient alors:
$
  Delta E_"C" = W_F_"int" + W_arrow(W) + W_arrow(F).
$
Nous avons vu précédemment que le travail du poids est l'opposé de la variation d'énergie potentielle ($W_arrow(W) = -Delta E_"PP"$); l'expression devient alors, après avoir isolé le travail des forces internes:
$
  Delta E_"C" = W_F_"int" + W_arrow(W) - E_"PP" \
  W_F_"int" = Delta E_"C" + Delta E_"PP" - W_arrow(W)
$

Cette expression se lit:
#quote[
  le travail des forces internes est égal à la variation d'énergie cinétique et d'énergie potentielle moins le travail des forces de contact.
]
Pour trouver le travail des forces internes, travail des actionneurs (#ie, muscles), lors d'un mouvement, il calculer l'intégrale tout au long du mouvement cette expression.

On introduit la valeur absolue à l'expression car les travaux excentriques et concentriques demandent tous deux de l'énergie (un travail excentrique ne redonne pas de l'énergie au muscle).
On note ce travail $W_1$:
$
  W_1=integral_(t_i)^(t_f) abs(Delta E_"C" + Delta E_"PP" - W_arrow(F)).
$

La dépense énergétique (ou le travail mécanique des forces internes) peut également se calculer comme la l'intégrale des puissances articulaires, qu'on notera $W_2$.
Comme il y a plusieurs articulations et que les aires peuvent être positives ou négatives, le problème se complique.
Il existe deux formulations principales
$
  W_(2a) = integral_(t_i)^(t_f) abs(sum_k P_k (t)) dif t "et"
  W_(2b) = integral_(t_i)^(t_f) sum_k abs(P_k (t)) dif t.
$

La différence tient dans la position de la valeur absolue $norm("")$.
La première formulation ($W_(2a)$) se lit comme l'intégrale au cours du temps du début à la fin du mouvement de la valeur absolue de la somme des puissances articulaires.
La seconde formulation ($W_(2b)$) prend la valeur absolue des puissances articulaires plutôt que la valeur absolue de la somme des puissances.

Nous allons présenter tout d'abord un exemple graphique pour bien comprendre les étapes de ce calcul (@fig:power-work).
#figure(
  placement: top,
  scaled-include(path("media/travail-puissances.typ"), width: 90%),
  caption: [Calcul du travail à partir des puissances articulaires de l'épaule ($P_e$) et du coude ($P_c$). Méthode 2a : intégrale de la valeur absolue de la somme des puissances; méthode 2b : intégrale de la somme des valeurs absolues des puissances.],
)<fig:power-work>

Premièrement, en utilisant la première formulation ($W_(2a)$), la puissance au cours du temps de deux articulations a été calculée à partir de la vitesse angulaire et du couple articulaire (@fig:power-work A).
L'étape suivante est de calculer la somme des puissances $sum_k P_k (t)$, soit additionner les deux courbes (@fig:power-work B, méthode 2a).
Ensuite on prend la valeur absolue de la somme des puissances à chaque instant $abs(sum_k P_k (t))$, c'est-à-dire que les sommes négatives deviennent positives (@fig:power-work C, méthode 2a).
Il est enfin possible de calculer l'intégrale de cette somme (aire sous la courbe) en utilisant la méthode des trapèzes ou des rectangles par exemple (@fig:power-work D, méthode 2a).

Dans cette formulation, l'aire positive d'une articulation et l'aire négative d'une autre peuvent se compenser.
Cette compensation implique que l'énergie absorbée par le système lors d'un travail excentrique d'une articulation pourrait être réutilisé pour un travail positif d'une autre articulation.

Ensuite, en utilisant la second formulation ($W_(2b)$), la même puissance au cours du temps de deux articulations a été calculée à partir de la vitesse angulaire et du couple articulaire (@fig:power-work A).
Lorsque les puissances articulaires (@fig:power-work A) sont obtenues par le produit de la vitesse angulaire d'une articulation par le couple développé, il faut prendre la valeur absolue des puissances ($abs(P_k (t))$) (@fig:power-work B, méthode 2b).
Ainsi quel que soit le type de contraction (concentrique ou excentrique) on considère la puissance comme positive.
Lorsque l'on additionne les puissances absolues des différentes articulations, il n'y a pas de compensations entre les articulations comme dans la première formulation (@fig:power-work C, méthode 2b).
Il est enfin possible de calculer l'intégrale de cette somme (aire sous la courbe) en utilisant la méthode des trapèzes ou des rectangles par exemple (@fig:power-work D, méthode 2b).

On note que la première formulation ($W_(2a)$) s'approche du calcul obtenu en utilisant par l'équation $W_1$ et donne des valeurs plus faibles, puisque les articulations se compensent.
Inversement, la seconde formulation ($W_(2b)$) donne des valeurs de dépense énergétique plus élevées et approche la valeur maximale théorique.
La valeur réelle de la dépense énergétique est certainement située quelque part entre le resultat de ces deux formulations:
$
  W_1 approx W_(2a) < "Dépense énergétique réelle" < W_(2b).
$

#interesting-note[
  Afin de bien comprendre la différence entre les deux calculs de la dépense énergétique mécanique à partir des puissances articulaires vous pouvez compléter le tableau ci-dessous.
  On s'intéresse à un mouvement quelconque de l'épaule et du coude.
  Les aires élémentaires se calculent par la méthode des trapèzes (avec $Delta t = #qty[0.1][s]$), par exemple pour la méthode 2a :
  $
    "Aire"_k = (a_(k-1) + a_k) / 2 Delta t,
  $
  et de même avec $b_k$ pour la méthode 2b.

  <_Toc82333062>Tableau XII.2. _Calcul de la dépense énergétique à partir des puissances articulaires_

  #figure(
    include "media/tableau-puissances.typ",
    caption: [Calcul de la dépense énergétique à partir des puissances articulaires.],
  )

]

