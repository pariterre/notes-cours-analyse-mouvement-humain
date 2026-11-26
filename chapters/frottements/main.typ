#import "../../common/lib.typ": *

= Frottements sec et visqueux
#learning-objectives((
  "Connaître les conditions de glissement",
  "Intérêt s des forces aérodynamiques: portance et trainée",
  "Connaître les conditions pour flotter et avancer dans l'eau",
))

Dans ce chapitre nous abordons les frottements entre les solides puis avec les fluides.
Les modèles présentés sont les plus simples et reposent sur des hypothèses simplificatrices.
Ce chapitre va nous aider à comprendre pourquoi on modifie notre démarche pour avancer sur la glace, quelles sont ces fameuses forces qui travaillent dans le calcul de la dépense énergétique à partir du théorème de l'énergie cinétique, pourquoi on utilise différentes surface pour faire des équipements sportifs.
Concernant l'aérodynamique nous pourrons comprendre le principe de l'aile d'avion pour voler où avoir un meilleur contact avec le sol dans le cas d'une voiture de cours pour au final comprendre ces forces provenant des écoulements de l'air autour de nous qui "nous ralentissent et nous portent" et quels sont les facteurs qui affectent ces forces.
Enfin en abordant l'hydrodynamique, nous ferons une petite parenthèse sur les conditions de la flottaison avant d'aborder les frottements de l'eau sur un corps, une pale ou un bateau pour comprendre comment créer des forces propulsives et diminuer les résistances.

== Forces de frottement solide
Le frottement d'un objet posé sur le sol dépend du poids de l'objet et de la nature des surfaces en contact.
Un tapis de réception pour la gymnastique ou l'escalade a toujours le même poids mais selon l'endroit où il est placé, il offre une grande résistance au déplacement pour éviter le glissement à chaque réception.
Au contraire placé à l'envers (#ie, sur la surface destinée au contact avec l'élève) il peut glisser très facilement.
Ceci évite également que l'élève ne se blesse car ses pieds sont "accrochés" au tapis ou se brûle au contact de cette surface.
On dit que la force de frottement est une force tangentielle (force dans le même sens que le déplacement) est de direction opposée au déplacement.
Son intensité maximale est donnée d'une façon très simplifiée par la #link("https://fr.wikipedia.org/wiki/Loi_de_Coulomb_%28m%C3%A9canique%29")[loi de Coulomb]: $norm(arrow(F)_t) = mu norm(arrow(F)_n)$; elle est égale au produit du coefficient
de frottement ($mu$) (également appelé coefficient d'adhérence ou de friction) par la grandeur force normale ($F_n$), c'est-à-dire la force perpendiculaire au déplacement.

Dans le cas de l'objet posé sur le sol, le coefficient de frottement dépend des matériaux qui composent revêtement du sol et de la boite et la force normale est la réaction du poids ($arrow(R)_arrow(W)$).
Ainsi, pour un objet de poids $arrow(W)$ déposé au sol avec lequel il existe une friction de coefficient $mu$, il y a une force de friction causée par le poids ($arrow(R)_t_arrow(W)$) :
$
  norm(arrow(R)_t_arrow(W)) & = mu norm(arrow(R)_n_arrow(W)) \
  norm(arrow(R)_t_arrow(W)) & = mu norm(-arrow(W)) = mu norm(arrow(W)).
$
#figure(
  caption: [La force de frottement $arrow(R)_t_arrow(W)$ selon la loi de Coulomb dépend de la force normale du poids $arrow(R)_n_arrow(W)$.],
  scaled-include(path("media/frottement-coulomb.typ"), width: 55%),
)
tel que si une force de traction $arrow(F)$ est appliquée à cet objet, celui-ci ne se mettra en mouvement que si la force de traction est supérieure à la force de friction, soit $norm(arrow(F)) >= mu norm(arrow(W))$.
C'est une valeur limite et on parle dans ce cas de frottement statique ($mu_s$).

Lorsque la force de traction (axe des $x$ de la @fig:friction-coefficients) augmente, la force de frottement augmente sans que l'objet ne bouge.
Pour conserver l'équilibre, cette force de frottement est l'opposé de la force de traction (même direction, sens opposé et même intensité ou norme).
Lorsque la force de traction dépasse l'intensité seuil (la valeur limite), $norm(arrow(F)_t) >= mu norm(arrow(F)_n)$, la boite commence à bouger.
D'après le Principe Fondamental de la Dynamique, l'accélération de l'objet déprendra de la différence entre la force de traction et la force de frottement ainsi que de la masse de l'objet trainé.

Une fois la boite mise en mouvement, quelle que soit la vitesse de déplacement, la force de frottement devient constante et dépend du coefficient de frottement #coefficient-cinetique.name ($mu_(#coefficient-cinetique.symbol)$).
La force maximale de frottement lors de la phase de frottement statique est souvent plus importante que la force de frottement #coefficient-cinetique.name.
On utilise alors un coefficient de friction statique ($mu_s$) et un coefficient de friction #coefficient-cinetique.name ($mu_#coefficient-cinetique.symbol$) tels que $mu_s > mu_#coefficient-cinetique.symbol$.
La force de friction est donc définie par deux équations qui dépendent de la présence ou l'absence d'une vitesse de l'objet tracté:
$
  norm(arrow(R)_t) = cases(
    norm(arrow(F)) & "si" arrow(v) = arrow(0) "et" norm(arrow(F)) <= mu_s norm(arrow(W)),
    mu_(#coefficient-cinetique.symbol) norm(arrow(W)) & "sinon (l'objet glisse)"
  )
$
et $arrow(R)_t$ est toujours de sens opposé au déplacement (ou à la force de traction lorsque l'objet est immobile).

#figure(
  caption: [La force de frottement augmente en fonction de la force de traction puis se stabilise alors que commence le glissement de l'objet.],
  scaled-include(path("media/frottement-traction.typ"), width: 85%),
)<fig:friction-coefficients>


Il est possible de représenter la loi de Coulomb par un cône de frottement.
Tant que le vecteur force de frottement est à l'intérieur du cône, l'objet ne bouge pas, c'est un frottement statique.
Lorsque la résultante (vecteur vertical + vecteur horizontal) atteint le bord du cône alors l'objet bouge et le vecteur restera sur les bords du cône tant que l'objet sera en mouvement car c'est une force seuil.
L'évasement du cône représente le coefficient de friction.
Par exemple pour un coefficient de $1.0$, c'est-à-dire que l'objet ne glissera pas tant que la force horizontale reste inférieure à la force verticale, l'angle du cône sera #to-degree(45).
Si le coefficient de frottement augmente, le cône devient plus évasé et inversement.
Le tableau suivant illustre quelques valeurs de coefficients de frottement.

#figure(
  caption: [La réaction du sol reste dans le cône de frottement, dont l'ouverture dépend du coefficient de frottement ($tan theta = mu$). Si la réaction touche les bords du cône, il y a glissement.],
  scaled-include(path("media/cone-frottement.typ"), width: 50%),
)


#figure(
  caption: [Exemples de coefficients de frottement selon la nature du contact (valeurs indicatives, surfaces sèches; elles varient selon l'état des surfaces).],
  align(center, table(
    columns: 3,
    align: horizon,
    [Contacts],
    [Coefficient de frottement\ statique],
    [Coefficient de frottement\ #coefficient-cinetique.name],

    [Acier --- acier], [$0.7$], [$0.5$],
    [Bois --- bois], [$0.3$], [$0.2$],
    [Garniture de frein --- acier], [$0.2$], [$0.4$],
    [Caoutchouc --- bitume], [$0.9$], [$0.7$],
  )),
)

#interesting-note[
  + #multiple-choice(
      [
        Un livre repose sur une table que l'on incline petit à petit.
        Tant que le livre est immobile, quel est le frottement qui intervient?
      ],
      (
        MultipleChoiceAnswer([Frottement statique], is-right: true),
        MultipleChoiceAnswer([Frottement #coefficient-cinetique.name]),
      ),
    )
  + #multiple-choice(
      [
        Quel est le frottement qui permet à une personne de marcher sur une surface rugueuse sans glisser?
      ],
      (
        MultipleChoiceAnswer([Frottement statique], is-right: true),
        MultipleChoiceAnswer([Frottement #coefficient-cinetique.name]),
      ),
    )
  + #multiple-choice(
      [
        Dans quelle direction est ce frottement?
      ],
      (
        MultipleChoiceAnswer([Vers l'avant], is-right: true),
        MultipleChoiceAnswer([Vers l'arrière]),
      ),
    )

  Pour les deux premières questions, comme il n'y a pas de glissement, on parle de frottement statique.

  Pour la troisième question, il faut premièrement voir que la musculature pousse le pied vers l'arrière, contre le sol.
  Sans frottement, le pied glisserait donc vers l'arrière (comme sur la glace).
  Le frottement s'oppose à ce glissement : il est dirigé vers l'avant, et c'est lui qui propulse la personne.

  #figure(
    caption: [Lors de la poussée, le pied pousse le sol vers l'arrière; le frottement du sol sur le pied est dirigé vers l'avant et propulse la personne.],
    scaled-include(path("media/marche-frottement.typ"), width: 60%),
  )
]

Comment le pattern de marche et de course s'adapte à la glace?
Pourquoi?

Commençons par le pourquoi: le coefficient de frottement statique entre la semelle (caoutchouc) et le pour le revêtement des chaussées et trottoirs (bitume ou asphalte) est plus important que celui entre la semelle et la glace.
De ce fait les chances de glisser sont plus importantes lorsque la force antéropostérieure devient égale au produit du coefficient de frottement statique avec la force d'action verticale du pied sur le sol.
En d'autres termes, on glisse sur la glace dès lors qu'on cherche à produire trop de force vers l'avant (phase de contact avec le talon) ou l'arrière (phase de poussée) alors que l'appui n'est pas chargé, notre poids est encore sur le second pied par exemple.
La technique consiste alors à faire de plus petits pas pour réduire l'intensité de la force antéropostérieure et de marcher les pieds à plat pour limiter les phases d'attaque du talon avec une grande enjambée et phase de poussée jusqu'au bout des orteils, où la force verticale serait trop faible pour éviter le glissement.

#video-figure(caption: [Exemple de course sur la glace])[
  #todo[https://www.youtube.com/watch?v=sFhoDQbWlk4]
]

== Aérodynamique
Dans ces sections concernant la #link("https://fr.wikipedia.org/wiki/Dynamique_des_fluides")[dynamique des fluides], nous nous intéressons spécifiquement aux forces générées par l'air et l'eau.
La dynamique des fluides repose également sur des équations qui sont tirées de l'expérience.
De nombreuses mesures sont indispensables dans cette branche de la mécanique pour avoir une idée précise des caractéristiques #link("https://fr.wikipedia.org/wiki/Aerodynamique")[aérodynamiques] ou hydrodynamique d'un objet.
Par exemple des essais sont effectués dans des souffleries pour mesurer l'aérodynamisme de nouvelles voitures et en bassin de carènes pour les coques de bateau.
En Formule 1, le règlement contraint le temps passé en soufflerie afin de ne pas avantager les grosses écuries qui bénéficieraient de plus d'information pour optimiser la forme des voitures.

L'aérodynamique est une branche de la dynamique des fluides qui porte sur la compréhension et l'analyse des écoulements d'air et leurs effets sur des éléments solides qu'ils environnent.
En aérodynamique, on peut répondre à plusieurs questions sur des phénomènes ou objets qui nous entourent quotidiennement:
- Comment un avion vole-t-il?
- Qu'est-ce qu'une forme aérodynamique?
- Pourquoi une balle de golf a des creux?
- Comment donner un effet à un ballon de soccer pour changer sa trajectoire aérienne?
- Quel est l'avantage de courir en peloton?

Le premier concept à comprendre est celui de #link("https://fr.wikipedia.org/wiki/Vitesse_relative")[vitesse relative].
La vitesse relative du fluide par rapport à l'objet dépend à la fois de la vitesse du fluide (vitesse du vent ou du courant) et la vitesse de déplacement de l'objet.
On s'en rend facilement compte en courant avec ou sans vent.
Quand je cours à #qty[5][m/s] alors que le temps est calme (#ie sans vent), je ressens un vent apparent par la simple faite que je me déplace à une certaine vitesse dans le fluide.
La vitesse relative sera de #qty[5][m/s].
Si à présent, je cours dans un vent de face de #qty[4][m/s] alors j'ai une impression d'un vent plus important.
La vitesse relative devient $4 + 5 = #qty[9][m/s]$.
Au contraire si le vent est dans le dos le vent ressenti est moindre.
La vitesse relative sera dans ce cas $5 - 4 = #qty[1][m/s]$.

Calculer la vitesse relative revient à calculer la différence de vitesse entre l'objet et le fluide.
Attention ce sont des expressions vectorielles des vitesses ce qui fait que si je cours avec un vent de face, ma vitesse est positive et celle du vent négative ($5 - (-4) = 5 + 4 = #qty[9][m/s]$) ou l'opposé.
Une soufflerie est basée sur le concept de vitesse relative.
Plutôt que faire déplacer un objet avec une vitesse importante dans un fluide, l'idée est d'avoir un objet fixe et créer du vent de façon contrôlée.
L'effet aérodynamique est le même sauf que moins de place est nécessaire pour atteindre des vitesses relatives importantes ce qui permet facilement de faire des mesures des efforts occasionnés par le fluide.

=== L'effet Bernoulli ou comment faire voler un avion
En ayant une forme spécifique, les ailes d'un avion vont profiter d'un effet de portance dans le fluide, c'est-à-dire que l'écoulement d'air va générer une force perpendiculaire à l'aile pour permettre le vol de l'avion.
Illustrons cet effet, appelé couramment effet Bernoulli, par un schéma très simple.
L'aile est profilée et inclinée de sorte que l'air qui passe au-dessus (extrados) est dévié et accéléré, tandis que celui qui passe en dessous (intrados) est ralenti.
Selon le principe de Bernoulli, là où l'air va plus vite, la pression est plus faible : il se crée une basse pression sur le dessus de l'aile et une pression plus élevée en dessous.
L'aile est alors "aspirée" vers le haut.
Notons que, contrairement à une idée répandue, les deux filets d'air n'arrivent pas en même temps à l'arrière de l'aile; celui du dessus arrive même avant.

#figure(
  caption: [L'aile d'avion produit de la portance lorsqu'elle se déplace dans un fluide : l'air s'écoule plus vite sur le dessus (basse pression) que sur le dessous.],
  scaled-include(path("media/aile-portance.typ"), width: 85%),
)

On parle alors d'une force de #link("https://fr.wikipedia.org/wiki/Portance")[portance].
Cette force agit perpendiculairement à la direction de l'écoulement.
Une autre force aérodynamique agit quant à elle dans la direction de l'écoulement (résistance au déplacement) et s'appelle force de #link("https://fr.wikipedia.org/wiki/Trainée")[trainée].
Ces forces de résistances s'approchent par des équations de la forme:
$
  R = 1/2 times rho times C times S times v^2
$
où $rho$ représente la #link("https://fr.wikipedia.org/wiki/Masse_volumique")[masse volumique] de l'air (#qty[1.204][kg / m^3] à #to-degree(20)C contre #qty[1.293][kg / m^3] à #to-degree(0)C), $C$ le coefficient de trainée ou portance, $S$ la surface de référence $[#unit[m^2]]$ (celle vue par l'écoulement, également appelée surface frontale), et $v$ la vitesse relative $[#unit[m / s]]$.
Il faut tout d'abord note que la vitesse relative est au carré ce qui veut dire que si la vitesse est multipliée par $2$ (#eg, de $50$ à $#qty[100][km/h]$) alors la résistance sera multipliée par $4$.
C'est ce qui explique principalement que l'on consomme plus de carburant quand on roule vite pour parcourir la même distance (le rendement du moteur intervient également).
La masse volumique $[#unit[kg / m^3]]$ de l'air est quant à elle influencée par l'altitude.
Ainsi des performances plus élevées peuvent être atteintes en altitude (#eg, Mexico), notamment pour les courses de courte distance où l'aérobie entre peu en jeu.
Le coefficient de trainée ou portance est la caractéristique intrinsèque du profil.
Le coefficient de trainée est noté $C_x$ car elle agit dans la dimension horizontale, alors que celui de portance prend la notation $C_z$ car elle agit dans la dimension verticale.

Le produit de la surface de référence par le coefficient ($C_x S$) est déterminé en soufflerie: une turbine envoie un écoulement laminaire d'air à une vitesse contrôlée.
L'objet (#eg, skieur, cycliste sur son vélo, voiture) sont accrochés au sol et les forces de réaction avec le sol sont mesurées à l'aide de plateformes de force.
On mesure ainsi pour différentes vitesses de vent les forces de portance et de trainée et il est possible de déterminer le produit surface par coefficient connaissant la masse volumique de l'air.


#figure(
  caption: [Le déplacement dans un fluide provoque une force de portance et une force de trainée, dont la somme est la force aérodynamique résultante.],
  scaled-include(path("media/portance-trainee.typ"), width: 75%),
)

Pour augmenter la vitesse relative et par conséquent la force de portée, les avions décollent généralement contre le vent.

=== Trainée de forme
Des variations brutales de la forme de l'objet entrainent de la turbulence et par conséquent de la résistance supplémentaire, c'est la trainée de forme.
Entre un cube, une boule et un profil en goutte d'eau (de même surface frontale), la trainée de forme passe de $100%$ à $50%$ puis $5%$.
Ainsi, la forme a un effet très important sur la résistance aérodynamique.
C'est cet aspect qui permet de qualifier un objet de forme plus ou moins aérodynamique.


#figure(
  caption: [La forme de l'objet a une grande influence sur la résistance aérodynamique ou hydrodynamique. Pour une même surface frontale, la traînée de forme d'une goutte d'eau n'est que de $5%$ de celle d'un cube.],
  scaled-include(path("media/trainee-forme.typ"), width: 85%),
)

Dans les activités de lancer en athlétisme, notamment le lancer de disque, la position de l'engin en phase aérienne va avoir une importance majeure de la performance.
Il faut que le disque se déplace à plat dans l'écoulement pour réduire la force de trainée mais un léger angle va favoriser la portance.

==== La posture en cyclisme
Le produit $C_x S$ en cyclisme est fortement modifié par la posture du cycliste sur le vélo.
Pour une position traditionnelle avec les bras tendus le produit est d'environ $0.4$. Si on applique la forme de la force de trainée à une vitesse de #qty[10][m/s] (attention à mettre la vitesse dans les unités internationale), on obtient alors $R = 1/2 times 1.204 times 0.4 times 10^2 = #qty[24.08][N]$. Lorsque le tronc se courbe vers l'avant alors que les bras se fléchissent, le produit descend à $0.35$ voire $0.3$ si les coudes sont posés en avant du guidon.
A l'extrême, position du contre la montre avec casque profilé, le $C_x S$ prend une valeur proche de $0.25$.

#figure(
  caption: [Plus le cycliste s'abaisse et s'allonge sur son vélo, plus le produit $C_x S$, et donc la force de trainée, diminue.],
  scaled-include(path("media/cycliste-postures.typ"), width: 90%),
)

==== La balle de golf
La forme de la balle de golf avec des creux est très complexe.
Il est presque plus facile de simuler avec précision les écoulements autour d'un avion qu'autour d'une balle de golf.
Les joueurs, aux temps où la balle était lisse, se sont rendu compte que les balles abîmées allaient plus loin.
Il existe aujourd'hui de nombreux brevets quant à la répartition, au nombre et à la forme des creux pour augmenter la performance en termes de distance parcourue.
Les creux permettent "d'accrocher" les couches d'air et les turbulences arrivent plus tard.
Moins d'énergie est alors perdue par les turbulences ce qui favorise une plus longue trajectoire aérienne.

==== Dépense énergétique en course
Dans d'autres activités où les vitesses sont moindres la résistance aérodynamique ne doit pas être négligée.
En sprint (#qty[100][m]) par exemple, $13%$ du travail ou de la dépense énergétique est due à la résistance de l'air.
Dès que la vitesse diminue comme au marathon cette valeur chute à environ $7.5%$ alors qu'une économie d'énergie de $6.5%$ est notée lors d'une course à l'intérieur du peloton.
En cyclisme à haut niveau, les cyclistes dans le peloton peuvent économiser jusqu'à $30%$ de leur énergie ce qui se traduit par 30 à 40 pulsation cardiaques par minute (bpm) de moins.
La stratégie d'équipe en cyclisme est de se relayer en tête du peloton pour que les co-équipiers fournissent moins d'effort.

=== Trainée de surface
Ces exemples étaient liés à la trainée de force.
Il existe également la trainée de surface qui est due à la viscosité de l'air qui "colle" à la surface.
Les couches proches de la surface sont ralenties et frottent avec les suivantes entrainant une dépense d'énergie donc une résistance supplémentaire.
L'épaisseur où le fluide est ralenti s'appelle #link("https://fr.wikipedia.org/wiki/Couche_limite")[couche limite].
Afin de réduire cette trainée de surface, les matériaux utilisés dans les équipements sportifs ont évolués comme en patin de vitesse, ski de descente ou en natation où cette trainée existe également dans l'eau.

=== L'Effet Magnus
Dans le chapitre sur la chute libre, nous avons montré en partant du Principe Fondamental de la Dynamique que la vitesse horizontale était constante.
Le poids est la seule force appliquée sur le système et comme sa direction est verticale, aucune force n'agit sur les composantes horizontale et la vitesse s'en trouve inchangée jusqu'au contact avec le sol ou autre partie de l'environnement.
Dès lors que l'on considère les frottements aérodynamiques les choses deviennent plus complexes mais par cette considération on peut expliquer qu'en parachutisme le sauteur atteint une vitesse limite car la résistance aérodynamique (force de trainée car la direction du fluide est verticale) s'oppose au poids de telle sorte que la somme des forces extérieures devient nulle et le sauteur conserve sa vitesse.
En jouant sur sa posture et ainsi en modifiant son $C_x S$ il peut modifier sa vitesse jusqu'à retrouver une vitesse stable.

Un autre phénomène observable est #link("https://fr.wikipedia.org/wiki/Effet_Magnus_et_turbulence_dans_le_football")[l'effet Magnus]: la trajectoire d'une frappe au soccer devient courbe sur la fin et permet par exemple d'éviter un mur lors d'un coup de pied arrêté.


#figure(
  caption: [L'effet Magnus permet de modifier la trajectoire d'un ballon. Frappé avec une rotation, le ballon part presque en ligne droite (étape turbulente) puis sa trajectoire s'incurve en fin de course (étape laminaire), ce qui lui permet de contourner le mur.],
  scaled-include(path("media/effet-magnus-soccer.typ"), width: 50%),
)
#video-figure(caption: [L'effet Magnus en soccer.])[
  #todo[https://www.youtube.com/watch?v=ZmbxkhhiV6A]
]

Ce changement de trajectoire implique une force et comme le ballon n'est en contact qu'avec l'air, c'est une force aérodynamique.
L'explication est la suivante:
Le ballon décolle avec une rotation d'axe vertical dans le sens direct (sens inverse des aiguilles d'une montre) et un vecteur vitesse vers la droite pour éviter le mur formé par les joueurs adverses.
Sans forces dues à l'écoulement aérodynamique le ballon passerait à côté des buts.
Dans une première phase où la vitesse de la balle est très importante, l'écoulement du fluide autour du ballon est #link("https://fr.wikipedia.org/wiki/Turbulence")[turbulent].
À ce moment le fluide ralentit le ballon mais il est trop instable et désordonné pour que la rotation du ballon sur lui-même puisse modifier sa trajectoire.
Alors que la vitesse du ballon est plus faible, l'écoulement devient #link("https://fr.wikipedia.org/wiki/%C3%89coulement_laminaire")[laminaire] et stable.

Une différence de vitesse du fluide se crée alors entre le côté gauche et le côté droit du ballon (vue de dessus).
La vitesse du fluide s'ajoute à la vitesse de rotation.
Ainsi la vitesse à gauche devient plus importante et celle de droite est réduite.
Comme l'aile d'avion une différence de pression se crée entre les deux côté du ballon et une force de la droite (haute pression) vers la gauche (basse pression) agit sur le ballon.
Le ballon voit sa vitesse initiale vers la droite diminuer et au bout de quelques instants cette vitesse est dirigée vers la gauche pour prendre la direction du but.

#figure(
  caption: [L'effet Magnus provient de la rotation de la balle sur elle-même qui crée des variations de pressions et une force des hautes vers les basses pressions (ballon vu de dessus, qui avance vers le haut).],
  scaled-include(path("media/effet-magnus-pression.typ"), width: 70%),
)

Il est à noter qu'une rotation d'une balle ou d'un ballon va également avoir des conséquences sur la trajectoire lors de rebond.
Cet aspect ne dépend pas des forces aérodynamiques mais des énergies cinétiques en translation et rotation qui modifie la trajectoire lors de la phase de contact à cause des forces de frottement.
Ces changements de trajectoire sont illustrés par la figure suivante:

#figure(
  caption: [Lors de la phase de contact, la rotation d'une balle sur elle-même entraine des changements de direction. Le rebond sans rotation est en pointillé.],
  scaled-include(path("media/rebond-rotation.typ"), width: 75%),
)

== Flottaison
Avant d'aborder les résistances hydrodynamiques qui nous ralentissent dans nos déplacements mais permettent également au nageur ou kayakiste d'avancer, nous allons présenter les aspects mécaniques associés à la flottaison d'un corps.

Selon le principe ou poussée d'#link("https://fr.wikipedia.org/wiki/Archim%C3%A8de")[Archimède]:
#quote[
  tout corps plongé dans un fluide au repos, entièrement mouillé par celui-ci ou traversant sa surface libre, subit une force verticale dirigée de bas en haut et opposée au poids du volume de fluide déplacé ($V$); cette force est appelée poussée d'Archimède ($arrow(P)_A$).]
$
  arrow(P)_A = - rho V arrow(g).
$

La masse d'un objet peut se calculer comme le produit de son volume ($V$) par sa #link("https://fr.wikipedia.org/wiki/Masse_volumique")[masse volumique] ($rho$).
Dans le cadre de la poussée d'Archimède ce n'est pas la masse de l'objet mais celle du fluide déplacé, celui de l'eau dans cette partie sur l'hydrodynamique.
Il en serait de même dans l'air pour faire "flotter" une montgolfière.
Pour obtenir le poids du volume de fluide déplacé, il suffit alors de multiplier par le vecteur gravité (vecteur accélération vertical, dirigé vers le bas et d'intensité #qty[9.81][m / s^2]).
Ensuite un prendre l'opposé de l'expression pour avoir une force dirigée vers le haut.

En analysant les unités des paramètres impliqués dans cette expression: masse volumique $[#unit[kg / m^3]]$, volume $[#unit[m^3]]$ et accélération gravitaire $[#unit[m / s^2]]$, la poussée d'Archimède a pour unité (après simplification) de: $[#unit[kg m / s^2]]$ ce qui revient à des Newton (puisque #qty[1][N] = #qty[1][kg m / s^2]).
La poussée d'Archimède est bien une force.

Pour faciliter la compréhension, prenons l'exemple simple de quatre cubes de bois de #qty[10][cm] de côté et de matières différentes: balsa (masse volumique, $rho = #qty[100][kg / m^3]$), de sapin ($rho = #qty[500][kg / m^3]$), d'olivier ($rho = #qty[1000][kg / m^3]$) et de gaïac ($rho = #qty[1000][kg / m^3]$).

Comment flottent ces cubes?
On va partager cette question en deux expériences: que se passe-t-il lorsque je pose ces cubes à la surface de l'eau? et que se passe t'il si je les plonge dans l'eau?

_Que se passe-t-il lorsque je pose ces cubes à la surface de l'eau?_ (@fig:archimedes-cubes A et B)
Il faut calculer successivement le volume, la masse et le poids de chaque cube puis il faudra déterminer l'intensité de la poussée d'Archimède pour obtenir l'équilibre.
Le volume ($V$) se calcule comme le produit de la longueur par la largeur par la hauteur ou dans le cas précis du cube comme le côté à la puissance 3 (#ie, au cube): $V = 0.1^3 = #qty[0.001][m^3]$.
Le volume est le même pour les quatre cubes.

Leur masse diffère comme ils n'ont pas la même masse volumique: c'est le produit de leur volume par leur masse volumique: $m = rho times V$.
Nous obtenons des masses de $m_"balsa" = #qty[0.1][kg]$, $m_"sapin" = #qty[0.5][kg]$, $m_"olivier" = #qty[1.0][kg]$ et $m_"gaïac" = #qty[1.4][kg]$ pour les quatre cubes de bois différents.
Il est alors facile de calculer l'intensité du poids en multipliant par l'accélération de gravité #qty[-9.81][m / s^2].
Pour obtenir l'équilibre du cube dans l'eau, nous appliquons le Principe Fondamental de la Dynamique tel que la somme des forces appliquées sur le cube, le poids $arrow(W)$ et la poussée d'Archimède ($arrow(P)_A$), est égale à la masse fois l'accélération soit un vecteur nul dans notre cas d'équilibre (#ie, sans accélération):
$
  arrow(W) + arrow(P)_A = arrow(0) "ou" \
  arrow(W) = -arrow(P)_A.
$
En développant l'expression du poids et de la poussée d'Archimède
$
  arrow(W) = m arrow(g) "et" arrow(P)_A = -rho_"eau" V_I arrow(g),
$
avec $m$ la masse de l'objet, $rho_"eau" = #qty[1000][kg / m^3]$ la masse volumique de l'eau (un mètre cube d'eau pèse 1 tonne) et $V_I$ le volume d'eau déplacé (en d'autres mots, le volume immergé) --- paramètre qui va nous mener à la solution --- l'expression devient:
$
  m_"cube" arrow(g) & = rho_"eau" V_I arrow(g) \
           m_"cube" & = rho_"eau" V_I.
$
Sachant que $rho = m / V$ ou $m = rho V$, on peut exprimer l'expression précédente en fonction du volume du cube ($V_"cube"$):
$
  rho_"cube" V_"cube" = rho_"eau" V_I \
  V_I = rho_"cube" / rho_"eau" V_"cube"
$
Si le volume immergé ($V_I$) est plus grand que le volume de l'objet ($V_"cube"$), alors celui-ci coule.
Au contraire, si le volume immergé est plus petit, l'objet flotte.

Dans le premier cas (cube de balsa, bois très léger) nous avons:
$
  V_I = rho_"cube" / rho_"eau" V_"cube" = 100 / 1000 times 0.001\
  V_I = #qty[0.0001][m^3] "ou" V_I = 10% V_"cube".
$
Le volume déplacé pour obtenir l'équilibre correspond donc à 1/10 du volume du cube.
Seul 1/10 (le fond du cube) doit être immergé pour que le cube flotte.
Pour le second cube, le volume devient $V = #qty[0.0005][m^3]$, soit la moitié du cube.
Le troisième doit être complètement immergé pour flotter.
Quant au dernier, le volume immergé devrait être égale à $V_I = #qty[0.0014][m^3]$, soit un volume supérieur au volume du cube.
Ce cas est impossible, le cube va simplement tomber dans le fond de l'eau et trouver l'équilibre uniquement lorsqu'il sera en contact avec le fond avec l'apparition de la force de réaction.


_Que se passe-t-il si je les plonge dans l'eau?_ (@fig:archimedes-cubes C)
Dans ce cas où les cubes sont tous immergés au milieu de l'eau, la poussée d'Archimède est la même pour tous comme leur volume ($V_"cube"=0.001$) est équivalent:
$
  arrow(P)_A = V_"cube" times rho_"eau" times g \
  arrow(P)_A = 0.001 times 1000 times 9.81 = #qty[9.81][N].
$
Selon le poids des cubes (seconde force externe au cube), ce dernier va avoir une accélération vers le haut (cube 1 et cube 2 qui remontent à la surface, car $arrow(W) < P_A$), pas d'accélération (cube 3 qui reste au milieu de l'eau, car $arrow(W) = P_A$) ou une accélération vers le fond (cube 4 qui revient en contact avec le fond pour que la force de réaction viennent le mettre en équilibre, car $arrow(W) > P_A$).

Comme lorsque l'on cherche à mettre une planche de natation sous l'eau et s'assoir dessus, celle-ci de très faible densité produit une poussée d'Archimède importante à vous propulser et revenir en équilibre à la surface de l'eau.

#figure(
  caption: [Quatre cubes de bois de même volume mais de masses volumiques différentes (A). Posés à la surface de l'eau, ils s'enfoncent jusqu'à ce que la poussée d'Archimède compense leur poids, sauf le dernier qui coule (B). Plongés dans l'eau, ils subissent tous la même poussée d'Archimède; selon leur poids, ils remontent, restent en place ou coulent (C).],
  scaled-include(path("media/cubes-archimede.typ"), width: 100%),
)<fig:archimedes-cubes>

Pour savoir si un corps flotte dans l'eau ceci revient à calculer sa #link("https://fr.wikipedia.org/wiki/Densit%C3%A9")[densité].
Contrairement à la masse volumique en kg/m#super[3], la densité est une valeur sans unité qui est le rapport de la masse volumique d'un corps à la masse volumique de l'eau (#qty[1000][kg / m^3]) pour les solides et les liquides et par rapport à l'air pour les gaz.
Si la densité est inférieure ou égale à 1 alors le corps flotte tandis qu'il coule si la densité est supérieure à $1$.


Pourquoi le corps humain flotte plus ou moins?

Il existe des facteurs intrinsèques au corps humain (#ie, la densité des tissus et également la respiration) et des facteurs extrinsèques (température et constitution de l'eau).
Voici un petit tableau qui récapitule la densité des tissus humains:

<_Toc82333064>Tableau XIII.2. _Exemple de densité des tissus humains_

#align(center)[#table(
    columns: 2,
    [Tissu], [Densité],
    [Graisse], [0,7 - 0,9],
    [Muscle], [0,9 - 1,1],
    [Os], [1,5 - 2,0],
    [Eau], [1,0],
  )
]

En regardant les densités, on peut déduire qu'un squelette coule et que la graisse flotte.
La densité globale du corps humain se situe en moyenne à $0.985$, par conséquent il flotte.
Bien entendu une personne avec plus de tissus adipeux flottera mieux qu'une personne maigre.

La respiration va modifier le volume du corps et surtout lors de l'inspiration la densité globale du corps va diminuer (de $0.985$ à $0.945$) comme la masse volumique de l'air est faible par rapport aux autres constituants.
De ce fait le corps flotte mieux.
Au contraire la densité montre à $1.025$ après une expiration forcée; de ce fait le corps aura tendance à couler.

#figure(
  caption: [Un corps plongé dans l'eau tourne jusqu'à ce que le poids et la poussée d'Archimède s'alignent verticalement pour obtenir l'équilibre des moments.],
  scaled-include(path("media/flottaison-rotation.typ"), width: 85%),
)

Le plus souvent, le corps humain flotte.
Toutefois le volume immergé peut être très proche du volume total ce qui permet pas une respiration facile.
Parfois seul un petit volume reste hors de l'eau ce qui oblige à mettre la tête en arrière pour avoir le nez hors de l'eau.
Selon la répartition des masses et des volumes, le corps va trouver une posture d'équilibre différente.
En effet le point d'application de poids (#ie, le centre de gravité) et celui de la poussée d'Archimède (#ie, centre géométrique du volume) peuvent ne pas être alignés.
Ceci entraîne par des moments de force qui font tourner le corps jusqu'à obtenir l'équilibre en rotation.
La position de l'étoile avec les jambes écartées et les bras dans le prolongement du corps a pour objectif de monter le centre de masse en direction de la tête et ainsi approcher le centre de masse et celui du volume pour que le corps puisse rester horizontal.

Les accessoires tels les bouées, gilets de sauvetage ou planche de natation sont constitués de matériaux avec une très faible masse volumique pour faciliter la flottaison.
Un bateau, bien que constitué de métal qui coulerait par plaque (#qty[7850][kg/m^3]), flotte car la coque de métal est un large volume rempli partiellement d'air qui finalement à une densité inférieure à $1$.

== Hydrodynamique
La résistance hydrodynamique présente des équations proches de la résistance aérodynamique où la vitesse relative dans le fluide est élevée au carré.
On distingue le plus souvent une résistance visqueuse $R_V$ ou trainée (somme de résistance de frottement et de forme) et une résistance de vagues $R_W$ si l'objet évolue proche de la surface de l'eau (#eg, un bateau ou un nageur).
C'est pour ça notamment que des lignes qui cassent les vagues séparent les concurrents en natation.
Ces deux résistances s'approchent par les équations suivantes:
$
  R_V & = 1/2 times rho_"eau" times C_V times S times v^2 \
  R_W & = 1/2 times rho_"eau" times C_W times sigma / L times v^2
$
avec $rho_"eau"$ représentant la masse volumique de l'eau, $S$ la surface de référence qui est en fait la surface mouillée#footnote[#link("https://www.guillemot-kayaks.com/guillemot/information/kayak_design/kayak_design_terms")[https://www.guillemot-kayaks.com/guillemot/information/kayak\_design/kayak\_design\_terms] pour des détails sur la terminologie.] et $C_V$ le coefficient de viscosité.
Pour la résistance de vague on fait intervenir le coefficient de vague $C_W$ et le rapport entre la section transversale maximale $sigma$ ou maître couple et la longueur à la flottaison $L$.

De ce fait, plus la surface mouillée est grande et plus la trainée sera importante ce qui explique pourquoi les bateaux rapides se soulèvent à grande vitesse pour limiter cette surface de contact.
Pour réduire la résistance de vague, il faut utiliser un bateau long.
Ces deux facteurs expliquent en grande partie la forme des coques des bateaux d'aviron et de kayak: très long (la longueur d'un K1 de course en ligne est #qty[5.20][m]) et très étroits pour avoir une faible surface mouillée, ce qui rend ces embarcations très instables mais rapides contrairement à une barque par exemple.

=== En natation?
Quelles sont les conséquences de ces résistances en natation?
Tout d'abord il faut avoir le corps allongé pour réduire au maximum le maître-couple et augmenter la longueur à la flottaison.
Les combinaisons en polyuréthane interdites dès 2010 ont permis d'améliorer les performances en offrant moins de viscosité que la peau et ainsi réduire la valeur du coefficient de viscosité dépendant à la fois de la forme et la nature de la surface en contact avec l'eau.

Outre ces forces de résistance, le nageur peut avancer en produisant des forces dans l'eau qui sont des résistances visqueuses dans son sens de déplacement.
Comme le corps se déplace vers l'avant par exemple à #qty[2][m / ss] la main par rapport au corps doit se déplacer d'une intensité supérieure vers l'arrière par exemple #qty[-4][m / s] pour pouvoir créer une force hydrodynamique.
Plus le nageur va vite, plus ses mouvements doivent être rapides pour compenser et ainsi la fréquence gestuelle augmente avec la performance.
Ensuite la main et l'avant-bras offrent un maître-couple important s'ils sont orientés face au déplacement.
C'est pourquoi le nageur va entrer sa main, poignet fléchi, dans l'eau pour créer une résistance.
Des mouvements en forme de spirale lors de la nage libre permettent de solliciter des masses d'eau qui sont moins en mouvement et avoir une plus grande vitesse relative.
Enfin de par sa forme profilée, la main peut créer des forces de portance à l'image de l'aile d'avion.
La natation est un geste très technique et en aucun moment le nageur "prend appui dans l'eau".
Sa main va plus ou moins avancer ou reculer selon la force propulsive qu'il produit!

=== Évolution des pales en kayak
La pale plate en canoë ou kayak produit une force propulsive uniquement lorsqu'elle se déplace d'avant en arrière dans l'eau.
Son déplacement vers l'extérieur ne crée pas de résistance comme il n'y a pas de surface.
En canoë cette forme est suffisante car le céiste peut produire de grande amplitude de mouvement en penchant son tronc sur son genou de la jambe avant puis en se redressant.
Par contre en kayak cette forme oblige une trajectoire très proche de la coque et le kayakiste qui tient sa pagaie à deux mains, se retrouve "coincé" dès lors que sa main dépasse sa hanche.
La pale est proche de la verticalité ce qui est efficace en terme de surface propulsive mais le kayakiste n'est pas capable de poursuivre son geste; la pale se retrouve sans vitesse et va créer plus de résistances que de force propulsive.
Le kayakiste doit alors sortir la pale de l'eau et enchainer sur le coup du côté opposé.

#figure(
  caption: [Kayak vu de dessus. La pale plate (à gauche) ne produit une force propulsive (sa traînée) qu'en reculant le long de la coque. La pale creuse (à droite) peut aussi s'écarter de la coque : sa traînée et sa portance se combinent en une force propulsive dirigée vers l'avant.],
  scaled-include(path("media/pales-kayak.typ"), width: 60%),
)

La pale creuse qui reprend le principe de l'aile d'avion est plus efficace en kayak.
La pale creuse permet de créer une force propulsive lors de ses déplacement vers l'arrière et vers l'extérieur.
Lors de déplacements latéraux, le flux d'eau en avant et en arrière de la pale n'ont pas la même vitesse ce qui crée une différence de pression propice à la création d'une force propulsive.
Le kayakiste peut alors poursuivre son geste en déplaçant la pale vers l'extérieur.
Les muscles rotateurs du tronc participent ainsi activement à la cinématique de la pale.
