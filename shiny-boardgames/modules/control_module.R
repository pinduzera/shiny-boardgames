


control_mod_ui <- function(id) {
  ns <- NS(id)
  
  ### absoute panel allows overllapping
  # absolutePanel(id = "controls", class = "panel panel-default",
  #               top = 75, left = 55, width = 250, fixed=TRUE,
  #               draggable = FALSE, height = "auto",
  #               
  #               span(tags$i(h6("Select Rank information")), 
  #                    style="color:#045a8d"),
                
                # Input: Specification of range within an interval ----
  
  fluidRow(
  
  shinyWidgets::setSliderColor("#2b71ff", 1),
  shinyWidgets::chooseSliderSkin("Modern"),
  
                textInput(ns("minSlider"), "Rank Min",value = 1, width = "100px"),
                textInput(ns("maxSlider"), "Rank Max",value = 100, width = "100px"),
                sliderInput(ns("rank_range"), 
                            label = "Rank Range:",
                            min = 1, max = nrow(gameList),
                            value = c(1,100),
                            step = 1,
                            animate =  animationOptions(interval = 1000, loop = T),
                            width = '100%'
                            )
)
  # )                    
  
}

control_mod_server <- function(id){
  
  moduleServer(
    id,
    
    function(input, output, session) {
  
      observeEvent(input$minSlider, {
        updateSliderInput(session, "rank_range", value = c(input$minSlider, input$maxSlider))
      })
      observeEvent(input$maxSlider, {
        updateSliderInput(session, "rank_range", value =  c(input$minSlider, input$maxSlider))
      })
      observeEvent(input$rank_range, {
        updateTextInput(session, "minSlider", value =  input$rank_range[1])
        updateTextInput(session, "maxSlider", value =  input$rank_range[2])
      })
      
      return(
        list(rank_range = reactive(input$rank_range))
      )
    }
    
  )
}