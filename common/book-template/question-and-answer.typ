
/// Defines one choice of a multiple-choice question
///
/// - body (content): The text of the choice.
/// - is-right (bool): Whether this choice is a right answer.
/// -> dictionary
#let MultipleChoiceAnswer(body, is-right: false) = (
  body: body,
  is-right: is-right,
)

/// Defines a multiple-choice template
///
/// - body (content): The text of the question.
/// - choices (array): The choices to be presented in the form of an array of MultipleChoiceAnswer.
/// - show-right-answers (bool): Whether to visually show the right answers.
/// -> content
#let multiple-choice(body, choices, show-right-answers: false) = {
  let is-shown(e) = show-right-answers and e.is-right
  // La lettre d'une bonne réponse est aussi en gras
  let label(n) = {
    let letter = numbering("(a)", n)
    if is-shown(choices.at(n - 1)) { strong(letter) } else { letter }
  }
  set enum(numbering: label, spacing: 10pt, indent: 1em)
  body
  choices.map(e => [+ #if is-shown(e) { strong(e.body) } else { e.body }]).join()
}
