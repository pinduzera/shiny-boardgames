library("data.table")


modules <- list.files("./modules/", full.names = TRUE)

for (mod in modules){
    source(mod)
}

# gameList <- readRDS("shiny-boardgames/data/bgg_data.Rdata")
# 
# mechanics <- gameList[, rbindlist(boardgamemechanic), by = .(id, name)]

gameList <- fread("./data/bgg_data_ranked.csv")
gameList[, id := as.numeric(id)]

mechanics <- fread("./data/boardgamemechanic_ranked.csv")
mechanics[, id := as.numeric(id)]

mechanics <- mechanics[gameList[,.(id, bgg_rank, name)], on = "id" ]

