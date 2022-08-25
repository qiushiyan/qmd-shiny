library(dplyr, warn.conflicts = TRUE)

sales <- readr::read_csv("https://raw.githubusercontent.com/hadley/mastering-shiny/master/sales-dashboard/sales_data_sample.csv") |>
    janitor::clean_names() |>
    select(-starts_with("contact"), -starts_with("address"))

library(DBI)
con <- dbConnect(
    RPostgreSQL::PostgreSQL(),
    dbname = "qiushi",
    host = "localhost",
    port = 5432,
    user = Sys.getenv("PG_USERNAME"),
    password = Sys.getenv("PG_PASSWORD")
)

readr::write_csv(sales, "sales.csv")

dbWriteTable(con, "sales", sales, row.names = FALSE, overwrite = TRUE)
