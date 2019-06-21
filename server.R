#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
  observe({
      
        info_type = data %>%
            filter(src == input$sector) %>%
            select(MSTI.Variables)
        updateSelectizeInput(
            session, "rnd_type",
            choices = info_type,
            selected = info_type[1]
        )
    }) 
    
    
    rnd_info = reactive({
      validate(
        need(input$sector != "opt", "Please select a data set")
      )
      
      validate(
        need(input$rnd_type %in% data$MSTI.Variables, "Please select a data set")
      )
      
      if (length(input$country) == 0) {
          data %>%
              filter(src == input$sector & MSTI.Variables == input$rnd_type) %>%
              group_by(Country)
      } else {
        data %>%
          filter(src == input$sector & MSTI.Variables == input$rnd_type & Country %in% input$country) %>%
          group_by(Country)
      }
    })
    
    output$graph <- renderPlot(
        #see if you can add an option here that displays a default message instead of the error
        #when you have no categories selected. Also try to figure out what this error is.
        rnd_info() %>% 
            ggplot(aes(x = YEAR, y = Value)) +
            geom_line(aes(color = Country), size = 2) + ggtitle(input$rnd_type) +
            theme(legend.position = "bottom") + ylab(label_maker(rnd_info()$Unit, rnd_info()$PowerCode))
    )
    
    output$gvisChart = renderGvis({
      
      Line2 <- gvisLineChart(rnd_info(), "YEAR", "Value",
                             options=list(title=input$rnd_type)
                             )
      
    })
})
