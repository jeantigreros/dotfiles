#let conf(titulo: [], autor: [], escuela: [], curso: [], tutor: [], doc
) = {
  set page(
    paper: "us-letter",
    margin: 1in,
    numbering: "1"
  ) // Hoja carta, numeración APA
  set text(size: 12pt)       // Fuente estándar APA, interlineado doble
  set bibliography(style: "apa")
  set par(
    spacing: 1.5em,
    first-line-indent: (
      amount: 0.5in,
      all: true,
    ),
    leading: 1.5em,
  )
  let uni="Universidad Nacional Abierta y A Distancia"

  show heading.where(level: 1): it => [
    #pagebreak()
    #it
  ]
  show link: set text(fill: blue)
  show link: underline
 
  show heading: set block(spacing: 1.5em)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 4).or(heading.where(level: 5)): it => [#it.body.]

  show table.cell: set par(leading: 1em)


  set figure.caption(separator: parbreak(), position: top)
  show figure.caption: set align(left)
  show figure.caption: set par(first-line-indent: 0em)
  show figure.caption: it => {
    strong[#it.supplement #context it.counter.display(it.numbering)]
    it.separator
    emph(it.body)
  }
set list(
    marker: ([•], [◦]),
    indent: 0.5in - 1.75em,
    body-indent: 1.3em,
  )

  set enum(
    indent: 0.5in - 1.5em,
    body-indent: 0.75em,
  )

  set raw(
    tab-size: 4,
    block: true,
  )

  show raw.where(block: true): block.with(
    fill: luma(250),
    stroke: (left: 3pt + rgb("#6272a4")),
    inset: (x: 10pt, y: 8pt),
    width: auto,
    breakable: true,
    outset: (y: 7pt),
    radius: (left: 0pt, right: 6pt),
  )

  show raw: set text(
    size: 10pt,
  )

  show raw.where(block: true): set par(leading: 1em)
  show figure.where(kind: raw): set block(breakable: true, sticky: false, width: 100%)

  set math.equation(numbering: "(1)")


  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 1em,
    radius: 0.5em,
    width: 100%,
  )

  show bibliography: set par(
    first-line-indent: 0in,
    hanging-indent: 0.5in,
  )

  show table.cell.where(y: 0): strong
  place(
    top + center,
    float: true,
    scope: "parent", 
    align(center)[
      #set text(weight: "bold", size: 14pt)
      #grid(
        columns: (1),
        rows: (7em),
        [#titulo],
        [#autor],
        [#escuela, #uni],
        [#curso],
        [#tutor]
      )
      #datetime.today().display()
    ],
  )
  doc
}
