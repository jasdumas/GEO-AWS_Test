library(shiny)
library(GEOquery)
library(Biobase)
library(reshape2)
library(survival)
library(affy)
library(limma)


options(shiny.suppressMissingContextError=TRUE)
shinyServer(function(input, output, session){
  
  # Reactive function for getGEO function
  dataInput <- reactive({
    input$go1  # Runs the intial input once the button is pressed from within the reactive statement
    getGEO(GEO = isolate(input$GSE), AnnotGPL=T)}) # isolate() avoids dependency on input$GSE
  
  output$series <- renderPrint ({print(dataInput())})
      
  # Reactive for expression data / transforms matrix GSE output into a data.frame which is necessary for renderDataTable
  expressionInput <- reactive({t(head(as.data.frame(exprs(dataInput()[[1]]))))})
  
  output$exprs <- renderDataTable(expressionInput())
  
                                   
  # Displays the Clinical data
  clinicalInput <- reactive ({as.data.frame(pData(phenoData(dataInput()[[1]])))})
  
  output$data <- renderDataTable(clinicalInput(), 
                                 options = list(paging=F, searchable=T, info=T, 
                                                autowidth=T, scrollX=T, scrollY="400px", scrollCollapse = T)
  
    
   
  
)})
