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
      
    
        if (length(input$data_type) == 1) {
          temp = switch (input$data_type,
              "Raw values" = raw_types,
              "Percentages" = pc_types
            )
          
          info_type = data %>%
            filter(src == input$sector) %>%
            select(MSTI.Variables, Unit) %>%
            filter(Unit %in% temp) %>%
            select(MSTI.Variables)
          
        } else {
          info_type = data %>%
            filter(src == input$sector) %>%
            select(MSTI.Variables)
        }
        
        
        updateSelectizeInput(
            session, "rnd_type",
            choices = info_type,
            selected = ""
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
      validate(
        need(input$rnd_type %in% data$MSTI.Variables, "")
      )
      ylabel = gvisLabelMaker(rnd_info()$label)
      
      if (length(input$country) == 0) {
        graph = gvisLineChart(rnd_info(), "YEAR", names,
                              options=list(title=input$rnd_type,
                                           vAxes=ylabel[1],
                                           hAxes="[{title:'Year'}]",
                                           height = 600)
                              )
      } else {
        graph = gvisLineChart(rnd_info(), "YEAR", input$country,
                               options=list(title=input$rnd_type,
                                            vAxes=ylabel[1],
                                            height = 600)
                              )
        }
      
    })
    
    
})
