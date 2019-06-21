library(shinydashboard)


dashboardPage(
  # Application title
  dashboardHeader(
    title = "But are we ever going to use this in the real world? 
        An investigation into Math and Science R&D development in various sectors."
  ),
  
  # Sidebar with a slider input for number of bins
  dashboardSidebar(
        
        checkboxGroupInput(
          inputId = "country",
          label = "Select Countries",
          choices = names
        ),
        
        checkboxGroupInput(
          inputId = "data_type",
          label = "Info Type",
          choices = c("Raw values" = "",
                      "Percentages" = "PC")
        )
        
  ),
      
  dashboardBody(
    fluidRow(
        column(
          width = 8,
          htmlOutput("gvisChart")
          ),
        column(
          width = 4,
          selectInput(
            "sector",
            "Select the type of R&D funding",
            c(
              "Choose an Option" = "opt",
              "Value Added" = "VA",
              "Government Budget Allocations for R&D" = "C_",
              "Business Enterprise Expenditure on R&D" = "B_",
              "Gross Domestic Expenditure on R&D" = "G_",
              "Human Resources" = "TP"
            )
          ),
          
          selectizeInput(
            "rnd_type",
            "Related Statistics",
            choices = data$MSTI.Variables
          )
          

    )
  )
)
)