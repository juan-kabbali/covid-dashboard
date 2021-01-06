library(DBI)
library(RMySQL)
library(rjson)

source("conf/global.R")

# geojson data
deparments <- fromJSON(file = geolocation$deparments)
regions <- fromJSON(file = geolocation$regions)

# connection instance
conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = mysql$dbname,
    host = mysql$host,
    username = mysql$username,
    password = mysql$password)


##################################################################################################
######################## generic methods for interacting with MySQL ##############################
##################################################################################################

getIndicatorCount <- function (column_name, table_name){
  query <- glue::glue("SELECT SUM({column_name}) as indicator_sum FROM {table_name};")
  result <- suppressWarnings(dbGetQuery(conn, query))
  return(result$indicator_sum)
}

getIndicatorCountBy <- function (ind_col_name, ind_tbl_name, ind_id, dim_col_name, dim_tbl_name, dim_id){
  query <- glue::glue("
    SELECT {dim_tbl_name}.{dim_col_name} AS segment, SUM({ind_tbl_name}.{ind_col_name}) AS indicator_sum
    FROM {ind_tbl_name}
    LEFT JOIN {dim_tbl_name} ON {ind_tbl_name}.{ind_id} = {dim_tbl_name}.{dim_id}
    GROUP BY {dim_tbl_name}.{dim_col_name}
  ")
  result <- suppressWarnings(dbGetQuery(conn, query))
  return(result)
}

getHistoric <- function (column_name, table_name, cumulated = TRUE, groupBy = "m"){
  time_expression <- time_segments[[groupBy]][["group_expression"]]
  query <- glue::glue("
    SELECT {time_expression} AS `date`,
           sum({table_name}.{column_name}) AS `indicator_sum`
    FROM {table_name}
    LEFT JOIN dim_date ON {table_name}.id_date = dim_date.ID_DATE
    GROUP BY {time_expression}")

  if (cumulated){
    query <- glue::glue("
      WITH q AS (
        {query}
      )
      SELECT *, SUM(indicator_sum) OVER(ORDER BY date) as cumulative_sum
      FROM q
    ")
  }
  result <- suppressWarnings(dbGetQuery(conn, query))
  return(result)
}