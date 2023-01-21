library("plotly")

###### Helpers 

fontbold <- function(x) paste0("<b>", x, "<b>")

###### Module UI 

mechanics_mod_ui <- function(id) {
  ns <- NS(id)
  
  plotlyOutput(ns("mecPlot"), height = "60vh") #, height = "94vh"
  
}

###### Module Server  
######

mechanics_mod_server <- function(id, filters) {

  moduleServer(id,
             
      function(input, output, session) {
        
        

        observe({
          

        n_games <- filters$rank_range()[2] - filters$rank_range()[1] + 1
        
        summary <- mechanics[rank >= filters$rank_range()[1] &
                             rank <= filters$rank_range()[2] &
                             !(mechanic_name %in% filters$mechanic_selector()) &
                               rank_name == filters$rank_name(), 
                                          list(N = .N, 
                                               perc = round((.N/n_games)*100, 2),
                                               GameSamples = lapply(na.omit(.SD[1:3]), 
                                                                    paste0, 
                                                                    collapse="<br>            ")), 
                                          by = mechanic_name,
                                          .SDcols = "name"]
                     
        summary <- summary[order(N, decreasing = T),]
                     
        base_cut <- summary[min(20, nrow(summary)), ]$N ## about 20 mechanics
                     
        summary <- summary[order(N, decreasing = T) & N >= base_cut,]                   
        
        output$mecPlot <- renderPlotly({
          
                            plot_ly(summary, 
                                    y = ~mechanic_name, x = ~perc,
                                    color = I("#ff5100"),
                                    type = "bar", orientation = 'h',
                                    text = ~paste0(fontbold("Mechanic: "), mechanic_name, "<br>",
                                                   fontbold("# Games: "), N, "<br>",
                                                   fontbold("% Games: "), scales::percent(perc, scale = 1), "<br>",
                                                   fontbold("Top 3: "), GameSamples),
                                    hoverinfo = "text") %>% 
                              layout(yaxis = list(categoryorder = "total ascending",
                                                  title = list(text = fontbold("Mechanic"),
                                                               standoff = 0L)),
                                     title = fontbold(paste0("Game Rank: ", 
                                                             filters$rank_range()[1], " - ",
                                                             filters$rank_range()[2])),
                                     xaxis = list(title = fontbold("Percentage"),
                                                  ticksuffix = "%",
                                                  gridcolor = 'grey'
                                                  #range = c(0, ceiling(max(summary$perc*1.2)))
                                                  ),
                                     paper_bgcolor='rgba(0,0,0,0)',
                                     plot_bgcolor='rgba(0,0,0,0)'
                                    )
                            
                      })
      })
        }
  
  )
}
