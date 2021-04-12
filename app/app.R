library(shiny)
library(ggplot2)
library(shinythemes)
library(tidyverse)

water <- read_csv("../app/data/tidy_water.csv", col_types = cols(region = col_factor()))
map_water <- read_csv("../app/data/map_water.csv", col_types = cols(epa_region = col_factor()))
quasi.water2 <- glm(num_violations ~ num_facilities + num_site_visits + source + region, data = water, family = quasipoisson(link = "log"))

ui <- navbarPage("Analysis of EPA Drinking Water Reports", theme = shinytheme("flatly"),
                 tabPanel("Univariate Analysis",         
                          sidebarLayout(
                            sidebarPanel(
                              selectInput(inputId = "var0", 
                                          label = "Variable 1",
                                          choices = names(water[, !names(water) %in% c("ID", "name")] )),
                              sliderInput(inputId = "bins",
                                          label = "Number of Bins:",
                                          min = 1,
                                          max = 100,
                                          value = 50),
                              checkboxInput(inputId = "log0",
                                            label = "Log")),
                            mainPanel = mainPanel(plotOutput("plot0"))
                          ), 
                 ),
                 
      tabPanel("Bivariate Analysis",         
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = "var1", 
                               label = "Variable 1",
                               choices = names(water[, !names(water) %in% c("ID", "name")] )),
                   checkboxInput(inputId = "log1",
                                 label = "Log"),
                   selectInput(inputId = "var2",
                               label = "Variable 2",
                               choices = names(water[, !names(water) %in% c("ID", "name")])),
                   checkboxInput(inputId = "log2",
                                 label = "Log")),
                 mainPanel = mainPanel(plotOutput("plot1"))
               ), 
      ),
      
      tabPanel(title = "Map",
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = "var3", 
                               label = "Variable 1",
                               choices = names(map_water[, names(map_water) %in% c("median_violations", "median_population", "median_facilities", "median_visits", "violations_per_person", "violations_per_facilities")]),
                  )
                 ),
                 mainPanel = mainPanel(plotOutput("plot2"),
                                       dataTableOutput("plot4"))
               )
      ),
      tabPanel(title = "Prediction",
               sidebarLayout(
                 sidebarPanel(
                   sliderInput(inputId = "site_visits",
                               label = "Number of Site Visits",
                               min = 0,
                               max = 750,
                               value = 100),
                   sliderInput(inputId = "facilities",
                               label = "Number of Facilities",
                               min = 1,
                               max = 1200,
                               value = 5),
                   selectInput(inputId = "region",
                               label = "EPA Region",
                               choice = sort(unique(water$region))),
                   selectInput(inputId = "source",
                               label = "Water Source",
                               choice = unique(water$source)),
                   tableOutput("prediction")
                 
                 ),
                 mainPanel(plotOutput("plot5"),
                          verbatimTextOutput("summary"))
                )
      ),
      
      tabPanel(title = "Spreadsheet",
               dataTableOutput("plot3")
      )
 )

  

server <- function(input, output, session) {
  
  
  output$plot0 <- renderPlot({
    if(is.numeric(water[[input$var0]]) & input$log0 == TRUE){
      ggplot(water, aes(x = log(.data[[input$var0]] + 1))) +
        geom_histogram(bins = input$bins, fill = "lightblue", color = "black") +
        theme_bw()
    } else if(is.numeric(water[[input$var0]])){
      ggplot(water, aes(x = .data[[input$var0]])) +
        geom_histogram(bins = input$bins, fill = "lightblue", color = "black") +
        theme_bw()
    } else {
      ggplot(water, aes(x = .data[[input$var0]])) +
        geom_bar(fill = "lightblue", color = "black") +
        coord_flip()+
        theme_bw()
    }
  })
  
  
  output$plot1 <- renderPlot({
    
    
    if (is.numeric(water[[input$var1]]) & is.numeric(water[[input$var2]]) & input$log1 == TRUE & input$log2 == TRUE) {
      ggplot(water, aes(x = log(.data[[input$var1]] + 1), y = log(.data[[input$var2]]+ 1))) +
        geom_point() +
        theme_bw() 
      
    } else if (is.numeric(water[[input$var1]]) & is.numeric(water[[input$var2]]) & input$log1 == FALSE & input$log2 == TRUE) {
      ggplot(water, aes(x = .data[[input$var1]], y = log(.data[[input$var2]]+ 1))) +
        geom_point() +
        theme_bw() 
  
    } else if (is.numeric(water[[input$var1]]) & is.numeric(water[[input$var2]]) & input$log1 == TRUE & input$log2 == FALSE) {
      ggplot(water, aes(x = log(.data[[input$var1]] + 1), y = .data[[input$var2]])) +
        geom_point() +
        theme_bw() 
      
    } else if (is.numeric(water[[input$var1]]) & is.numeric(water[[input$var2]]) & input$log1 == FALSE & input$log2 == FALSE) {
      ggplot(water, aes(x = .data[[input$var1]], y = .data[[input$var2]])) +
        geom_point() +
        theme_bw() 
      
    } else if (is.numeric(water[[input$var1]]) == TRUE & is.numeric(water[[input$var2]]) == FALSE & input$log1 == TRUE) {
      ggplot(water, aes(x = log(.data[[input$var1]] + 1), y = .data[[input$var2]])) +
        geom_boxplot() + 
        theme_bw()
      
     } else if (is.numeric(water[[input$var1]]) == TRUE & is.numeric(water[[input$var2]]) == FALSE) {
        ggplot(water, aes(x = .data[[input$var1]], y = .data[[input$var2]])) +
          geom_boxplot() + 
          theme_bw()
        
    } else if (is.numeric(water[[input$var1]]) == FALSE & is.numeric(water[[input$var2]]) == TRUE & input$log2 == TRUE) {
      ggplot(water, aes(x = .data[[input$var1]], y = log(.data[[input$var2]] + 1))) +
        geom_boxplot() + 
        theme_bw()
      
    } else if (is.numeric(water[[input$var1]]) == FALSE & is.numeric(water[[input$var2]]) == TRUE) {
      ggplot(water, aes(x = .data[[input$var1]], y = .data[[input$var2]])) +
        geom_boxplot() + 
        theme_bw()
      
    } else if (is.numeric(water[[input$var1]]) == FALSE & is.numeric(water[[input$var2]]) == FALSE) {
      ggplot(water, aes(x = .data[[input$var1]], y = .data[[input$var2]])) +
        geom_jitter() + 
        theme_bw()
    }
    
  })
  
  output$plot2 <- renderPlot({
    map_water%>%
      ggplot()+
      geom_polygon(aes(x = long, y = lat, fill = .data[[input$var3]], group = group), color = "white")+
      coord_fixed(1.3)+
      theme_bw()+
      xlab("")+
      ylab("")+
      ggtitle(c("US States"))
  })
  
  output$plot3 <- renderDataTable({
    water 
  })
  
  output$plot4 <- renderDataTable({
    map_water%>%
      select(region, .data[[input$var3]])%>%
      group_by(region)%>%
      summarize(median = median(.data[[input$var3]]))
  })
  
  output$plot5 <- renderPlot({
    map_water%>%
      ggplot()+
      geom_polygon(aes(x = long, y = lat, fill = epa_region, group = group), color = "white")+
      coord_fixed(1.3)+
      theme_bw()+
      xlab("")+
      ylab("")+
      ggtitle(c("EPA Region"))
  })
  
  
  output$summary <- renderPrint({
    summary(quasi.water2)
    })
 
  output$prediction <- renderTable({
    data.frame(predict.glm(quasi.water2, newdata = data.frame(num_site_visits = input$site_visits,
                                                   num_facilities = input$facilities,
                                                   region = input$region,
                                                   source = input$source),
                type = "response",
                se.fit = TRUE)) %>%
      rename(Fit = fit,
             SE.Fit = se.fit,
             Residual.Scale = residual.scale)
  })
  
}

shinyApp(ui, server)
