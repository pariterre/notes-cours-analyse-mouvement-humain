#import "../../common/lib.typ": *



= De l'analyse biomécanique aux situations pédagogiques
== Il faut analyser le mouvement et ses causes (dynamique)
L'image et le mouvement sont ce que voit l'enseignant d'éducation physique; il ne peut pas mesurer les forces, les couples articulaires ou autres paramètres mécaniques.
De ce fait, la performance est comparée par rapport à une représentation d'un mouvement désiré ou encore la performance est évaluée en rapport à des objectifs appelés parfois critère de réussite.
Il est alors tentant de rester sur ce versant cinématique et donner en guise de corrections ce que le mouvement devrait être, processus simple mais pas toujours pertinent.
Chaque phase du mouvement découle à la fois des actions faites durant celle-ci et de ce qui s'est passé dans la phase précédente.
Elle devient alors plus intéressant et efficace de s'intéresser au "comment il faut faire" plutôt que "ce que doit être le résultat".

Le tableau ci-dessous donne deux exemples simples.

#figure(caption: [Agir sur les causes plutôt que le résultat.], align(
  center,
)[#table(
    columns: 4,
    align: horizon,
    [Problème rencontré],
    [Correction\ cinématique],
    [Causes possibles\ du problème],
    [Correction\ de la cause],

    [Faible performance\ en saut en hauteur],
    ["Saute plus haut"],
    table.cell(align(left, [
      #set par(justify: false)
      - Impulsion faible
      - Mauvaise technique de franchissement
    ])),
    ["Abaisse ton corps \lors de la phase d'appel"],

    [Salto avant avec chute\ sur les fesses],
    [
      "Tourne plus vite" ou\
      "Ouvre plus tard"
    ],
    table.cell(align(left, [
      #set par(justify: false)
      - Moment cinétique trop faible
      - Manque de repères spatio-temporels
    ])),

    ["Court plus vite"],
  )
])

Lors de l'apprentissage du salto avant avec des jeunes élèves, la plupart d'entre eux tombent sur les fesses ou le dos lors de la réception.
La cause première est le manque de moment cinétique pour compléter la rotation puis avoir le temps de préparer la réception.
Une façon rapide d'augmenter le moment cinétique est de courir plus vite pour que le moment de la quantité de mouvement des segments distaux soit supérieur.
Une autre raison est l'absence de repère visuel lors de la réception qui oblige à faire de nombreuses répétitions pour se réceptionner sur les pieds.

#video-figure(
  caption: [Exemple d'un saut de main réalisé par un débutant et par un expert],
)[
  #todo["https://www.youtube.com/watch?v=xQ-X83Z3fwA"]
  #todo["https://www.youtube.com/watch?v=MSXhnkZNexk"]
]

== Le mouvement se conserve en l'absence de forces extérieures

Que ce soit pour la rotation ou la translation en phase aérienne, la quantité de mouvement horizontal et quantité de rotation se conservent car aucune force ou moment de force ne cause d'accélérations ou décélérations.
Pour la translation il faut alors prévoir les zones de réception en fonction des conditions d'éjection.
Par exemple en escalade (bloc), il faut penser que les élèves peuvent se repousser des murs et tomber après 2-3 mètres de chute plus éloignés encore.
Dans les activités acrobatiques il faut également anticiper les erreurs que les élèves peuvent réaliser (#eg, lâcher la barre fixe lors d'un balancé avant, saut très long en mini-trampoline) et mettre la quantité de tapis en conséquence.
La conservation des rotations a son importance dans les consignes.
Comme seul le moment cinétique peut être créé lors d'une phase de contact, l'enseignant doit focaliser sa consigne sur les actions à faire pour créer la rotation.

== L'accélération dépend de la force et la masse
Comme vu par le principe fondamental de la dynamique, l'accélération est proportionnelle aux forces appliquées à l'objet et inversement propositionnelle à sa masse.
Les applications directes sont qu'il faut donner des projectiles (#eg, boulet pour le lancer de poids, disque) en rapport avec la force des élèves pour qu'ils développent des coordinations motrices et atteignent une performance selon le même ordre de mesure que des adultes entraînés.
D'une façon plus générale, il est important d'adapter les sports pour qu'ils correspondent aux caractéristiques des élèves plutôt qu'à une prestation très médiocre dans un environnement normalisé qui correspond à la pratique d'athlètes élites.

Ce principe est aussi à prendre en compte lorsque l'on donne des consignes sur la vitesse ou l'accélération recherchée dans un mouvement.
Des mouvements de va-et-vient (#eg, musculation, pelleter la neige, etc.) peuvent être très contraignants pour les articulations et la musculature si on recherche une cadence élevée qui implique de fortes accélérations et par conséquent des forces musculaires important même pour une faible charge.
Dans le cas de la neige ou autre mouvements sportifs qui sollicite de déplacer son corps, la masse notamment celle du tronc n'est pas à négliger.

== L'accélération a la même direction que la force externe
Tout d'abord il est important d'observer la direction des mouvements des élèves: dans quelle direction sont lancés les bras, la jambe libre lors d'un saut, de la course?
Des actions dans une mauvaise direction ne sont pas efficaces et peuvent entraîner des contraintes sur les articulations pour récupérer l'instabilité due à ces mouvements parasites.
Le second aspect concerne les consignes qui sont données aux élèves.
Il faut au possible donner des informations sur la direction des actions.
Comme les accélérations segmentaires et les forces de contacts sont liées, il est souvent préférable de donner des consignes imagées ou non sur le geste et l'accélération recherche plutôt que des consignes basées sur les efforts.
Prenons l'exemple d'un départ de sprint: la consigne "lancer fort ton bras gauche et accélère ton tronc vers l'avant" devrait mieux marcher que "pousse fort dans tes jambes".
Il faut prendre ce principe avec sa réciproque: la force externe a la même direction que l'accélération.

== La trajectoire parabolique dépend de l'état au décollage
La cinématique linéaire en chute libre est simple: la vitesse horizontale du centre de masse est conservée alors que sa vitesse verticale diminue en rapport avec l'accélération gravitaire.
Si l'on décolle avec une vitesse dirigée vers le haut (positive), la vitesse va décroitre jusqu'à devenir nulle (sommet de la trajectoire) puis va devenir de plus en plus négative alors que le sujet est en phase descendante.
L'état (position et vitesse du centre de masse) au moment du décollage est très important.
De cet état va directement dépendre le point le haut, le temps en phase aérienne, et la distance parcourue par exemple.

L'enseignant doit orienter ses consignes et ses observations sur l'instant du décollage: quelles sont la position et la vitesse du corps à cet instant?
La vitesse de course est-elle suffisante, le corps décolle-t-il en position d'extension, les segments libres vont-ils dans la direction de la performance?

Il est également possible à partir de la trajectoire en phase aérienne de déterminer les erreurs commises lors de la phase d'impulsion.
En saut en longueur, si la trajectoire est trop "plate", l'élève n'a pas produit assez d'accélération vers le haut, il faut alors donner des consignes pour lancer les bras et le genou de la jambe libre vers le haut.
Il sera également intéressant d'observer la phase de pré-appel pour voir si l'élève abaisse légèrement son centre de masse pour avoir plus de temps lors de l'appel pour produire cette force verticale.
A l'éducateur ensuite de proposer des situations pédagogiques pour aider l'élève à changer le rythme de ses appuis lors du pré-appel / appel.

== La vitesse linéaire est tangente à la trajectoire
Le sens commun n'est souvent pas le meilleur pour prédire quand lâcher un objet en rotation.
La vision et les sensations que l'on a lors d'un mouvement de rotation (#eg, au lancer de disque) fournissent de mauvaises informations car le mouvement est trop rapide pour véritablement savoir quel était l'instant du lâcher alors que le corps continue de tourner.
De plus, le corps ressent davantage les forces associées aux accélérations et non pas à la vitesse qui va déterminer la trajectoire de l'objet.
Et cette force provient de l'accélération centripète dans un mouvement de rotation.
On pourrait trouver d'autres exemples dans les sports acrobatiques lors de mouvements de rotation (#eg, sortie salto arrière en barre asymétrique) pour lesquels il est important d'apprendre l'instant du lâcher en travaillant sur la sensation de vitesse du corps.

En prédisant que les élèves vont se baser sur des sensations et en sachant que la vitesse est tangente à la trajectoire, on peut proposer des exercices, des consignes et des organisations matérielles sécuritaires et plus performantes.

== La rotation crée une force centrifuge
Toujours dans les mouvements de rotation si on s'intéresse cette fois à l'accélération centrifuge on remarque qu'elle dépend du carré de la vitesse.
Quand ma vitesse double, l'accélération et par conséquent la force augmente d'un facteur 4.
D'un point de vue pédagogique, il est préférable de commencer certains gestes techniques à faible vitesse et augmenter progressivement pour prendre conscience que l'objet tend à fuir vers l'extérieur et de la force que l'on doit appliquer pour le retenir.
Les exemples les plus simples les lancers de marteau et de disque qui vont demander une modification de la posture et de la force de préhension alors que la vitesse de rotation augmente.
Dans les sports acrobatiques où le corps tourne sur lui-même (#eg, plongeon) se sont les segments qui tendent à s'éloigner du centre de rotation quand on cherche à réaliser des saltos groupés avec une grande vitesse de rotation.
Il est alors important d'apprendre à tenir son corps dans cette position groupé en accrochant les tibias avec les mains.

== La position du centre de masse dépend de la masse et position des segments
La difficulté de la biomécanique du corps humain est qu'il se déforme.
C'est un ensemble de solides liés par des articulations.
Son étude est alors complexe mais sa performance accrue.
Cette déformation va permettre de déplacer le centre de masse et, selon la vitesse et l'accélération des segments, générer du mouvement.
Tous les segments peuvent contribuer à la performance.
Lors d'un saut, un entre-deux au basket par exemple, le fait de ramener un bras contre le corps va abaisser le centre de masse ce qui va avoir comme conséquence d'atteindre plus haut avec la main qui est au-dessus de tête pour attraper le ballon.

D'autres exemples en athlétisme illustre parfaitement cette capacité à améliorer la performance en modifiant sa posture en phase aérienne.
C'est le cas de la technique du _fosbury flop_ pour franchir une barre plus haute sans modifier la trajectoire de sans centre de masse.
Le seul fait que le centre de masse peut passer plus proche de la barre sans qu'un segment ne la fasse tomber permet de gagner quelques centimètres.
Un autre exemple est le franchissement de haie où la position du corps au-dessus de la haie (buste fermé sur la jambe de franchissement et éviter de la seconde jambe par un mouvement de circumduction) permet de ne pas élever beaucoup le centre de masse par rapport à sa trajectoire en phase de course.
La course de haie est alors une course d'évitement plus que de franchissement où la technique est très importante pour ne pas perdre de temps sur les phases d'impulsion précédent le franchissement.

Quand on s'intéresse à la vitesse et à l'accélération, le principe est le même: tous les segments par leur masse et leur accélération contribuent à la vitesse ou l'accélération du corps.
Il faut donc apprendre à mobiliser tous les segments: lancer les bras et la jambe libre vers le haut lors d'un saut avec appel d'un pied, lancer ses bras vers l'avant lors d'un départ de sprint, utiliser de la même façon ses bras pour courir vite...

== En phase aérienne, le changement de posture modifie la vitesse de rotation
La quantité de rotation, produit du moment d'inertie par la vitesse de rotation, est constante en phase aérienne.
Il est alors possible de changer sa vitesse de rotation en jouant sur son moment d'inertie soit en s'étendant pour tourner plus doucement soit en groupant pour tourner plus vite.
Il sera important d'apprendre les différentes postures pour aider l'élève à réussir des périlleux et se réceptionner sur les pieds.

== La variation de vitesse dépend de l'impulsion des forces extérieures
Seules les forces peuvent modifier la vitesse du mouvement.
Quand on s'intéresse à la vitesse du centre de masse il faut faire intervenir la somme des forces extérieures.
Toutefois pour modifier la vitesse, les forces doivent être appliquées sur une période de temps la plus longue possible, ce qu'on appelle l'impulsion.
Une même impulsion peut être créée par une force intense sur une courte période ou une force plus faible sur une période plus longue tant que le produit de la force par la durée reste le même.
Le plus souvent lors des sauts, la durée d'impulsion dépend de la surface de contact (béton, tartan, trampoline, tremplin, herbe) car le corps doit être en phase avec les équipements pour permettre une échange optimal d'énergie.
Il est donc important d'apprendre à utiliser les équipements.
Pour les sauts il faut trouver le compromis entre vitesse horizontale et temps d'impulsion.
En effet si la vitesse est importante, le temps de contact est très réduit et il faut être capable de produire beaucoup de force verticale pour créer de la vitesse verticale sur un court laps de temps.
C'est pourquoi les débutant ne doivent pas courir à leur vitesse maximale pour du saut en longueur ou du saut de cheval, car ils n'auront pas le temps pour créer la vitesse verticale.
Il faudra également apprendre la technique de pré-appel / appel qui permet d'abaisser le centre de masse (#ie, avoir les jambes un peu plus fléchies que lors de la course normale) et placer le corps un peu plus en arrière pour ainsi augmenter l'amplitude articulaire pour générer l'impulsion.

== La vitesse de l'extrémité distale dépend de la vitesse de rotation de chacune des articulations
Le corps humain est une chaîne de segments.
On peut alors dire que la vitesse de la main dépend de la vitesse du pied par rapport au sol, de la cheville, du genou, de la hanche, du dos, de l'épaule, du coude et du poignet.
La vitesse de déplacement et la vitesse de chacune des articulations contribuent à la vitesse de la main.
Il faut pouvoir coordonner toutes ces articulations pour maximiser la vitesse d'éjection, par exemple au baseball ou au lancer du javelot.
Plus les articulations auront une grande amplitude de mouvement, plus la vitesse atteinte en bout de chaine pourra être importante.
Le plus souvent dans les mouvements à vitesse maximale, on rencontre un déphasage proximo-distal.
Pour un lancer, le bassin sera mis en rotation en premier, puis l'épaule, le coude et le poignet.
Cette séquence s'explique notamment par l'inertie des segments (plus on arrive en bout de chaine et plus il est facile d'accélérer les segments) et par les muscles bi-articulaires qui permettent de transférer de la puissance.
Ils ralentissent le segment proximal tout en accélérant le segment distal.

== Les segments distaux sont plus efficaces pour créer la quantité de rotation
Dans l'expression du moment cinétique de l'ensemble du corps on remarque que chaque segment contribue en fonction de son moment cinétique propre (produit de sa rotation sur lui-même et de son moment d'inertie) et du moment de sa quantité de mouvement.
Ce sont alors les segments les plus éloignés du centre de rotation qui peuvent produire beaucoup de moment cinétique.
Il faut alors apprendre aux élèves à utiliser ces segments en leur donnant une grande vitesse.

== La capacité d'une force à modifier un mouvement de rotation dépend de son intensité, sa direction et sa distance au centre de rotation
Les entités en rotation sont toujours plus complexes que celles en translation.
Concernant le moment de force qui a pour objectif de mettre un objet en rotation, plusieurs facteurs se combinent pour atteindre une bonne efficacité.
Il faut à la fois une force intense, un point d'appui éloigné et que la force soit le plus possible perpendiculaire au bras de levier.

En sport de combat, si l'on veut faire tomber quelqu'un par un mouvement de rotation, il faudra créer un point fixe (#eg, bloquer les jambes) le plus bas possible et appliquer une force le plus haut possible pour maximiser le moment de force en jouant sur le bras de levier.

Si on veut aider quelqu'un à tourner dans les activités acrobatiques, il faudra appliquer des forces au niveau des segments distaux.
Par contre, il est parfois difficile d'appliquer ces forces si le corps n'est pas maintenu (#eg, à la moindre petite force le genou ou le tronc se plie).
En phase aérienne, appliquer une force au niveau du centre de masse n'aura pas pour effet de faire tourner le corps.

== L'équilibre statique est obtenu quand la somme des forces et des moments est nulle
Si on fait appel à principe fondamental de la dynamique (seconde loi de Newton) et au théorème du moment cinétique (principe d'Euler) on peut dire qu'un système sans accélération et sans accélération angulaire, c'est-à-dire en équilibre statique, est caractérisé par une force résultante et un moment résultant nuls.
Pour être en équilibre sur le sol, il faut que son centre de masse se projette à l'intérieur du polygone de sustentation qui se définit comme la surface qui englobe tous les appuis.
Ce principe d'équilibre statique lorsqu'on est en contact avec le sol explique pourquoi l'enfant apprend à se mouvoir à quatre pattes et de nombreuses personnes âgées se déplacent à l'aide d'une canne pour augmenter la surface du polygone de sustentation et éviter de chuter.
Lorsque l'on met en place du matériel, il faut s'assurer qu'il est en équilibre et va le reste même si des forces sont appliquées dessus.

Dans l'eau ce principe d'équilibre avec un moment résultant nul est mis en en évidence lorsque le corps se met à tourner alors que le poids et la poussée d'Archimède sont de mêmes normes.
Tant que leurs points d'application ne sont pas alignés, le corps n'est pas en équilibre car il y a des moments.

Alors comment fait-on pour maintenir un "drapeau" comme les artistes de cirque?
En effet les points d'application du poids et des forces de contact font qu'il peut y avoir un moment résultant.
Le poids est une force dirigée vers le bas.
Il faut tout d'abord que la force appliquée par le poteau sur les mains soit vers le haut.
Ensuite il faut que la main du haut tire sur le mât et celle du bas pousse.
Ces deux forces crée un moment de force qui s'oppose au moment du poids et permet de conserver l'équilibre.
C'est pour ça que les artistes ont les bras écartés pour que les forces de contact produisent un plus grand moment de force.

#video-figure(caption: [Canadian flag.])[
  #todo[https://www.youtube.com/watch?v=JmHtLycyIvQ&feature=related]
]

== L'énergie dépend de la vitesse au carré, de la masse et de la hauteur
En faisant appel à l'énergie potentielle de pesanteur et l'énergie cinétique de translation, les paramètres qui ressortent sont la masse, la hauteur et la vitesse au carré.
Dans un souci de sécurité, il faut prévoir des zones de décélération suffisantes, mettre des tapis en conséquences des hauteurs de chutes ou vitesse d'impact et proposer des consignes pour éviter au maximum les collisions entre les joueurs surtout s'ils ne sont pas de même masse.
Il faut que les équipements de protection correspondent à la quantité d'énergie à dissiper.
Comme les équipements sont souvent constitués de plusieurs matériaux simples ou composites, il est important de les choisir et tester en fonction de la masse des participants et leur niveau de pratique.

== Pour dissiper l'énergie il faut un déplacement ou une déformation
L'énergie, qu'elle soit potentielle ou cinétique, doit être dissipées lors d'une chute, d'une réception ou d'un coup.
Certaines structures du corps sont plus à même de dissiper cette énergie.
Dans ce cadre, il est déconseillé de faire "travailler sa tête" car les forces appliquées au cerveau alors qu'il se déplace dans la boite crânienne peuvent mener à des commotions cérébrales.
Il faut alors utiliser des équipements de protection (sol sportif, tapis de réception, casques, gants) qui vont répartir les forces et amortir le choc.
C'est le matériau, par ses caractéristiques physicochimiques, qui va dissiper une partie de l'énergie en se déformant ou en produisant de la chaleur.
Une autre façon est de profiter que le corps est un système poylarticulé.
Au lieu de se réceptionner en restant rigide avec une grande force d'impact qui se réparti d'articulation en articulation où les ménisques ou disques intervertébraux vont absorber une partie de l'énergie du choc, il est possible de se déformer et d'effectuer une contraction excentrique au niveau des quadriceps et fessiers par exemple.
Il faut apprendre aux élèves à la fois l'importance des équipements de protection et tes techniques pour limiter des forces très importantes lors de chute qui pourraient être à court ou long terme préjudiciables pour l'organisme.

== La force maximale d'un muscle dépend de sa longueur, sa vitesse de contraction et du type de contraction
En plus du système de levier complexe qu'il existe entre les muscles et les os, les muscles ne sont pas des actionneurs (#eg, producteurs de force) simples.
Ils ne produisent pas la même force dans toutes les conditions et rarement celle que l'on voudrait.
Un muscle produit une force maximale à sa longueur optimale lorsque toutes les têtes de myosines forment un pont avec l'actine.
Dès qu'on s'éloigne de cette position, le muscle est moins performant.
Cette raison ainsi que le changement du bras de levier des muscles en fonction de l'angle que les machines de musculation ont parfois des cames plutôt que des poulies rondes.
La came avec son rayon variable s'adapte à la physiologie humaine pour que le muscle puisse développer sa force maximale quelle que soit l'angle articulaire.
Le muscle ne peut également pas produire sa force maximale dès qu'il y a une vitesse de mouvement.
En concentrique la force diminue en fonction de la vitesse de mouvement jusqu'à être quasi nulle quand la vitesse est trop grande.
Par contre, la force peut être plus élevée en excentrique (jusqu'à $130%$ de la force maximale isométrique).

D'un point de vue pédagogique, il faut éviter des mouvements qui demandent une grande force en excentrique et des angles de grande amplitude, surtout en période de croissance.
Ces mouvements, comme les sauts depuis un angle de genou très fermé, peuvent être éprouvant pour le système musculo-squelettique.
Sur un aspect musculation, il y a une spécificité de l'entrainement c'est-à—dire que l'on progresse principalement à l'angle et au type de régime (concentrique, isométrique ou excentrique) auxquels on travaille.

== Le frottement permet le déplacement
Dans un fluide ou en contact avec le sol, on peut changer son mouvement car il est possible d'appliquer des forces externes.
Sur le sol, c'est bien parce qu'il y a du frottement entre celui-ci et les pieds, qu'il est possible de créer des forces antéropostérieures et médio-latérales.
Plus le coefficient de frottement du sol est faible, plus il est difficile d'accélérer; comme dans le cas de la marche sur la glace.
Pour pallier à ce problème et permettre des changements rapides de direction, on utilise des crampons dans les sports collectifs sur gazon.
Selon le principe d'action-réaction lors que l'on veut pousser quelqu'un, il faut s'assurer de ne pas glisser car la différence se fera sur les forces de contact au sol, c'est-à-dire celui qui pourra produire le plus de force en poussant dans ses jambes.
Rappelons toutefois que pour la sûreté des appuis, il ne faut pas que le pied reste coincé au sol, sinon au augmente les chances de se blesser.
En athlétisme les coureurs et sauteurs ont des pointes sous leurs chaussures pour éviter tout glissement.
Il est sera de même pour les équipements de protection qui ne doivent pas glisser lors d'une chute qui produit une force horizontale importante.
Le coefficient de frottement de la surface au contact avec le sol doit être élevé.

Dans les activités aquatiques, la propulsion est permise par la résistance de l'eau sur la pale ou sur la main.
Une nouvelle fois c'est parce qu'il y a une force de frottement que le nageur ou le rameur peut avancer dans l'eau.

== Les résistances aéro- et hydro-dynamique dépendent de la vitesse relative du fluide au carré et des surfaces
Les résistances aérodynamiques et hydrodynamiques dépendent de paramètres sur lesquels il est difficile d'intervenir comme la masse volumique du fluide et d'autres sur lesquels on peut jouer en travaillant à la fois sur la posture et les équipements.
Pour réduire ces frottements, il faut réduire la surface vue par l'écoulement (#ie, maître-couple).
On adoptera alors une posture allongée pour nager, une posture dos arrondi et penché vers l'avant avec les coudes serrés en vélo.
Côté équipement dans tous les sports de vitesse il est préférable d'avoir des vêtements qui collent au corps (#eg, natation, patinage de vitesse, sprint, cyclisme).
Pour la haute performance, il est également possible de travailler sur la forme des équipements et les matériaux pour réduire la résistance de forme et de surface.
Le paramètre le plus important dans ces résistances visqueuses est la vitesse qui est au carré.
C'est toutefois la vitesse relative du fluide par rapport à l'objet.
C'est pourquoi dans un peloton nous sommes protégés du vent; la vitesse relative est alors plus faible et la résistance plus faible.
Autrement, on ne peut pas vraiment jouer sur cet aspect car bien souvent l'objectif est d'aller le plus vite possible.
Pour l'enseignant, il pourra être important de ne pas évaluer (#eg, course et lancer) les élèves lors de journées de grand vent où la résistance aérodynamique peut modifier la performance de façon significative.

Si on s'intéresse non plus aux résistances mais à la propulsion, les principes sont les mêmes.
Pour créer de la propulsion dans l'eau, il faut déplacer sa main ou sa palette avec une grande vitesse et avoir la plus grande surface d'appui possible.
Il faut alors en natation donner des consignes techniques pour que la main aille vite dans l'eau et travailler sur les trajectoires pour pouvoir prendre conscience des appuis sur l'avant-bras et la main.
En kayak ou aviron, il ne faut pas que la surface des pales prévale sur leur vitesse de déplacement.
Rappelons que la propulsion dépend de la vitesse relative.
Avec une pale trop grande, les jeunes ne peuvent pas produire une vitesse suffisante pour se propulser car il faut d'abord que cette vitesse vers l'arrière compense la vitesse de déplacement du bateau vers l'avant.

== Pour flotter dans l'eau il faut une densité inférieure à $1$
La poussée d'Archimède est verticale dirigée vers le haut et son intensité correspond au poids de volume déplacé.
Lorsque l'on développe une équation d'équilibre en translation entre le poids et la poussée d'Archimède on se rend compte que pour qu'un objet flotte il faut que sa masse volumique soit inférieure à celle du fluide.
Cela revient dans une piscine à avoir une densité inférieure à $1$.
Un bateau flotte car sa coque bien que très lourde déplace un gros volume et en moyenne la densité sera inférieure à $1$.
Le corps humain flotte plus ou moins bien en fonction de la répartition entre les muscles et le tissu adipeux.
En natation on peut aider la flottaison avec des planches ou des _pull-boy_ qui sont fait en mousse rigide et très légère.
Il est alors possible de travailler sur la technique de propulsion sans gérer la flottaison et l'équilibre.
En effet comme vu précédemment, le corps dans l'eau peut obtenir l'équilibre dans une posture verticale ce qui n'est pas le plus efficace pour nager.
Le _pull-boy_ notamment a pour objectif de redescendre le centre de flottaison pour être en position horizontal à l'équilibre.

Comme la masse volumique de l'eau augmente avec la salinité, il est souvent plus facile de flotter dans la mer et s'il n'y a pas de vagues parfois plus simple d'apprendre à nager.
