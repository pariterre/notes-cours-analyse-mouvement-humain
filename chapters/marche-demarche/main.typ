#import "../../common/lib.typ": *


= Marche et démarche
#learning-objectives((
  "Comprendre l'importance de la locomotion pour l'autonomie des personnes",
  "Connaitre les grandes caractéristiques du pas de marche",
  "Comment la marche évolue-t-elle avec l'âge?",
))

== Introduction
Cette motricité si banale fait l'objet d'une part très importante de la publication scientifique et de l'analyse clinique à travers le monde et les années.
Notre environnement est bâti sur le pré-requis de la marche pour se mouvoir.
Notre environnement standardisé laisse peu de place au personne à motricité réduite et un des objectif dans les cliniques de marches qui regroupent des biomécaniciens, des physiothérapeutes, des orthopédistes et bien d'autres professionnels du secteur de la santé voire de la robotique humanoïde est de redonner de l'autonomie aux personnes par la posture debout et la marche.
Le handicap des personnes à mobilité réduite provient de notre environnement: les lieux publics sont parfois accessibles mais les équipements ne sont pas à la bonne hauteur ou les espaces suffisants grands, etc.
Moins la locomotion sera assistée ou éloignée de la marche et plus la personne augmentera sont autonomie et par conséquent diminuera son handicap.
L'accidenté de la route avec le corps médical mettra tout en œuvre pour retrouver la marche en passant par des étapes de locomotion avec déambulateur pour répartir les forces de contact avec le sol entre les membres supérieurs et inférieurs.
Il en est de même pour les personnes âgées qui se meuvent en cannes ou déambulateur avant d'être parfois contraintes de se déplacer en fauteuil roulant ou ne plus se déplacer.
Le cas échéant, le handicap devient lourd avec une perte des contacts humains et une dépense énergétiques qui diminue largement comme la locomotion sollicite d'importantes masses musculaires des membres inférieurs.

#interesting-note[
  *Le saviez-vous?*

  On nomme handicap la limitation des possibilités d'interaction d'un individu causée par une déficience qui provoque une incapacité, permanente ou présumée définitive et qui elle-même mène à un handicap moral, intellectuel, social ou (et) physique.
]

La marche est à la fois naturel et un défi.
En robotique humanoïde, outre la symbolique divine de créer des machines au plus proche de l'humain, une des motivations est la conception d'exosquelettes ou orthèses motorisés pour apporter davantage d'autonomie.
Les robots bipèdes sont encore loin des performances humaines tant en termes d'autonomie que d'endurance ou de vitesse.
La course des meilleurs robots si extraordinaire qu'elle soit pour le roboticien fait encore rire le moindre athlète.
Les genoux ne sont pas en extensions complètes et la démarche reste sur une dynamique statique afin d'assurer un certain équilibre à tout instant si l'imprévu arrive.
S'il est possible de marcher, tourner la tête, récupérer un objet lourd puis monter sur le trottoir, etc. (#ie, faire une succession de tâches simples lors de la locomotion), ces mouvements ont demandé de nombreuses heures d'apprentissage et nécessitent toujours de forces anticipations.

La phase d'apprentissage de la marche est longue et l'évolution du patron de marche se poursuit tout au long de la croissance.
La démarche va évoluer par la suite lors de prise de poids (#eg, femmes enceintes, lorsque l'on porte un sac à dos ou pour cause d'obésité) puis avec la perte des capacités physiques, acuité visuelle ou autres pathologies qui peuvent augmenter le risque de chute par un contrôle altéré de la motricité.
Le bébé ne nait pas avec la compétence de marcher.
Il faut pouvoir coordonner l'ensemble des muscles des membres inférieurs et en moindre mesure du reste du corps et mettre en place des stratégies d'évitement de chute.
La variété des situations motrices de marche (#eg, changement de direction, de hauteur, évitement d'obstacle, changement de vitesse) et en association avec la locomotion (#eg, prises d'informations visuelles, déplacement d'objet, pointage) va permettre de créer des anticipations motrices et de déterminer une gamme des possibles.

Enfin la marche est une expression sociale, une signature motrice.
En voyant quelqu'un de dos ou au loin marcher, il est possible de le reconnaitre avec une forte probabilité.
Il n'est pas toujours possible d'expliquer les caractéristiques propres à la démarche d'une personne mais cet ensemble de paramètres peuvent être très personnel.
De même il est possible d'avoir une idée sur l'état de fatigue, l'humeur, etc. de la personne en observant sa démarche.

La marche est une motricité complexe qu'il faut apprendre, parfois réapprendre ou adapter qui est stylisée et qu'il est important d'acquérir puis conserver car elle va de pair avec l'exploration de l'environnement pour l'enfant et avec l'autonomie de l'adulte.

== Paramètres spatio-temporels de la marche
La marche est une progression du corps vers l'avant.
Les articulations par des mouvements combinés de rotations permettent cette translation vers l'avant faite de pas alternés.
Un cycle de marche se compose de deux pas successifs, le pas droit et le pas gauche par exemple.
Chaque jambe a alors un rôle de support puis d'oscillation.
A la différence de la course, la marche se caractérise par une phase de double appui, le pied droit et le pied gauche sont en contact avec le sol sur une courte période avant qu'une jambe commence son oscillation.
La phase d'appui dure en moyenne $60%$ du temps ($20%$ pour le double appui et $40%$ pour le simple appui) contre $40%$ pour la phase d'oscillation.
Les membres inférieurs ont donc comme rôle de supporter le corps et le propulser vers l'avant.
On peut distinguer neuf phases dans le déroulement du cycle de marche:
#{
  set enum(indent: 2em)
  [
    + le contact du talon
    + l'appui bipodal
    + l'appui unipodal
    + la poussée
    + le décollement du talon
    + le décollement des orteils
    + l'envol
    + l'oscillation
    + la préparation à l'attaque du talon
  ]
}
A chacune des phases correspond un comportement normal et selon l'écart à cette norme, il est possible de diagnostiquer des comportements pathologiques.
La détection de ces évènements se fait à partir des mesures des forces, de la cinématique ou simplement visuellement.

A partir de la cinématique de la marche, de nombreux paramètres spatio-temporels sont calculés.
La cadence, tout d'abord, se définit comme le nombre de pas par minute.
Il est possible de mesurer la longueur de chaque pas et ainsi calculer la vitesse de déplacement comme étant le produit de la cadence par la longueur de pas, le tout divisé par $60$ pour avoir une vitesse en #unit[m/s].
La largeur du pas est aussi un indice de maturité et de stabilité.
D'autres paramètres tels que le pourcentage des périodes de double et simple appuis ou la hauteur de franchissement (#ie, la distance entre le sol et l'orteil) sont couramment analysés.
Ces paramètres varient avec la morphologie des individus et avec la croissance.
A partir de données normatives il est possible d'estimer le degré de développement d'un enfant par exemple.

== Évolution de la marche avec la croissance
La longueur des pas augmente tout au long de la croissance; elle passe de $15-#qty[20][cm]$ pour un bébé qui commence à marcher à plus de #qty[60][cm] à l'âge adulte.
Ce facteur s'explique principalement par la longueur des membres inférieurs.
La cadence quant à elle diminue notamment entre la première et la troisième année pour passer de #qty[180][pas/min] à $150$.
A l'âge adulte elle se stabilisera vers $110-#qty[120][pas / min]$.
Il en résulte que la vitesse marche augment presque linéairement avec l'âge pour tripler entre l'enfance et l'âge adulte ($0.4$ à #qty[1.2][m / s]).
Comparativement à l'adulte et en rapport avec ses dimensions, l'enfant ne marche pas lentement.
Il compense sa faible longueur de pas par une cadence élevée afin de pouvoir "suivre" l'adulte.

Le pourcentage de temps passé en simple appui augmente avec la croissance et la maturité de la marche.
L'enfant reste environ $32%$ de son temps en simple appui alors que l'adulte approche les $40%$.
La stratégie de l'enfant de passer plus de temps en double appui est lié à la stabilité, tout comme sa largeur de pas.
En effet si l'on exprime le ratio de la largeur du bassin par rapport l'écartement des talons, on remarque que l'enfant diminue sa largeur de pas durant les premières années.
Au début ses pas sont aussi larges que son bassin pour, avec les années, se rapprocher et être deux fois à deux fois et demi moins large que le bassin.
Le rapprochement des pieds de l'axe médian montre une meilleure stabilité.

== Dynamique de la marche
Afin de tenir compte des différences de morphologie, les forces sont le plus souvent exprimées en Newton divisés par kilogrammes $[#unit[N / kg]]$.
La force est en fait divisée par la masse corporelle de chaque individu pour pouvoir les comparer.
Le profil de force antéropostérieure lors d'une marche à vitesse constante est représenté à la @fig:gait-curves A.
On observe tout d'abord une aire négative qui correspond à une phase de ralentissement lors de l'attaque du talon jusqu'à la prise d'appui.
La seconde aire, positive, est la phase de poussée; le sujet récupère la vitesse perdue.
Comme la variation de vitesse est globalement nulle lors d'un cycle, la somme des impulsions est égale à zéro.

#figure(
  caption: [Au cours d'un cycle de marche (d'une attaque du talon à la suivante) : force de réaction antéropostérieure (A), force de réaction verticale (B) et angle de flexion du genou (C). Les forces ne s'exercent que pendant l'appui. Courbes typiques d'un adulte, exprimées par kilogramme de masse corporelle.],
  scaled-include(path("media/cycle-marche-courbes.typ"), width: 85%),
)<fig:gait-curves>

La force verticale décrit quant à elle deux pics consécutifs (@fig:gait-curves B).
Le premier pic correspond à la mise en charge: après l'attaque du talon, le poids du corps est transféré sur la jambe d'appui et le centre de masse, qui descendait, est freiné puis renvoyé vers le haut.
Le second pic correspond à la poussée: les fléchisseurs plantaires de la cheville propulsent le corps vers le haut et vers l'avant avant que le pied ne quitte le sol.
Entre les deux, la force descend sous le poids alors que le centre de masse passe au-dessus du pied d'appui et commence à redescendre.

On remarque que l'angle du genou varie tout au long du cycle de marche (@fig:gait-curves C).
Alors que le genou est tendu lors de l'attaque du talon, on remarque une première flexion lors de la prise de support suivie d'une extension durant la phase de poussée.
Par la suite une flexion importante se produit lors de l'oscillation pour que le pied puisse éviter le sol tout en conservant le bassin horizontal.

En analysant les moments articulaires on peut rentrer davantage dans les mécanismes de la marche.
Par exemple, la cheville qui suit également des mouvements de flexion et d'extensions lors du cycle de marche a une activité musculaire quasi exclusivement de flexion plantaire.
Comme cette action de flexion plantaire se produit à la fois lors de mouvement de flexion dorsal et plantaire, on peut analyser si l'activité musculaire est concentrique ou excentrique.

Quand la vitesse de marche augmente, la phase de double appui se réduit de plus en plus jusqu'à devenir inexistante.
A cet instant, on court.
La course se caractérise par une succession de simples appuis ($20-30%$ du temps d'un cycle) et de phases aériennes ($70-80%$).
Le simple appui se divise entre une phase de réception suivie d'une phase de poussée puis vient l'oscillation.
