library(shinydashboard)


sidebar = dashboardSidebar(
    
    sidebarMenu(
      
      menuItem("Info", tabName = "splash", icon = icon("dashboard")),
      menuItem("Graphs", tabName = "graph", icon = icon("th"))
      
      ),

        checkboxGroupInput(
          inputId = "country",
          label = "Select Countries",
          choices = names
        ),
        
        checkboxGroupInput(
          inputId = "data_type",
          label = "Info Type",
          choices = c("Raw values",
                      "Percentages")
        )
        
  )
      
body = dashboardBody(tabItems (tabItem(tabName = "info",
                                       h2("Work in progress")),
                               
                               tabItem(tabName = "graph",
                                 htmlOutput("gvisChart"),
                                 
                                 fluidRow(
                                   column(
                                     width = 4,
                                     offset = 2,
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
                                     )
                                   ),
                                   
                                   column(
                                     width = 4,
                                     selectizeInput("rnd_type",
                                                    "Related Statistics",
                                                    choices = data$MSTI.Variables)
                                     
                                     
                                   )
                                   
                                   
                                 )
                               )))


dashboardPage(
  # Application title
  dashboardHeader(
    title = "R&D Returns"
  ),
  sidebar,
  body
)