library(dplyr)
server <-function(input, output, session) {
            data_available <- reactivePoll(2000, session, 
                                           checkFunc = function() {
                                               file.info(list.files(pattern = "*.rds")) %>%
                                                   select(-atime)
                                           },
                                           valueFunc = function() {
                                               file.info(list.files(pattern = "*.rds"))
                                           })
            observe({
                files <- data_available()
                most_recent <- row.names(files[order(files$mtime, decreasing = TRUE),])[1]  
                updateSelectInput(
                    session,
                    "selected_data",
                    choices = row.names(files),
                    selected = most_recent
                )
            })
            
            
        
            dataset <- reactive({
               readRDS(input$selected_data)
            })
            
            output$run_res <- DT::renderDataTable({
                dataset()
            }, options = list(pageLength=10, lengthMenu = c(10, 30, 50, 100, nrow(dataset()))))
            
            
        }


