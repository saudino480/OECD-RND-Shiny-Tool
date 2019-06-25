library(shinydashboard)


sidebar = dashboardSidebar(
  sidebarMenu(
    menuItem("Welcome", tabName = "splash", icon = icon("dashboard")),
    menuItem("Graphs", tabName = "graph", icon = icon("th")),
    menuItem("About", tabName = "about", icon = icon("person"))
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
      "Higher education Expenditure on R&D" = "H_",
      "Government Intramural Expenditure on R&D" = "GV_",
      "Trade Balance" = "TD_",
      "Human Resources" = ".H_"
    )
  ),
  
  selectizeInput("rnd_type",
                 "Related Statistics",
                 choices = data$MSTI.Variables),
  
  
  checkboxGroupInput(
    inputId = "data_type",
    label = "Info Type",
    choices = c("Raw values",
                "Percentages")
  ),
  
  checkboxGroupInput(
    inputId = "country",
    label = "Select Countries",
    choices = names
  )
  
)


body = dashboardBody(tabItems (
  tabItem(tabName = "splash",
          HTML('<center><img src="OECD_logo.png" width = "600px"></center>'),
          br(),
          fluidRow(
            column(width = 6,
                   offset = 3,
          h4("This data set before you comes from the Organization for Economic Co-Operation and Development
              (known as the OECD), which is an intergovernmental economic organization with 36 member countries.
              We will not be viewing all of these countries here, for the sake of clarity in the graphs. The
              OECD collect data on markets around the world, along with providing a space for the dialogue between
              policy makers for the betterment of the market. This particular data set is the Main Science and
              Technology Indicators, which contains plenty of data on how markets in the various countries
              have responded to investment into Research and Development (R&D) fields, whether the money has come
              from businesses, governments, or elsewhere."#, align = "center"
             ),

          h4("A brief summary of the terms you will use to sort through the data. A main indicator of the sum
              total of national R&D efforts is the Gross Domestic Expenditure on Research and Experimental
              Development (GERD), which captures all spending on R&D carried out within any given economic year.
              The role businesses have to play in R&D performance is known as Business enterprise Expenditure
              on R&D (BERD). Unfortunately, due to the extensiveness of this field, most reporting is based on
              retrospective surveys. Data pertaining to Government Budget Allocations for R&D (GBARD) highlights
              different countries priorities when it comes to specific sectors of the market. These are broken
              down by those fields. A total look at value added to the market independently, and as a factor of
              each countries' GDP, can be found under the Value Added tab. Lastly, we have Human Resources, which
              has collected data about researchers working in the field. It includes data pertaining to gender
              equality, total share of jobs in the economy, and others."#, align = "center"
             ),

          h4("This visualization hopes to allow you to look through this data and lead you to find out how relevant
              factors influence each countries' decision making pertaining to R&D."#,
                     #align = "center"
                   )))),
  
  tabItem(tabName = "graph",
          fluidPage(
            tabBox(
              title = "",
              # The id lets us use input$tabset1 on the server to find the current tab
              id = "tabset1",
              height = "80%",
              width = "100%",
              tabPanel("Graph", htmlOutput("gvisChart")),
              tabPanel("Table", htmlOutput("gvisTable")),
              tabPanel("Meta Information", htmlOutput("gvisMetaTable"))
            ),
            
            br(),
            
            
            fluidRow(
                     infoBoxOutput("maxPC"),
              
                     infoBoxOutput("minPC")
            ),
            fluidRow(
                     infoBoxOutput("rawMax"),
    
                     infoBoxOutput("rawMin")
              
            )
          )),
  
  tabItem(tabName = "about",
          fluidPage(
            column(width = 4,
                   offset = 1,
                   HTML('<center><img src="author_photo.jpg" width = "200px"></center>'),
                   h5("Sam Audino is a non-binary data scientist who is currently studying at the 
                      NYC Data Science Academy. They enjoy making art, bags, and anything else that
                      catches their eye. You can find them on LinkedIn via the link below, or follow
                      their creative work on instagram."),
                   uiOutput("linkedin"),
                   uiOutput("insta")
            ),
          
            column(width = 4,
                   offset = 2,
                   HTML('<center><img src="OECD_small.jpg" width = "160px"></center>'),
                   h5("The Organization for Economic Co-Operation and Development (known as the OECD), 
                       is an intergovernmental economic organization with 36 member countries. They 
                      conduct research on various market factors, and make that information usable to
                      the public at large for the betterment of us all. You can find a link to their 
                      webpage below, as well as a link to the original data set used to build this 
                      Shiny visualization project."),
                   uiOutput("OECD"),
                   uiOutput("OECDDATA")
                   )          
          )
)))


dashboardPage(
  # Application title
  dashboardHeader(
    title = "R&D Spending"
  ),
  sidebar,
  body
)