#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# Dataset is from https://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip
# Documentation on Dataset:  https://www.fueleconomy.gov/feg/ws/index.shtml#vehicle

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Predict Vehicle Class by Alternative Fuel Type and MPG"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderMPG", "What is the target MPG of the Hybrid type?",
                   min = 1, max = 60, value = 35),
       selectInput("hybridType","What type of hybrid/EV are you interested in?",
                   c("Hybrid","Plug-in Hybrid"), multiple=FALSE,
                   selected="Hybrid"),
       submitButton("Submit")
       ),

    # Show a plot of the generated distribution
    mainPanel(
        p("The purpose of this Shiny app is to display a prediction of the engine
          displacement for hybrid vehicles based on gas mileage and type of
          hybrid (regular hybrid, or plug-in hybrid)."),
        p("In order to use this app:"),
        p("1 - Please slide the slider to your gas mileag
          target.  Then use the pulldown to select either Hybrid or Plug-in
          Hybrid, then click the submit button"),
        p("2 - Then use the pulldown to select either Hybrid or Plug-in
          Hybrid."),
        p("3 - Click the Submit Button"),
        plotOutput("plot1"),
       h3("Predicted vehicle displacement: "),
       textOutput("pred1")
    )
  )
))
