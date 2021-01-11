selected_indicator <- NULL

# indicators metadata
indicators <- list(
  cp = list(
    name = "Cas Positifs",
    key = "cp",
    value = 0,
    table = "fact_test",
    column = "positive_tests"
  ),

  dec = list(
    name = "Décés",
    key = "dec",
    value = 0,
    table = "fact_new_hospital",
    column = "incid_dc"
  ),

  hosp = list(
    name = "Hospitalisations",
    key = "hosp",
    value = 0,
    table = "fact_new_hospital",
    column = "incid_hosp"
  ),

  rea = list(
    name = "Réanimation",
    key = "rea",
    value = 0,
    table = "fact_new_hospital",
    column = "incid_rea"
  ),

  rad = list(
    name = "Rétour à Domicile",
    key = "rad",
    value = 0,
    table = "fact_new_hospital",
    column = "incid_rad"
  ),

  urgs = list(
    name = "Urgences",
    key = "urgs",
    value = 0,
    table = "fact_emergencies",
    column = "emergencies"
  )
)
