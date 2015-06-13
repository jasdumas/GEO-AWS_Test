options(shiny.deprecation.messages=FALSE)

newIris = iris
newNum = 4

shinyServer(function(input, output, session)
  {

  
  
  
output$cars <- DT::renderDataTable({ (datatable(head(mtcars), rownames = TRUE,  
                                            extensions = 'ColReorder',
                                            options = list(dom = 'Rlfrtip', ajax = list(url = action)),
                                            filter = 'top', 
                                            selection = 'single')) 
})



observe({
  input$TestButton
  h = isolate(input$cars2)
  newNum <- h
  print(newNum)
})



output$testOutput <-renderUI({
  selectInput("select", label = "label-select", choices = newNum)
})

action = dataTableAjax(session, mtcars, rownames = TRUE) # for the row_output as characters
 
  output$rows_out <- renderPrint({
    s = input$cars_row_last_clicked
    if (length(s)) {
      cat('These rows were selected:\n\n')
      cat(s, sep = '\n')
    }
    
  })
  
  output$cars2 <- renderUI({
    selectInput("cars2", "drop-down menu", choices = input$cars_row_last_clicked)
  })

  findStr <- reactive({input$find})       # reactives for textboxes in modal window
  replaceStr <- reactive({input$replace})
  columnNum <- reactive({input$column}) # reactives for numeric input in modal window

  irisTable <- reactive({
    input$Enter
    #input$Enter # submit button, takes action once pressed within reactive function
    cat("in searchModal\n")
        exactMatch = isolate(input$checkbox) # exact match condition
    
        find.str = isolate(findStr())
        column.num = isolate(columnNum())
        replace.str = isolate(replaceStr())
        
    if (exactMatch) {    # while default is false
      find.str = paste("^", find.str, "$", sep = "")
    }
    
  #  newIris = iris
    ### if factor, change to character.  Otherwise we can't replace it. ##
    if (is.factor(newIris[,column.num])) {
      newIris[,column.num] = as.character(newIris[,column.num])
    }
    
    g = grep(find.str, newIris[,column.num])
    cat("g = ", g, "\n")
    newIris[g,column.num] = replace.str 
    cat("replacing ", find.str, "with ", replace.str)
    return(newIris)
    })

  output$newCar2 <- DT::renderDataTable({(datatable(searchModal(), rownames = TRUE,  
                                                   extensions = 'ColReorder',
                                                   filter = 'top', 
                                                   selection = 'single')) 
  })
    
  observe({
    output$newCar <- DT::renderDataTable({(datatable(irisTable(), rownames = TRUE,  
                                                     extensions = 'ColReorder',
                                                     filter = 'top', 
                                                     selection = 'single'))
    })
  })
  
###### as.data.frame(grep(pattern = input$find, x = mtcars, value = T)), rownames = T
  
  

  observe({if(!is.na(input$find)) print(input$find) })
  
  
}) # end tag
