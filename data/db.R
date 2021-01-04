library(DBI)
library(RMySQL)

source("conf/global.R")

conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = mysql$dbname,
    host = mysql$host,
    username = mysql$username,
    password = mysql$password)

dbGetQuery(conn, "SELECT * FROM dim_age LIMIT 5;")


dbDisconnect(conn)