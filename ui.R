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
          choices = unique(data$Country)
        ),
        
        checkboxGroupInput(
          inputId = "data_type",
          label = "Info Type",
          choices = c("Raw values" = "raw",
                      "Percentages" = "PC")
        )
        
  ),
      
  dashboardBody(
        plotOutput("graph"),
        htmlOutput("gvisChart"),
  
  fluidRow(
    column(
      width = 4, offset = 2,
      selectInput(
        "sector",
        "Select the type of R&D funding",
        c(
          "Choose an Option" = "opt",
          "Value Added" = "VA",
          "Government Budget Allocations for R&D" = "C_",
          "Business Enterprise Expenditure on R&D" = "B_",
          "Gross Domestic Expenditure on R&D" = "G_"
        )
      )
    ),
    column(
      width = 4,
      selectizeInput(
        "rnd_type",
        "Related Statistics",
        choices = data$MSTI.Variables
      )
    )
  )
)
)