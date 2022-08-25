library(shiny)
library(dplyr)
library(pool)
library(DBI)
library(DT)

create_pool <- function() {
    dbPool(
        RPostgreSQL::PostgreSQL(),
        dbname = "qiushi",
        host = "localhost",
        port = 5432,
        user = Sys.getenv("PG_USERNAME"),
        password = Sys.getenv("PG_PASSWORD")
    )
}


read_sales <- function(db_pool) {
    db_pool |>
        tbl("sales") |>
        collect()
}

make_choices <- function(x) {
    c(list("All"), x)
}

notify <- function(msg, id = NULL, type = "message", ...) {
  showNotification(msg, id = id, duration = NULL, closeButton = FALSE, type = type, ...)
}

render_report <- function(input, 
                          params,
                          output_file, 
                          output_format = "pdf",
                          ...) {
  quarto::quarto_render(input,
                        execute_params = params, 
                        output_file = output_file,
                        output_format = output_format, 
                        ... 
                    )
}
