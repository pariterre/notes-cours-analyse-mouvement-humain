#import "common/lib.typ": *

// `config` provient de common/config.typ (voir configs/default.toml)

#show: biomecaniqc-book.with(
  title: config.title,
  lang: "fr",
  show-page-numbering: true,
  authors: (
    Author("Mickaël Begon", affiliations: "Université de Montréal"),
    Author("Benjamin Michaud", affiliations: "Université de Sherbrooke"),
  ),
  date: datetime(year: 2026, month: 11, day: 3),
  watermark-text: config.watermark,
  chapter-on-same-page: config.chapter-on-same-page,
)

#todo[
  - Valider les informations dans tous les chapitres
  - Valider la correspondance entre les figures et le texte
  - Valider la cohérence des couleurs (doré => résultats, gris => neutre, autres couleurs pour les informations)
  - Valider les couleurs ne posent pas de problèmes pour les daltoniens
  - Corriger le français de façon générale
]

#outlines()

#for chapter in config.at("chapters-to-include", default: ()) {
  include path("chapters/" + chapter + "/main.typ")
}


#let annex-list = config.at("annexes-to-include", default: ())
#if annex-list.len() > 0 [
  #show: annexes
  #for chapter in annex-list {
    include path("chapters/" + chapter + "/main.typ")
  }
]
