# ui elements for shiny
ui <- function(input, output, session) {
    library(shiny)
    library(shinydashboard)
    sidebar <- dashboardSidebar(
        sidebarMenu(
            checkboxInput("show_second_table", "show second table", value = FALSE),
            menuItem("Data", tabName = "data", icon = icon("table"), selected=TRUE),
            menuItem("Select data", icon = icon("bar-chart-o"), tabName = "select_data",
                     # Input directly under menuItem
                     selectInput("selected_data", "Select Data",
                                 choices = NULL)
            ),
            conditionalPanel(condition = "input.show_second_table === true",
            menuItem("Select 2nd table data", icon = icon("bar-chart-o"), tabName = "select_data2",
                     # Input directly under menuItem
                     selectInput("selected_data2", "Select 2nd Table Data",
                                 choices = NULL)
            )
            ),
            actionButton("refresh", label = "Refresh Datasets"),
            br(),
            actionButton("delete_rds", label = "Clear Datasets")
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
                    ),
                    #condition must be javascript
                    conditionalPanel(condition = "input.show_second_table === true",
                        fluidRow(width = 12,
                             box(
                             width = NULL, 
                             status = "primary",
                             div(style = 'overflow-x: scroll',
                                 DT::dataTableOutput('run_res2'))
                             )
                    ))
            )
        )
    )        
    dashboardPage(
        dashboardHeader(title = "data viewer dashboard"),
        sidebar,
        body
    )
}
