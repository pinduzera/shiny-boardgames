library("shinytest")

#shinytest::installDependencies()

recordTest(app = "shiny-boardgames/", save_dir = "test")
