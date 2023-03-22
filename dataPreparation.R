###############################################################
############### Transforming raw data to shiny  ###############
###############################################################

## data sourced from bgg-scrappeR
gameList <- readRDS("shiny-boardgames/unused_data/bgg_data.Rdata")

### separa name+id
# mechanics <- gameList[, rbindlist(boardgamemechanic), by = .(id, name)]

gameList <- gameList[!is.na(as.numeric(bgg_rank)),,]
simpleList <- gameList[, .SD, .SDcols = !is.list]
fwrite(simpleList, "shiny-boardgames/data/bgg_data_ranked.csv")

mechanics <- gameList[, rbindlist(boardgamemechanic), by = .(id)]
fwrite(mechanics, "shiny-boardgames/data/boardgamemechanic_ranked.csv")

ranks <- gameList[, rbindlist(ranks), by = .(id)]
fwrite(ranks, "shiny-boardgames/data/ranks.csv")

ranks <- gameList[, rbindlist(boardgamedesigner), by = .(id)]
fwrite(ranks, "shiny-boardgames/data/designer_ranked.csv")


#### implement pulling small description
# boardList <- fread("shiny-boardgames/unused_data/boards_list_2023-03-22.csv")
# boardList$year <- str_extract(boardList$Title, '(?![(])\\d+(?=[)])')
# boardList$title <- str_extract(boardList$Title, '^.+?(?=\n\t)')
# boardList$desc <- str_extract(boardList$Title, '[^\t]+$')
# boardList$desc <- str_replace(boardList$desc, '^\\(\\d+\\)$', "")
# boardList$id <- str_match(boardList$link, '/*(\\d+)/')[,2]
