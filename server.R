server <-function(input, output, session) {
            rescan_datasources <- reactiveTimer(2000, session)
            data_available <- reactivePoll(2000, session, 
                                           checkFunc = function() {
                                               list.files(pattern = "*.rds")
                                           },
                                           valueFunc = function() {
                                               list.files(pattern = "*.rds")
                                           })
            observe({
                updateSelectInput(
                    session,
                    "selected_data",
                    choices = data_available()
                )
            })
            
            
        
            dataset <- reactive({
               readRDS(input$selected_data)
            })
            
            output$run_res <- DT::renderDataTable({
                dataset()
            }, options = list(pageLength=10, lengthMenu = c(10, 30, 50, 100, nrow(dataset()))))
            
            
        }


