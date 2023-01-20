#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library("shiny")
library("bslib")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  
  theme = bs_theme(version = 5, bootswatch = "cerulean"),

  
  navbarPage(collapsible = TRUE,
             HTML('<a style="text-decoration:none;cursor:default;color:#9cff9c;" class="active" href="#">Shiny Boardgames</a>'), id="nav",
             windowTitle = "Mechanics",
             
             tabPanel("Mechanics",

                      control_mod_ui("control_module"),
                      
                      mechanics_mod_ui("mechanics_module")
                          
                      )
                      
             )
  )
)  