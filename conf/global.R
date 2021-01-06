# MySQL connection properties
mysql <- list(
  host = "localhost",
  dbname = "covid",
  username = "root",
  password = ""
)

# geolocation properties
geolocation <- list(
  deparments = "data/deparments.geojson",
  regions = "data/regions.geojson",
  table = "dim_location",
  region = "REGION",
  departement = "DEPARTAMENT",
  id = "ID_LOCATION"
)

# time dimention properties
time_segments <- list(
  d = list(
    name = "Jour",
    key = "d",
    group_expression = "date(dim_date.DATE_AS_DATE)"
  ),

  w = list(
    name = "Semaine",
    key = "w",
    group_expression = "str_to_date(concat(yearweek(dim_date.DATE_AS_DATE), ' Sunday'), '%X%V %W')"
  ),

  m = list(
    name = "Mois",
    key = "m",
    group_expression = "str_to_date(concat(date_format(dim_date.DATE_AS_DATE, '%Y-%m'), '-01'), '%Y-%m-%d')"
  ),

  q = list(
    name = "Quarter",
    key = "q",
    group_expression = "str_to_date(concat(year(dim_date.DATE_AS_DATE), '-', ((quarter(dim_date.DATE_AS_DATE) * 3) - 2), '-01'), '%Y-%m-%d')"
  )
)

