#import "book-template/lib.typ": capitalize, generate-gender-mapping
#import "config.typ": config

#let ie = [_i.e._]
#let eg = [_e.g._]

#let Livre = [_Livre_]


#let Hertz = [_#link("https://fr.wikipedia.org/wiki/Hertz")[Hertz]_]
#let Joule = [_#link("https://fr.wikipedia.org/wiki/Joule")[Joule]_]
#let Newton = [_#link("https://fr.wikipedia.org/wiki/Newton_%28unit%C3%A9%29")[Newton]_]
#let Pascal = [_#link("https://fr.wikipedia.org/wiki/Pascal")[Pascal]_]
#let Watt = [_#link("https://fr.wikipedia.org/wiki/Watt")[Watt]_]

// Termes configurables, lus dans la section [terminology] de la
// configuration. Chaque entrée devient un dictionnaire de déclinaisons
// (voir `generate-gender-mapping` dans common/book-template/formatters.typ),
// accessible par son nom : `terms.moment-cinetique.le`, `terms.impulsion.Des`…
#let terms = (
  config
    .at("terminology", default: (:))
    .pairs()
    .map(((key, element)) => (key, generate-gender-mapping(element)))
    .to-dict()
)

// Raccourcis
#let moment-cinetique = terms.moment-cinetique
