library(DBI)
library(RMySQL)

source("conf/global.R")

deparments <- rjson::fromJSON(file = geolocation$deparments)
regions <- rjson::fromJSON(file = geolocation$regions)

conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = mysql$dbname,
    host = mysql$host,
    username = mysql$username,
    password = mysql$password)

getIndicatorCount <- function (column_name, table_name){
  query <- glue::glue("SELECT SUM({column_name}) as indicator_sum FROM {table_name};")
  result <- dbGetQuery(conn, query)
  return(result$indicator_sum)
}

getIndicatorCountBy <- function (ind_col_name, ind_tbl_name, ind_id, dim_col_name, dim_tbl_name, dim_id){
  query <- glue::glue("
    SELECT {dim_tbl_name}.{dim_col_name} AS segment, SUM({ind_tbl_name}.{ind_col_name}) AS indicator_sum
    FROM {ind_tbl_name}
    LEFT JOIN {dim_tbl_name} ON {ind_tbl_name}.{ind_id} = {dim_tbl_name}.{dim_id}
    GROUP BY {dim_tbl_name}.{dim_col_name}
  ")
  result <- dbGetQuery(conn, query)
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
  result <- dbGetQuery(conn, query)
  return(result)
}

#dbDisconnect(conn)