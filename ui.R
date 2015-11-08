# ui elements for shiny
ui <- function(input, output, session) {
    library(shinydashboard)
    sidebar <- dashboardSidebar(
        sidebarMenu(
            menuItem("Data", tabName = "data", icon = icon("table"), selected=TRUE),
            menuItem("Select data", icon = icon("bar-chart-o"), tabName = "select_data",
                     # Input directly under menuItem
                     selectInput("selected_data", "Select Data",
                                 choices = NULL)
            )
        )
    )
    body <- dashboardBody(
        tabItems(
            tabItem(tabName = "data",
                    fluidRow(width = 12,
                             box(
                             width = NULL, 
                             status = "primary",
                             div(style = 'overflow-x: scroll',
                                 DT::dataTableOutput('run_res'))
                             )
                    )
            )
        )
    )        
    dashboardPage(
        dashboardHeader(title = "data viewer dashboard"),
        sidebar,
        body
    )
}
