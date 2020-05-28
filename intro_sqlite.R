library(pacman)
p_load(DBI, RSQLite)

con <- dbConnect(SQLite(),":memory:")
dbWriteTable(con,"mtcars",mtcars)
dbListFields(con,"mtcars")

result <- dbGetQuery(con, "SELECT * FROM mtcars WHERE cyl = 4")
result



