library(shinydashboard)


sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Welcome", tabName = "splash", icon = icon("dashboard")),
    menuItem("Graphs", tabName = "graph", icon = icon("th")),
    menuItem("Data Table", tabName = "data", icon = icon("data"))
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
  ),
  
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
  
  selectizeInput("rnd_type",
                 "Related Statistics",
                 choices = data$MSTI.Variables)
  
)


body = dashboardBody(tabItems (
  tabItem(tabName = "splash",
          "Work in progress"),
  
  tabItem(tabName = "graph",
          fluidPage(
            tabBox(
              title = "First tabBox",
              # The id lets us use input$tabset1 on the server to find the current tab
              id = "tabset1",
              height = "80%",
              width = "100%",
              tabPanel("Graph", htmlOutput("gvisChart")),
              tabPanel("Table", htmlOutput("gvisTable"))
            ),
            
            hr(),
            
            #### placeholder -- pick up here ####
            fluidRow(
              infoBox(
                "New Orders",
                10 * 2,
                icon = icon("credit-card"),
                fill = TRUE
              ),
              infoBoxOutput("progressBox2"),
              infoBoxOutput("approvalBox2")
            )
          ))
))


dashboardPage(
  # Application title
  dashboardHeader(
    title = "R&D Returns"
  ),
  sidebar,
  body
)