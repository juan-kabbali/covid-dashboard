selected_indicator <- NULL

# indicators metadata
indicators <- list(
  cp = list(
    name = "Cas Positifs",
    key = "cp",
    value = 0,
    table = "fact_test_virology",
    column = "n_positive_test"
  ),

  dec = list(
    name = "Décés",
    key = "dec",
    value = 0,
    table = "fact_new_hosp",
    column = "incid_dc"
  ),

  hosp = list(
    name = "Hospitalisations",
    key = "hosp",
    value = 0,
    table = "fact_new_hosp",
    column = "incid_hosp"
  ),

  rea = list(
    name = "Réanimation",
    key = "rea",
    value = 0,
    table = "fact_new_hosp",
    column = "incid_rea"
  ),

  rad = list(
    name = "Rétour à Domicile",
    key = "rad",
    value = 0,
    table = "fact_new_hosp",
    column = "incid_rad"
  ),

  urgs = list(
    name = "Urgences",
    key = "urgs",
    value = 0,
    table = "fact_hosp",
    column = "nbre_pass_corona"
  )
)
