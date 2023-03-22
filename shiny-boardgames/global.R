library("data.table")

modules <- list.files("./modules/", full.names = TRUE)

for (mod in modules){
    source(mod)
}


###############################################################
###############################################################
###############################################################

### all games
gameList <- fread("data/bgg_data_ranked.csv")
gameList[, id := as.numeric(id)]
gameList <- gameList[order(bgg_rank)]

gameList[, thumbnail := paste0("<img src='", thumbnail ,"' height='85'></img>")]
gameList[, NameLink := paste0(" <a href='https://boardgamegeek.com/boardgame/", id , "' target='_blank'>", name, "</a> ")]

### Game ranks
ranks <- fread("data/ranks.csv")
ranks[,  c("id", "rank") := list(as.numeric(id), as.numeric(rank)), .SDcols =]
rank_count <- ranks[ , .N, by = rank_name]
rank_count <- rank_count[N > 100, ]
ranks <- ranks[rank_name %in% rank_count$rank_name, , ]


### mechanics 
mechanics <- fread("data/boardgamemechanic_ranked.csv")
mechanics[, id := as.numeric(id)]

mechanics <- mechanics[gameList[,.(id, name)], on = "id" ]
mechanics <- mechanics[ranks[,.(id, rank_name, rank)], on = "id", allow.cartesian=TRUE]


### designers
designerGameList <- fread("data/designer_ranked.csv")
designerGameList[, id := as.numeric(id)]
designerList <- unique(designerGameList$designer_name)
designerList <- designerList[order(designerList)]


