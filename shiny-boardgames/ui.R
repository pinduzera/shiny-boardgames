#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library("shiny")
library("shinyWidgets")
library("bslib")


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  includeCSS("www/styles.css"),
  
  theme = bs_theme(version = 5, bootswatch = "cerulean", 
                   fg = "black",
                   bg = "#ecedee",
                   primary = "#3f3a60"),

  
  navbarPage(collapsible = TRUE,
             HTML('<a style="text-decoration:none;cursor:default;color:#ff5100;" class="active" href="#">Shiny Boardgames</a>'), id="nav",
             windowTitle = "Mechanics",
             
             tabPanel("Mechanics",
                      
                      sidebarPanel(
                        control_mod_ui("control_module"),
                        width = 12
                      ),
                      br(),
                      sidebarPanel(
                      mechanics_mod_ui("mechanics_module"),
                      width = 12
                      )  
                      )
                      
             )
  )
)  