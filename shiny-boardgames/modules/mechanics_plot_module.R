library("plotly")

###### Helpers 

fontbold <- function(x) paste0("<b>", x, "<b>")

###### Module UI 

mechanics_mod_ui <- function(id) {
  ns <- NS(id)
  
  plotlyOutput(ns("mecPlot")) #, height = "94vh"
  
}

###### Module Server  
######

mechanics_mod_server <- function(id, rank_range) {

  moduleServer(id,
             
      function(input, output, session) {
        

        observe({
        n_games <- rank_range()[2] - rank_range()[1] + 1
        
        summary <- mechanics[bgg_rank >= rank_range()[1] &
                             bgg_rank <= rank_range()[2], 
                                          list(N = .N, perc = round((.N/n_games)*100, 2)), 
                                          by = mechanic_name]
                     
        summary <- summary[order(N, decreasing = T),]
                     
        base_cut <- summary[20, ]$N ## about 20 mechanics
                     
        summary <- summary[order(N, decreasing = T) & N >= base_cut,]                   
        
        output$mecPlot <- renderPlotly({
          
                            plot_ly(summary, 
                                    y = ~mechanic_name, x = ~perc,
                                    color = I("red"),
                                    type = "bar", orientation = 'h',
                                    text = ~paste0(fontbold("# Games: "), N, "<br>",
                                                   fontbold("% Games: "), scales::percent(perc, scale = 1), "<br>",
                                                   fontbold("Mechanic: "), mechanic_name),
                                    hoverinfo = "text") %>% 
                              layout(yaxis = list(categoryorder = "total ascending",
                                                  title = list(text = fontbold("Mechanic"),
                                                               standoff = 0L)),
                                     title = fontbold(paste0("Game Rank: ", 
                                                             rank_range()[1], " - ",
                                                             rank_range()[2])),
                                     xaxis = list(title = fontbold("Percentage"),
                                                  ticksuffix = "%", 
                                                  range = c(0, ceiling(max(summary$perc*1.2))))
                                    )
                            
                      })
      })
        }
  
  )
}
