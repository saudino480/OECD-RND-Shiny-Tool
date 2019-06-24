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
                     "Percentages" = pc_types)
      
      info_type = data %>%
        filter_by_pattern("MSTI_VAR", input$sector) %>%
        select(MSTI.Variables, Unit) %>%
        filter(Unit %in% temp) %>%
        select(MSTI.Variables)
      
    } else {
      info_type = data %>%
        filter_by_pattern("MSTI_VAR", input$sector) %>%
        select(MSTI.Variables)
    }
    
    
    updateSelectizeInput(session,
                         "rnd_type",
                         choices = info_type,
                         selected = info_type[[1]])
    
  })
  
  
  rnd_info = reactive({
    validate(
      need(input$sector != "opt", "Please select a data set"),
      need(input$rnd_type %in% data$MSTI.Variables, "")
    )
    if (length(input$country) == 0) {
      data %>%
        filter_by_pattern("MSTI_VAR", input$sector) %>%
        filter(MSTI.Variables == input$rnd_type)
    } else {
      data %>%
        filter_by_pattern("MSTI_VAR", input$sector) %>%
        filter(MSTI.Variables == input$rnd_type) %>%
        select(data_labels, input$country)
    }
  })
  
  meta_info = reactive({
    validate(need(input$rnd_type %in% data$MSTI.Variables, ""))
    
    temp_countries = colnames(rnd_info())[!(colnames(rnd_info()) %in% data_labels)]
    
    max_raw_df = rnd_info() %>%
      group_by(MSTI_VAR) %>%
      summarise_at(temp_countries, max, na.rm=TRUE)
    
    min_raw_df = rnd_info() %>%
      group_by(MSTI_VAR) %>%
      summarise_at(temp_countries, min, na.rm=TRUE)
    
    pc_df = rnd_info() %>%
      group_by(MSTI_VAR) %>%
      summarise_at(temp_countries, netPercent) %>%
      select_if(~ !any(is.na(.)))
    
    pc_countries = colnames(pc_df)[2:length(colnames(pc_df))]
    
    #### raw values ####
    max_raw_value = max_raw_df %>%
      maxColValue(temp_countries) %>%
      unlist()
      
    max_raw_name = max_raw_df %>%
      maxColName(temp_countries) %>%
      unlist()
    
    max_raw_year = rnd_info() %>%
      filter_at(vars(temp_countries), any_vars(. %in% max_raw_value)) %>%
      select(YEAR) %>%
      unlist()
    
    min_raw_value = min_raw_df %>%
      minColValue(temp_countries) %>%
      unlist()
      
    min_raw_name = min_raw_df %>%
      minColName(temp_countries) %>%
      unlist()
    
    min_raw_year = rnd_info() %>%
      filter_at(vars(temp_countries), any_vars(. %in% min_raw_value)) %>%
      select(YEAR) %>%
      unlist()
    
    raw_info = data.frame(type = c("Max_Raw", "Min_Raw"),
                          name = c(max_raw_name, min_raw_name),
                          value = c(max_raw_value, min_raw_value),
                          year = c(max_raw_year, min_raw_year))
    
    #### pc values #####
    max_pc_value = pc_df %>%
      maxColValue(pc_countries) %>%
      unlist()
    
    max_pc_name = pc_df %>%
      maxColName(pc_countries) %>%
      unlist()
    
    min_pc_value = pc_df %>%
      minColValue(pc_countries) %>%
      unlist()
    
    min_pc_name = pc_df %>%
      minColName(pc_countries) %>%
      unlist()
    
    pc_info = data.frame(type = c("Max_PC", "Min_PC"),
                         name = c(max_pc_name, min_pc_name),
                         value = c(max_pc_value, min_pc_value),
                         year = c(0, 0))
    
    meta = return(rbind(raw_info, pc_info))
    
  })
  
  
  output$gvisTable = renderGvis({
    gvisTable(rnd_info())
  })
  
  output$gvisMetaTable = renderGvis({
    gvisTable(meta_info())
  })
  
  output$gvisChart = renderGvis({
    validate(need(input$rnd_type %in% data$MSTI.Variables, ""))
    ylabel = gvisLabelMaker(rnd_info()$Unit, rnd_info()$PowerCode)
    
    if (length(input$country) == 0) {
      graph = gvisLineChart(
        rnd_info(),
        "YEAR",
        names,
        options = list(
          title = input$rnd_type,
          vAxes = ylabel[1],
          hAxes = "[{title:'Year'}]",
          height = 600
        )
      )
    } else {
      graph = gvisLineChart(
        rnd_info(),
        "YEAR",
        input$country,
        options = list(
          title = input$rnd_type,
          vAxes = ylabel[1],
          hAxes = "[{title:'Year'}]",
          height = 600
        )
      )
    }
    
  })
  
  url_insta = a("Instagram", href = "https://www.instagram.com/s.audino/")
  
  output$insta = renderUI({
    tagList(url_insta)
  })
  
  url_linked = a("LinkedIn", href = "https://www.linkedin.com/in/sam-audino-5b6540184/")
  
  output$linkedin = renderUI({
    tagList(url_linked)
  })
  
  url_oecd = a("OECD's Official Website", href = "http://www.oecd.org/")
  
  output$OECD = renderUI({
    tagList(url_oecd)
  })
  
  url_data = a("Main Science and Technology Indicators", href = "https://stats.oecd.org/Index.aspx?DataSetCode=MSTI_PUB")
  
  output$OECDDATA = renderUI({
    tagList(url_data)
  })
  
  output$maxPC <- renderInfoBox({
    #validate(need(meta_info() != ""))
    
    infoBox(
        paste("Highest Growth:", meta_info()$name[3]),
        paste0(round(meta_info()$value[3], 4), "%"),
        icon = icon("list"),
        color = "green",
        fill = TRUE
        )
  })
  
  output$minPC <- renderInfoBox({
    
    #validate(need(meta_info() != ""))
    
    
    infoBox(
      paste("Highest Loss:", meta_info()$name[4]),
      paste0(round(meta_info()$value[4], 4), "%"),
      icon = icon("thumbs-down", lib = "glyphicon"),
      color = "red",
      fill = TRUE
    )
  })
  
  output$rawMax <- renderInfoBox({
    
    #validate(need(meta_info() != ""))
    
    
    infoBox(
      paste("Highest Value:", meta_info()$name[1]),
      subtitle = paste("Year", meta_info()$year[1]),
      paste(round(meta_info()$value[1], 4), "(", label_maker(rnd_info()$Unit, rnd_info()$PowerCode), ")"),
      icon = icon("thumbs-up", lib = "glyphicon"),
      color = "green",
      fill = TRUE
    )
  })
  
  output$rawMin <- renderInfoBox({
    
    #validate(need(meta_info() != ""))
    
    
    infoBox(
      paste("Lowest Value:", meta_info()$name[2]),
      subtitle = paste("Year", meta_info()$year[2]),
      paste(round(meta_info()$value[2], 4), label_maker(rnd_info()$Unit, rnd_info()$PowerCode)),
      icon = icon("thumbs-down", lib = "glyphicon"),
      color = "red",
      fill = TRUE
    )
  })
})
