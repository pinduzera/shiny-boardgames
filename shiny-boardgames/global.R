library("data.table")

modules <- list.files("./modules/", full.names = TRUE)

for (mod in modules){
    source(mod)
}

# gameList <- readRDS("shiny-boardgames/data/bgg_data.Rdata")
# 
# mechanics <- gameList[, rbindlist(boardgamemechanic), by = .(id, name)]

gameList <- fread("data/bgg_data_ranked.csv")
gameList[, id := as.numeric(id)]

mechanics <- fread("data/boardgamemechanic_ranked.csv")
mechanics[, id := as.numeric(id)]

ranks <- fread("data/ranks.csv")
ranks[,  c("id", "rank") := list(as.numeric(id), as.numeric(rank)), .SDcols =]
rank_count <- ranks[ , .N, by = rank_name]
rank_count <- rank_count[N > 100, ]
ranks <- ranks[rank_name %in% rank_count$rank_name, , ]

mechanics <- mechanics[gameList[,.(id, name)], on = "id" ]
mechanics <- mechanics[ranks[,.(id, rank_name, rank)], on = "id", allow.cartesian=TRUE]


