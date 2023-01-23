###### Helpers 

library("DT")
library("plotly")


###### Module UI 

designer_mod_ui <- function(id) {
  ns <- NS(id)
  
  
  tabPanel("Designers",
           
           
           
           sidebarLayout(     
              sidebarPanel(
                
                selectizeInput(ns("designer_name"),
                               label = "Designer Name",
                               choices = c(), ## see updateSelectizeInput server
                               multiple = FALSE,
                               options = list(placeholder = 'Type Name')
                ),
                
                width = 2
              ),
              
              mainPanel(
              tabsetPanel(type = "tabs",

                          tabPanel("Game List", dataTableOutput(ns("DGameTable"))),
                          tabPanel("Future", "Future Content"),
                ),
                width = 10
              )
              )
           )
  
}

###### Module Server  
######

designer_mod_server <- function(id) {
  
  moduleServer(id,
               
               function(input, output, session) {
                 
                 
                 observeEvent(input$designer_name, {
                 SingleDesignerGames <- designerGameList[designer_name == input$designer_name,]
                 
                 output$DGameTable <- renderDT({
                        
                      
                      DT::datatable(gameList[id %in% SingleDesignerGames$id,
                                             c("bgg_rank", "thumbnail", "NameLink",
                                               "yearpublished", "averageweight", 
                                               "playingtime", "minplayers", "maxplayers",
                                               "minage")],
                                    escape = FALSE,
                                    rownames = FALSE,
                                    colnames = c("BGG Rank", "Cover", "Name",
                                                 "Year", "Weight", "Play Time (min)","Min. Players",
                                                 "Max. Players", "Age"),
                                    style = "bootstrap4",
                                    selection = list(selectable = FALSE),
                                    options = list(pageLength = 10)
                                    ) %>%
                     formatStyle(1:10, 'vertical-align'='middle')
                   
                   }) 
                 }) 
                 
                 updateSelectizeInput(session, 
                                      inputId = 'designer_name', 
                                      selected = "Vital Lacerda", 
                                      choices = designerList,
                                      server = TRUE)
               }
               
  )
}
