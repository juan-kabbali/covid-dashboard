mysql = list(
  host = "localhost",
  dbname = "covid",
  username = "root",
  password = ""
)

geolocation = list(
  deparments = "data/deparments.geojson",
  regions = "data/regions.geojson",
  table = "dim_location",
  region = "REGION",
  departement = "DEPARTAMENT",
  id = "ID_LOCATION"
)
