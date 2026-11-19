#import "@preview/fancy-units:0.1.1": fancy-units-configure, num, qty, unit

/// Format a number according to French conventions, with space as thousands separator and comma as decimal separator.
///
/// - n (int|float): The number to format.
/// -> content
#let fr-number(n) = {
  let value = if type(n) == int or type(n) == float {
    n
  } else {
    let parsed = _to-string(n)
      .replace(regex("\\s+"), "")
      .replace(regex(","), ".")
    if parsed == "" { 0 } else { float(parsed) }
  }
  let negative = value < 0
  let abs-value = calc.abs(value)

  // Integer part with French thousands grouping.
  let integer = int(calc.floor(abs-value))
  let groups = ()
  let remaining = integer
  while remaining >= 1000 {
    let part = calc.rem(remaining, 1000)
    let part-str = if part < 10 {
      "00" + str(part)
    } else if part < 100 {
      "0" + str(part)
    } else {
      str(part)
    }
    groups.push(part-str)
    remaining = int(calc.floor(remaining / 1000))
  }

  let int-str = str(remaining)
  for part in groups.rev() {
    int-str += " " + part
  }

  // Keep up to 2 decimals when needed, using French comma.
  let decimals = int(calc.round((abs-value - integer) * 100))
  let dec-str = if decimals == 0 {
    ""
  } else if decimals < 10 {
    ",0" + str(decimals)
  } else {
    "," + str(decimals)
  }

  if negative {
    "-" + int-str + dec-str
  } else {
    int-str + dec-str
  }
}

/// Format a number according to English conventions, with comma as thousands separator and dot as decimal separator.
///
/// - n (int|float): The number to format.
/// -> content
#let en-number(n) = {
  let value = if type(n) == int or type(n) == float {
    n
  } else {
    let parsed = _to-string(n)
      .replace(regex("\\s+"), "")
      .replace(regex(","), ".")
    if parsed == "" { 0 } else { float(parsed) }
  }
  let negative = value < 0
  let abs-value = calc.abs(value)

  let integer = int(calc.floor(abs-value))
  let groups = ()
  let remaining = integer
  while remaining >= 1000 {
    let part = calc.rem(remaining, 1000)
    let part-str = if part < 10 {
      "00" + str(part)
    } else if part < 100 {
      "0" + str(part)
    } else {
      str(part)
    }
    groups.push(part-str)
    remaining = int(calc.floor(remaining / 1000))
  }

  let int-str = str(remaining)
  for part in groups.rev() {
    int-str += "," + part
  }

  let decimals = int(calc.round((abs-value - integer) * 100))
  let dec-str = if decimals == 0 {
    ""
  } else if decimals < 10 {
    ".0" + str(decimals)
  } else {
    "." + str(decimals)
  }

  if negative {
    "-" + int-str + dec-str
  } else {
    int-str + dec-str
  }
}

/// Elements of authors-header
/// - name (str): the name of the author
/// - affiliations (none | str | array): the affiliations of the author. No affiliations is added if none is provided
/// -> dictionary
#let Author(name, affiliations: none) = {
  let affs = if (affiliations == none) {
    ()
  } else if (type(affiliations) == str) {
    (affiliations,)
  } else if (type(affiliations) == array) { affiliations } else {
    assert(
      false,
      message: "'affiliations' must be none, str or an array of str",
    )
  }

  return (
    name: name,
    affiliations: affs,
  )
}

/// Format the authors header, including author names and their affiliations.
/// - authors (Author | array): An Author or an array of Author
/// -> content
#let authors-header(authors) = {
  // Extract unique affiliations
  let affiliations = ()
  for author in authors {
    assert(
      type(author) == dictionary
        and author.keys().contains("name")
        and author.keys().contains("affiliations"),
      message: "Each author must be a dictionary with a 'name' key and optionally an 'affiliations' key",
    )

    for aff in author.affiliations {
      if not affiliations.contains(aff) {
        affiliations.push(aff)
      }
    }
  }

  // Find affiliation number
  let affiliation-number(aff) = {
    for (i, item) in affiliations.enumerate() {
      if item == aff { return i + 1 }
    }
    return none
  }

  // Authors
  for (i, author) in authors.enumerate() {
    if i > 0 {
      ", "
    }

    author.name
    let affs = if (author.keys().contains("affiliations")) {
      if (type(author.affiliations) == str) {
        (author.affiliations,)
      } else { author.affiliations }
    } else { () }
    super(affs.map(aff => str(affiliation-number(aff))).sorted().join(", "))
  }

  linebreak()

  // Affiliations
  affiliations
    .map(aff => { emph(super(str(affiliation-number(aff))) + aff) })
    .join(", ")
}

/// Format a date in long form, optionally capitalizing the month and supporting multiple languages.
/// - date (datetime|none): The date to format. If none, the current date is used.
/// - capitalize (bool): Whether to capitalize the month name.
/// - lang (str): The language for the month name ("fr" for French, "en" for English).
/// -> content
#let long-date-display(date: none, capitalize: false, lang: "fr") = {
  let months = if (lang == "fr") {
    (
      "Janvier",
      "Février",
      "Mars",
      "Avril",
      "Mai",
      "Juin",
      "Juillet",
      "Août",
      "Septembre",
      "Octobre",
      "Novembre",
      "Décembre",
    )
  } else if (lang == "en") {
    (
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    )
  } else {
    error("Unsupported language for long-date-display: " + lang)
  }

  date = if (date == none) { datetime.today() } else { date }

  let translated-month(dt) = months.at(dt.month() - 1)

  let month = translated-month(date)
  if (not capitalize) {
    month = lower(month)
  }

  return [#date.day() #month #date.year()]
}

#let full-hide(body) = hide(place(body))

#let to-degree(value) = qty(quantity-separator: none)[#value][#sym.degree]
