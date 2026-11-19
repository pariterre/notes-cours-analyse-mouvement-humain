#import "@preview/citesugar:0.1.0": citesugar
#import "@preview/fancy-units:0.1.1": fancy-units-configure, num, qty, unit
#import "formatters.typ": authors-header, long-date-display

#let _title = title
#let _annexe-supplement = [Annexe]
#let _gray = luma(240)
#let table-header-color = _gray

// Figure kinds whose numbering restarts at each chapter (see `_chapter-figures`)
#let _figure-kinds = (image, table, raw, "video")


/// Numbers figures relative to their chapter (e.g. 2.1, 2.2, … or A.1 in
/// appendices) and restarts their counters at every level-1 heading.
/// - style (str): Numbering pattern, the first level being the chapter.
/// - body (content): The content to apply the numbering to.
/// -> content
#let _chapter-figures(style, body) = {
  set figure(numbering: n => std.numbering(
    style,
    counter(heading).get().first(),
    n,
  ))
  show heading.where(level: 1): it => {
    for kind in _figure-kinds { counter(figure.where(kind: kind)).update(0) }
    it
  }
  body
}



/// Defines the main report structure for BiomécaniQc book.
///
/// = Example
/// ```typst
/// #show: body => biomecaniqc-book(
///   title: "Example Book",
///   lang: "fr",
///   show-page-numbering: true,
///   body,
/// )
///
/// YOUR TEXT HERE
/// ```
///
/// - title (content | none): The title of the report.
/// - authors (content | none): The authors of the report.
/// - date (content | none): The date of the report.
/// - watermark-text (str | none): The text to display as a watermark. Empty text or "none" will result in no water-mark displayed
/// - chapter-on-same-page (bool): Whether to put the chapter header on a dedicated page or same page as the reste of the text.
/// - numbering (str | none): The heading numbering style.
/// - show-page-numbering (bool): Whether to display page numbers.
/// - first-page-to-number (int): The first page to start numbering from.
/// - lang (str): The language of the report.
/// - justify (bool): Whether to justify the text.
/// - body (content): The full content of the report.
/// -> content
#let biomecaniqc-book(
  title: none,
  authors: none,
  date: none,
  watermark-text: none,
  chapter-on-same-page: true,
  numbering: "1.1",
  show-page-numbering: true,
  first-page-to-number: 1,
  lang: "fr",
  justify: true,
  body,
) = {
  set document(title: title)
  set text(lang: lang)
  set page(paper: "us-letter")

  set heading(numbering: numbering, supplement: [Chapitre])
  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    if chapter-on-same-page {
      set block(spacing: 1.2em)
      box(
        fill: _gray,
        width: 100%,
        height: 125pt,
        align(
          center + horizon,
          [
            #line(length: 80%)
            #it.supplement #counter(heading).display() \ #text(
              weight: "regular",
              it.body,
            )
            #line(length: 80%)
          ],
        ),
      )
    } else {
      align(center + horizon)[#it.supplement #counter(
          heading,
        ).display() \ #text(weight: "regular", it.body)]
      pagebreak()
    }
  }
  show: body => if numbering != none {
    _chapter-figures(numbering, body)
  } else { body }

  // Outline entries of appendices (see `annexes`) read "Annexe A – Titre"
  show outline.entry.where(level: 1): it => {
    let el = it.element
    if el.func() == heading {
      block(link(
        el.location(),
        it.indented(none, [#el.supplement #it.prefix() --- #it.inner()]),
      ))
    } else { it }
  }

  set par(justify: justify)

  let footer-content = if (show-page-numbering) {
    align(center, context {
      let page-num = counter(page).get().first()
      if (page-num >= first-page-to-number) { [--- #page-num ---] }
    })
  }
  set page(footer: footer-content)

  let body-content = {
    let filigran_color = black.transparentize(94%)
    set page(
      background: if (watermark-text not in ("", none)) {
        rotate(-55deg, rect(
          smallcaps[#text(
            watermark-text,
            size: 40pt,
            weight: "bold",
            fill: filigran_color,
          )],
          fill: filigran_color,
          inset: 1em,
        ))
      },
    )

    if (title != none) {
      align(center + horizon, block[
        #if (title != none) { _title(title) }

        #if (authors != none) {
          authors-header(
            if (type(authors) == dictionary) { (authors,) } else { authors },
          )
        }

        #if (date != none) {
          if (lang == "fr") { "Version du " } else { "Version of " }
          long-date-display(date: date, capitalize: true, lang: lang)
        }

      ])
      pagebreak()
    }

    // Hide outlines that would be empty (e.g. no figures in the document)
    show outline: it => context {
      if query(it.target).len() > 0 {
        show heading: it2 => {
          if it2.level == 1 { it2.body } else { it2 }
        }
        it
      }
    }

    show cite: citesugar

    show link: it => {
      if type(it.dest) == str {
        // External URL only
        text(fill: rgb("#000070"), underline(it))
      } else {
        // Labels, locations, etc. are left as they are
        it
      }
    }

    show quote: it => [
      _#align(center, box(width: 80%)[#align(left, it)])_
    ]

    if (lang == "fr") {
      let narrow-space = sym.space.nobreak.narrow
      show regex("\\s*\\:"): [#narrow-space:]
      show regex("\\s*\\;"): [#narrow-space;;]
      show regex("\\s*\\?"): [#narrow-space?]
      show regex("\\s*\\!"): [#narrow-space!]
      body
    } else {
      body
    }
  }

  fancy-units-configure(
    per-mode: "slash",
    decimal-separator: [.],
    unit-separator: [.],
    quantity-separator: [~],
  )

  show table.cell: it => {
    if it.y == 0 { strong(it) } else { it }
  }
  set table(fill: (x, y) => if y == 0 { table-header-color })

  body-content
}

/// Turns every following heading into an appendix: A, A.1, B…
/// Usage: `#show: annexes` before the first appendix.
#let annexes(body) = {
  counter(heading).update(0) // restart numbering at A
  set heading(numbering: "A.1", supplement: _annexe-supplement)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block[#it.supplement #counter(heading).display() -- #it.body]
  }
  show: _chapter-figures.with("A.1")

  body
}

#let two-columns-table(..body) = {
  align(center, table(
    columns: 2,
    align: (right, left),
    stroke: none,
    fill: none,
    // Rangée vide de hauteur nulle : la première vraie rangée n'est plus la
    // rangée 0 et n'est donc pas mise en gras comme un en-tête.
    table.cell(colspan: 2, inset: 0pt)[],
    ..body,
  ))
}
