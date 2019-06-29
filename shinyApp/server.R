#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

#setwd("~/Coursera/Dev Data Products/Final Project/EPA_Fuel_Econ")

altFuelVehicles <- read.csv("hybrids-EV.csv")

#EVs <- subset(altFuelVehicles, atvType=="EV")
Hybrids <- subset(altFuelVehicles, atvType=="Hybrid")
PIHybrids <- subset(altFuelVehicles, atvType=="Plug-in Hybrid")

AllEVTypes <- rbind(Hybrids, PIHybrids)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

#    model1 <- lm(AllEVTypes$displ ~ AllEVTypes$comb08, data=AllEVTypes)
    model1 <- lm(displ ~ comb08+atvType, data=AllEVTypes)

    model1pred <- reactive({
        mpgInput <- input$sliderMPG
        hybridInput <- input$hybridType
        predict(model1, newdata=data.frame(comb08=mpgInput, atvType=hybridInput))
    })

    output$plot1 <- renderPlot({

        mpgInput <- input$sliderMPG
        hybridInput <- input$hybridType

        plot(AllEVTypes$comb08, AllEVTypes$displ, xlab = "Miles Per Gallon",
             ylab = "Displacement", bty = "n", pch = 16,
             xlim = c(10,60), ylim = c(0,10))

#        abline(model1, col="green", lwd = 2)

        legend(25,250, "Hybrid Prediction", pch=16,
           col = "green", bty = "n", cex = 1.2)
        points(mpgInput, model1pred(), col = "green", pch = 16, cex = 2)
    })

output$pred1 <- renderText({model1pred()})

})
