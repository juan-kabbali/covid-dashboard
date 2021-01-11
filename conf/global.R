# MySQL connection properties
mysql <- list(
  host = "localhost",
  dbname = "entrepot_covid",
  username = "root",
  password = ""
)

# geolocation properties
geolocation <- list(
  deparments = "data/deparments.geojson",
  regions = "data/regions.geojson",
  table = "dim_location",
  region = "region_name",
  departement = "department_name",
  id = "id"
)

# time dimention properties
time_segments <- list(
  d = list(
    name = "Jour",
    key = "d",
    group_expression = "date(dim_date.date)"
  ),

  w = list(
    name = "Semaine",
    key = "w",
    group_expression = "str_to_date(concat(yearweek(dim_date.date), ' Sunday'), '%X%V %W')"
  ),

  m = list(
    name = "Mois",
    key = "m",
    group_expression = "str_to_date(concat(date_format(dim_date.date, '%Y-%m'), '-01'), '%Y-%m-%d')"
  ),

  q = list(
    name = "Quarter",
    key = "q",
    group_expression = "str_to_date(concat(year(dim_date.date), '-', ((quarter(dim_date.date) * 3) - 2), '-01'), '%Y-%m-%d')"
  )
)

