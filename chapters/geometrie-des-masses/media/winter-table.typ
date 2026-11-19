#import "../../../common/lib.typ": *

#let winter-table = table(
  columns: 7,
  align: (x, y) => horizon + (if x == 1 { right } else if x == 3 { left }),
  stroke: (x, y) => {
    if x >= 1 and x <= 3 {
      if y == 0 { (top: 1pt) }
      if y >= 1 { (bottom: 1pt) }
      if y == 2 { (top: 1pt) }
    } else { 1pt }
  },
  inset: 6pt,
  table.cell(rowspan: 2)[Membre],
  table.cell(align: center, colspan: 3)[Extrémités],
  table.cell(rowspan: 2)[Masse \ relative],
  table.cell(colspan: 2)[Position relative du CM],
  table.cell(fill: table-header-color)[*Proximale*],
  table.cell(fill: table-header-color)[*→*],
  table.cell(fill: table-header-color)[*Distale*],
  table.cell(fill: table-header-color)[*Proximal*],
  table.cell(fill: table-header-color)[*Distal*],

  [Tête cou tronc], [épaule], [→], [hanche], [0.578], [0.660], [0.340],

  [tête cou],
  [7#super[ème] cervicale],
  [→],
  [oreille],
  [0.081],
  [1.000],
  [0.000],

  [Main], [poignet], [→], [2#super[ème] art. majeur], [0.006], [0.506], [0.494],

  [Avant-bras], [coude], [→], [poignet], [0.016], [0.430], [0.570],

  [Bras], [épaule], [→], [coude], [0.028], [0.436], [0.564],

  [Membre sup.], [épaule], [→], [poignet], [0.050], [0.530], [0.470],

  [Pied],
  [malléole lat.],
  [→],
  [MTP 2#footnote[2#super[ème] articulation métatarso-phalangienne.]],
  [0.0145],
  [0.500],
  [0.500],

  [Jambe], [genou], [→], [malléole lat.], [0.0465], [0.433], [0.567],

  [Cuisse], [hanche], [→], [genou], [0.100], [0.433], [0.567],

  [Membre inf.], [hanche], [→], [malléole lat.], [0.161], [0.447], [0.533],
)
