#import "@preview/fancy-units:0.1.1": fancy-units-configure, num, qty, unit

/// Convert a string or a piece of content (e.g. `[1 234,5]`) to plain text.
///
/// - value (str|content|int|float): The value to convert.
/// -> str
#let _to-string(value) = {
  if type(value) == str {
    value
  } else if type(value) == content {
    if value.has("text") {
      _to-string(value.text)
    } else if value.has("children") {
      value.children.map(_to-string).join("")
    } else if value.has("body") {
      _to-string(value.body)
    } else if value == [ ] {
      " "
    } else {
      ""
    }
  } else {
    str(value)
  }
}

/// Format a number with the given thousands and decimal separators.
///
/// - n (int|float|str|content): The number to format. Strings and content may
///   use either a comma or a dot as decimal separator, and may contain spaces.
/// - thousands (str): The thousands separator.
/// - decimal (str): The decimal separator.
/// - decimals (auto|int): The number of decimals. `auto` keeps the decimals of
///   the value as given (`"1.50"` stays `1.50`, `1.5` stays `1.5`, and floats
///   lose their binary noise: `0.1 + 0.2` gives `0.3`); an integer rounds (or
///   pads with zeros) to that many decimals.
/// -> str
#let _format-number(n, thousands, decimal, decimals) = {
  let raw = if type(n) == float and n != 0.0 {
    // Floats are written from their mantissa rounded to 14 significant
    // digits, which removes the binary noise of computations (0.1 + 0.2 →
    // 0.3). The decimal point is then placed by hand, so the result never
    // uses scientific notation.
    let e = int(calc.floor(calc.log(calc.abs(n))))
    let m = calc.round(calc.abs(n) / calc.pow(10.0, e), digits: 13)
    if m >= 10 { (m, e) = (m / 10, e + 1) }
    let digits = str(m).replace(".", "")
    let point = e + 1 // position of the decimal point in `digits`
    let body = if point <= 0 {
      "0." + "0" * -point + digits
    } else if point >= digits.len() {
      digits + "0" * (point - digits.len())
    } else {
      digits.slice(0, point) + "." + digits.slice(point)
    }
    if n < 0 { "-" + body } else { body }
  } else if type(n) == int or type(n) == float { str(n) } else { _to-string(n) }
  raw = raw.replace(regex("\\s+"), "").replace(",", ".").replace("−", "-")
  if raw == "" { raw = "0" }
  let negative = raw.starts-with("-")
  raw = raw.trim("-", at: start).trim("+", at: start)

  let (int-str, dec-str) = if decimals == auto {
    let parts = raw.split(".")
    (parts.at(0), parts.at(1, default: ""))
  } else {
    assert(
      type(decimals) == int and decimals >= 0,
      message: "'decimals' must be auto or a non-negative int",
    )
    let scale = calc.pow(10, decimals)
    let scaled = int(calc.round(float(raw) * scale))
    let fraction = str(calc.rem(scaled, scale))
    (
      str(calc.quo(scaled, scale)),
      if decimals == 0 { "" } else {
        "0" * (decimals - fraction.len()) + fraction
      },
    )
  }
  if int-str == "" { int-str = "0" }

  // Group the integer part by thousands, from the right.
  let groups = ()
  while int-str.len() > 3 {
    groups.insert(0, int-str.slice(-3))
    int-str = int-str.slice(0, -3)
  }
  groups.insert(0, int-str)

  let is-zero = (groups + (dec-str,)).join("").replace("0", "") == ""
  let sign = if negative and not is-zero { "-" } else { "" }
  (
    sign
      + groups.join(thousands)
      + if dec-str != "" { decimal + dec-str } else { "" }
  )
}

/// Format a number according to French conventions, with space as thousands separator and comma as decimal separator.
///
/// - n (int|float|str|content): The number to format.
/// - decimals (auto|int): The number of decimals. `auto` keeps the decimals of
///   the value as given; an integer rounds (or pads with zeros) to that many.
/// -> str
#let fr-number(n, decimals: auto) = _format-number(n, " ", ",", decimals)

/// Format a number according to English conventions, with comma as thousands separator and dot as decimal separator.
///
/// - n (int|float|str|content): The number to format.
/// - decimals (auto|int): The number of decimals. `auto` keeps the decimals of
///   the value as given; an integer rounds (or pads with zeros) to that many.
/// -> str
#let en-number(n, decimals: auto) = _format-number(n, ",", ".", decimals)

/// Create an author entry for `authors-header`.
///
/// - name (str): The name of the author.
/// - affiliations (none|str|array): The affiliation(s) of the author. No affiliation is added if none is provided.
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
///
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
///
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

/// Hide content without taking any space in the layout (unlike `hide`, which keeps its space).
///
/// - body (content): The content to hide.
/// -> content
#let full-hide(body) = hide(place(body))

/// Format a value as an angle in degrees, with no space before the degree sign.
///
/// - value (int|float|content): The angle value.
/// -> content
#let to-degree(value) = qty(quantity-separator: none)[#value][#sym.degree]

/// Capitalize the first letter of a string.
///
/// - body (str): The string to capitalize.
/// -> str
#let capitalize(body) = body.replace(
  regex("^\w"),
  m => upper(m.text),
)

/// Build every grammatical form of a configurable French term (articles,
/// capitalization, plural, gender agreement, symbol). Before a vowel or a
/// silent h, the article is elided (« l'énergie », « de l'énergie »).
///
/// ```example
/// #let force = generate-gender-mapping(
///   (text: "force", plural: "forces", is-feminine: true, symbol: "F"),
/// )
/// #force.name, #force.Name         // force, Force
/// #force.le, #force.Le             // la force, La force
/// #force.un, #force.Un             // une force, Une force
/// #force.du, #force.Du             // de la force, De la force
/// #force.au, #force.Au             // à la force, À la force
/// #force.ce, #force.Ce             // cette force, Cette force (cet before a vowel)
/// #force.names, #force.Names       // forces, Forces
/// #force.les, #force.des, #force.aux // les forces, des forces, aux forces
/// $#force.symbol$                  // F
/// #force.article.Du                // De la (article only)
/// constant#force.e, #force.il      // constante, elle (#force.Il: Elle)
/// constant#force.es                // constantes (plural agreement)
/// #if force.feminine [nulle] else [nul]
/// ```
///
/// - element (dictionary): The term, often read from a section of the
///   configuration, with the keys:
///   - `text` (str, required): the singular, e.g. `"quantité de rotation"`;
///   - `plural` (str, required): the plural, e.g. `"quantités de rotation"`;
///   - `is-feminine` (bool, default `false`): the grammatical gender;
///   - `symbol` (str, optional): the symbol in Typst math notation, without
///     the `$` (e.g. `"q"` or `"sigma"`), evaluated in math mode.
/// - elide (auto|bool): Whether to elide the article (« l' », « de l' »). `auto`
///   elides before a vowel or an h; pass `false` for an aspirated h.
/// -> dictionary
#let generate-gender-mapping(element, elide: auto) = {
  for key in ("text",) {
    assert(
      key in element,
      message: "generate-gender-mapping: missing key '"
        + key
        + "' in "
        + repr(element),
    )
  }
  let name = element.text
  let names = element.at("plural", default: none)
  let symbol = element.at("symbol", default: none)
  let feminine = element.at("is-feminine", default: false)
  let elide = if elide == auto {
    lower(name).match(regex("^[aeiouyhàâäéèêëîïôöùûü]")) != none
  } else { elide }

  let article = (
    le: if elide { "l'" } else if feminine { "la " } else { "le " },
    du: if elide { "de l'" } else if feminine { "de la " } else { "du " },
    au: if elide { "à l'" } else if feminine { "à la " } else { "au " },
    un: if feminine { "une " } else { "un " },
    ce: if feminine { "cette " } else if elide { "cet " } else { "ce " },
    les: "les ",
    des: "des ",
    aux: "aux ",
  )
  let cap(key) = upper(key.first()) + key.slice(1)
  for (key, value) in article {
    article.insert(cap(key), capitalize(value))
  }

  let forms = (
    name: name,
    Name: capitalize(name),
    names: names,
    Names: if names == none { none } else { capitalize(names) },
    article: article,
    feminine: feminine,
    e: if feminine { "e" } else { "" },
    es: if feminine { "es" } else { "s" },
    il: if feminine { "elle" } else { "il" },
    Il: if feminine { "Elle" } else { "Il" },
  )
  for key in ("le", "du", "au", "un", "ce", "les", "des", "aux") {
    let noun = if key in ("les", "des", "aux") { names } else { name }
    forms.insert(key, article.at(key) + noun)
    forms.insert(cap(key), capitalize(article.at(key) + noun))
  }
  if symbol != none { forms.insert("symbol", eval(symbol, mode: "math")) }
  forms
}
