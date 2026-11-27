#import "../../common/lib.typ": *
#import "media/configurations-musculaires.typ": muscle-icon


= Biomécanique musculaire
#learning-objectives((
  "La force musculaire dépend de la configuration des muscles",
  "La force musculaire dépend de l'étirement du muscle et sa vitesse de contraction",
))


== Introduction
L'analyse tridimensionnelle du mouvement humain à l'aide de systèmes d'analyse du mouvement et de plateformes de force permet de calculer la cinématique des articulations et les efforts articulaires.
Ensuite on peut remonter aux puissances articulaires et à la dépense énergétique.
Lors de l'analyse de la dépense énergétique, le théorème de l'énergie cinétique a permis d'estimer le travail des forces internes, c'est-à-dire le travail des muscles par leur contraction qui génère de la force et du déplacement de son point d'application.
Une autre approche pour estimer la dépense énergétique mécanique a été d'intégrer au cours du temps des puissances articulaires (produit scalaire de la vitesse articulaire par le moment à l'articulation).
Juste en restant sur ce niveau déjà complexe à interpréter on peut dire si une articulation travaille en concentrique ou excentrique, établir des patrons moteurs généraux et en dégager de nombreuses applications tant sur les plans cliniques, ergonomiques que sportives.

Par une modélisation plus fine, on peut tenir compte des muscles, leur action, sollicitation, contributions dans la performance.
La modélisation musculaire à l'interaction de l'anatomie fonctionnelle, la biomécanique et la physiologie musculaire apporte de nombreuses informations sur le fonctionnement des muscles et peut avoir des applications pédagogiques importantes.
Ce chapitre s'intéresse particulièrement à ces effecteurs du mouvement: les muscles.
En biomécanique, une analyse qui repose sur les activations musculaires est toujours plus complexe car on ne peut pas mesurer directement ces forces à l'aide de caméras vidéo et de plateformes de force.
La principale difficulté est que le système est redondant, c'est-a-dire qu'il y a plus de muscles qu'il n'en faut pour faire les mouvements.
Cette redondance rend le contrôle difficile, c'est par exemple ce que nous voyons lors de l'apprentissage de la marche ou de tous gestes sportifs.
Il y a une infinité de solutions pour parvenir au même mouvement ou à la même performance sportive et l'apprentissage va permettre de s'orienter vers telle ou telle solution.
Le biomécanicien a recourt à un modèle pour estimer les coordinations musculaires et arriver à une compréhension plus fine du mouvement et de sa coordination.

== Généralités sur les muscles
=== Rôle et fonction des muscles
Tous les muscles ne nous intéressent pas dans l'analyse du mouvement.
Le système musculaire se divise en trois catégories: le muscle cardiaque, les muscles lisses qui contient la paroi de certains organes internes et les muscles squelettiques ceux reliés aux os pour permettre la mise en mouvement du squelette.
Le muscle cardiaque et les muscles squelettiques appelés également muscles de la vie de relation sont striés.
Toutefois le cœur est à contraction involontaire pour la survie de tous.
Les muscles squelettiques au nombre supérieur à 600 représentent entre $40$ et $45%$ de la masse corporelle.
Lors de la contraction musculaire le muscle va produire de la force qui va tendre à mettre des segments en rotation par rapport aux articulations selon ses origines et terminaisons.
En plus de cette production de force pour mettre en mouvement le squelette, les muscles servent aussi à protéger le squelette et certains organes internes.
La production de force n'entraîne pas nécessairement de déplacement, elle peut simplement être utile au maintien d'une posture (#eg, posture droite, assise ou acrobatique).
Lorsque ces forces augmentent ou se coordonnent pour engendrer une résultante non nulle alors le mouvement s'initie.

La production de force d'un muscle et son effet sur le système squelettique dépend de nombreux paramètres comme la configuration des muscles, les points d'insertion, le nombre de fibres en parallèle et en série ou encore son état (#ie, raccourcissement et vitesse de contraction) et son activation.
La contraction musculaire est en elle-même complexe et de nombreuses régulations viennent aider au maintien des postures (réflexe myotatique avec les fuseaux neuromusculaires), préserver le muscle des blessures (réflexe myotatique inverse avec les organes tendineux de Golgi) ou encore d'autres boucles pour limiter la contraction des antagonistes lors de la contraction des agonistes (réflexe d'inhibition réciproque).
Ces contrôles et autorégulation permettent tout autant le maintien de la posture (quasi-statique) que des mouvements plus dynamiques allant de la locomotion à des mouvements balistiques.

=== Configuration des muscles
On distingue plusieurs configurations de muscles qui confèrent des propriétés mécaniques différentes.
L'orientation des fibres dans le muscle modifie sa configuration et ses caractéristiques mécaniques.
Les fibres peuvent être parallèle à l'axe longitudinal du muscle ou être oblique selon un angle dit de pennation.

La force musculaire maximale dépend principalement du nombre de fibres en parallèle que l'on définit également comme la surface de section physiologique du muscle.
Cette surface s'obtient en coupant le muscle perpendiculairement à l'orientation de ses fibres.
La vitesse de contraction maximale tout comme l'amplitude de raccourcissement dépend quant a elle du nombre de fibres musculaires placées en série, c'est-a-dire selon la direction de contraction du muscle.
Lorsque les fibres sont organisées longitudinalement par rapport à l'axe longitudinal du muscle, il y a beaucoup de fibres en série et peu en parallèles.
Ce muscle peut donc se raccourcir sur une large amplitude mais il ne produira pas beaucoup de force.
Au contraire les muscles pennés ou bipennés peuvent produire plus de force mais ont une amplitude de raccourcissement plus faible.

#figure(
  scaled-include(path("media/configuration-fibres.typ"), width: 50%),
  caption: [L'orientation des fibres musculaires (muscle fusiforme versus penné) entraine plus ou moins de déplacement et de force lors de la contraction.],
)

Pour un volume égale, un muscle penniforme peut produire une force plus grande mais son amplitude de raccourcissement sera plus faible comparativement à un muscle fusiforme.

#figure(caption: [Exemples de configurations musculaires.], align(
  center,
)[#table(
    columns: 3,
    align: horizon,

    [Configuration], [Représentation], [Exemples],
    [Parallèle], muscle-icon("parallele"), [Sartorius, rhomboïdes, grand rond],
    [Fusiforme], muscle-icon("fusiforme"), [Biceps, brachial antérieur],
    [Circulaire], muscle-icon("circulaire"), [Oculaire],

    [Penniforme ou\ semi-penniforme],
    muscle-icon("penniforme"),
    [Semi-membraneux, psoas-iliaque,\ gastrocnémiens],

    [Bi-penniforme], muscle-icon("bipenniforme"), [Deltoïde, grand fessier],
    [En éventail],
    muscle-icon("eventail"),
    [Grand pectoral, moyen et\ petit fessiers],
  )
])

=== Production de force
Entrons de façon succincte dans la structure du muscle.
Le muscle est tout d'abord un complexe formé du corps musculaire et de tendons pour s'attacher aux os.
Un muscle peut avoir plusieurs origines et terminaisons sur différents os et croiser une (muscle mono-articulaire) ou plusieurs articulations (muscle bi-articulaire ou poly-articulaire).

#figure(
  scaled-include(path("media/muscle-mono-bi-articulaire.typ"), width: 70%),
  caption: [Muscle mono-articulaire (soléaire) et bi-articulaire (gastrocnémien) : corps musculaire, tendons et articulations croisées.],
)

Le muscle est principalement composé de cellules musculaires elles-mêmes constituées de myofibrilles.
Ces cellules sont organisées et maintenues par de nombreuses structures du macroscopique ou microscopique.
L'épimysium entoure le muscle, on trouve ensuite des paquets de fibres (fascicules ou faisceaux musculaires) qui sont maintenues ensemble par un autre tissu conjonctif appelé périmysium.
Les fibres musculaires sont entourées individuellement d'un endomysium.
Au niveau de la myofibrille, les myofilaments d'actine et de myosine sont organisées dans des sarcomères.
C'est le glissement des myofilaments les uns sur les autres qui permet le raccourcissement du muscle dans sa globalité.
Les éléments élémentaires ne changent pas de taille, ils se chevauchent plus ou moins.
Les myofilaments épais sont appelés myosine.
Ils sont entourés de plusieurs filaments fins d'actine.
Les têtes des filaments de myosine viennent créer un pont avec l'actine lors de la contraction musculaire en présence d'énergie et d'un message d'activation.
Plus le nombre de ponts actomyosine sera important et plus la force générée sera grande.
#figure(
  scaled-include(path("media/sarcomere-actine-myosine.typ"), width: 90%),
  caption: [Sarcomère relâché et contracté : les filaments d'actine glissent le long des filaments de myosine grâce aux ponts actomyosine. Les filaments ne changent pas de longueur, seul leur chevauchement augmente.],
)

== Modèles musculaires
=== Évolution des modèles
Avec les années, les modèles musculaires se sont améliorés pour devenir de plus en plus physiologiques.
Le premier modèle ($["A"]$ Weber, 1846) simplifie le muscle à un simple ressort.
Ce ressort sera amortit pour tenir compte qu'il y a des pertes d'énergie lors des mouvements ($["B"]$ Hill, 1922).
Un nouvel élément élastique intervient quelques années après en série du ressort amortit qui correspond aux propriétés élastique du tendon.
En 1938, Hill $["D"]$ introduit un élément important de la contraction musculaire: l'élément contractile.
Ce dernier peut créer de la force sans être préalablement étiré.
D'expériences en expériences sur la fibre isolée, Hill propose un nouveau modèle composé d'un élément contractile avec en série un élément élastique et en parallèle de ceux-ci, un autre élément élastique.
On commence progressivement à dissocier les composants du muscles (tendons, fascia, myofilaments, etc.).


#figure(
  scaled-include(path("media/modeles-musculaires.typ"), width: 80%),
  caption: [Exemple de modèles musculaires.],
)

=== Relation force-longueur
Le muscle produit une force maximale en fonction de son état, c'est-à-dire son étirement (longueur par rapport à la longueur de repos) et de sa vitesse de raccourcissement.
On parle alors des relations force-longueur ($f_l$) et force-vitesse ($f_v$).

La relation force longueur qui a une grossièrement forme de U inversé s'explique par le nombre de ponts actomyosine au moment de la contraction.
Si le muscle est trop étiré, peu de tête de myosine peuvent être en contact avec les filaments d'actine.
Lorsque le muscle se rapproche de la longueur optimale --- longueur pour laquelle le muscle produit le plus de force --- alors le nombre de ponts augmente et la force générée devient plus importante.
Alors que le muscle se raccourcit de plus en plus, la force musculaire décroit à nouveau car le recouvrement des myofibrilles devient trop important.
Cette relation force-longueur explique pourquoi dans certaines positions on est plus faible.

#figure(
  scaled-include(path("media/relation-force-longueur.typ"), width: 100%),
  caption: [Relation force-longueur active d'un sarcomère. La force dépend du nombre de ponts actomyosine possibles : elle augmente jusqu'à la longueur optimale, y reste maximale, puis diminue lorsque le sarcomère est étiré.],
)

#interesting-note[
  Prenons un exemple simple des fléchisseurs plantaires lors d'une flexion plantaire alors que la tête de métatarse est largement surélevée par rapport au talon.
  Les muscles seront plus fort au milieu du mouvement plutôt qu'on début lorsqu'ils sont très étirés ou à la fin du mouvement proche de la flexion maximale.
]

A cette composante active de la force, produite par les fibres musculaires, il y a aussi une composante passive qui provient de l'étirement des tissus conjonctifs entourant les fibres (épimysium, périmysium et endomysium) et certaines protéines élastiques des myofilaments comme la titine.
Cette relation est de forme exponentielle, alors que le muscle est raccourcit, la force due à la raideur des tissus conjonctifs est quasi nulle.
Avec l'allongement du muscle et par conséquents des tissus non contractiles, la résistance augmente.


#figure(
  scaled-include(path("media/force-longueur-actif-passif.typ"), width: 100%),
  caption: [Relations force-longueur.],
)

On connait cette sensation lors des étirements passifs des ischio-jambiers par exemple.
Nous avons une grande amplitude de mouvement pour arriver à une sensation de "tiraillement" dû à l'étirement des tissus conjonctifs, il reste que quelques degrés de flexion de la cuisse par rapport au bassin avant d'atteindre son amplitude maximale et sentir une très forte tension dans le muscle.
L'amplitude articulaire n'est pas toujours limitée par les tissus conjonctifs des muscles (#eg, flexion de la hanche, flexion plantaire, extension de l'épaule) mais peut provenir de contact os--os (#eg, extension du coude ou du poignet) ou des structures tendineuses (#eg, abduction/adduction du genou).

Lorsqu'on s'intéresse au muscle, non plus isolé mais, dans une condition anatomique réelle avec comme objectif de mettre en rotation les segments corporels, la compréhension devient plus complexe car il faut prendre en compte les insertions des muscles pour déterminer leurs leviers qui peuvent être plus ou moins avantageux.
Prenons l'exemple des tractions ou _chin-up_: la phase la plus difficile est de passer des coudes tendus à une légère flexion.
Ce phénomène est dû principalement au très faible bras de levier des fléchisseurs du coude (#ie, biceps brachial et brachial) pour mettre en rotation l'avant-bras.
Une force très importante doit être générée pour créer un moment suffisant.
C'est pourquoi les sportifs n'étendent pas totalement les coudes entre chaque répétition.

#figure(
  scaled-include(path("media/traction-bras-levier.typ"), width: 90%),
  caption: [Bras de levier du biceps brachial lors d'une traction : très faible coudes tendus, plus grand coudes fléchis.],
)

Pour déterminer la relation force-longueur d'un muscle isolé on procède en plusieurs étapes qui peuvent se résumer se la façon suivante: le muscle est attaché d'un côté sur une partie fixe munie d'un capteur de force.
L'autre extrémité est attachée sur une partie mobile qui va permettre de changer sa longueur.
Progressivement le muscle est étiré passivement pour obtenir à chaque position une force.
On peut alors déterminer la composante passive de la relation force-longueur.
Ensuite on répète l'opération en excitant le muscle par une stimulation électrique.
On obtient alors la somme de la composante active et de la composante passive précédemment mesurée.
Il est enfin possible par soustraction d'obtenir la force produite par les éléments contractiles du muscle.

=== Relation force-vitesse
Au niveau de la relation-force vitesse, le muscle n'est pas non plus capable de produire une force égale quelle que soit sa vitesse de raccourcissement (pour une contraction concentrique) ou d'allongement (lors d'une contraction excentrique).

La relation force-vitesse décrit deux hyperboles si la vitesse est positive (#ie, contraction concentrique) et négative (#ie, contraction excentrique)


#figure(
  scaled-include(path("media/relation-force-vitesse.typ"), width: 70%),
  caption: [Relations force-vitesse.],
)

La référence est la force maximale isométrique.
Lorsque le muscle produit de la force est se raccourcissant, la force maximale diminue progressivement jusqu'à tendre vers $0$.
A la vitesse maximale de contraction le muscle ne produit pratiquement plus de force.
En excentrique la force maximale est plus important que la force isométrique; elle peut atteindre $1.5$ fois la force maximale isométrique.
On sait par expérience que l'on produit plus de force en retenant une charge qu'en cherchant à la déplacer (#eg, développé-couché ou squat).
Avec la vitesse d'étirement du muscle, la force maximale augmente progressivement pour tendre vers une valeur maximale.
