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
        need(input$sector != "opt", "Please select a data set"),
        need(input$rnd_type %in% data$MSTI.Variables, "")
      )
      
      data %>%
        filter(src == input$sector & MSTI.Variables == input$rnd_type)
      
    })
    
    output$gvisChart = renderGvis({
      
      if (length(input$country) == 0) {
        Line2 <- gvisLineChart(rnd_info(), "YEAR", names[-31],
                              options=list(title=input$rnd_type,
                                          height = 600)
                              )
      } else {
        Line2 <- gvisLineChart(rnd_info(), "YEAR", input$country,
                               options=list(title=input$rnd_type,
                                            height = 600)
                              )
        }
      
      
    })
})
