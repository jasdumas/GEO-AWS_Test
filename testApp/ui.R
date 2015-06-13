library(shiny)
library(DT)
library(shinyBS)


shinyUI(fluidPage(
  titlePanel("Google Summer of Code tests"),
  
  sidebarLayout(
    sidebarPanel(
      h1("Sidebar widgets"),
      helpText("help text: we will display the mtcars dataset and make it editable"), 
      verbatimTextOutput('rows_out'),
      textInput("cars2", "label"),
      uiOutput("testOutput"),
          
      actionButton("TestButton", "Test")
      
                 ), # end of sidebar panel
    mainPanel(
      tabsetPanel(type = "pills", id = "tabs",
      tabPanel("mtcars",
      h2("header: mtcars data"),
      helpText("Subtitle: display a datatable"),
      DT::dataTableOutput("cars")),
      tabPanel("Edited data table",
      hr(),
      actionButton("tabBut", "Edit Table"),
      DT::dataTableOutput("newCar")),
      bsModal("modalExample", "Edit Data Table", "tabBut", size = "small",
              numericInput("column", label ="Choose a column number to edit", value = 5), # potential drop-down with pre-filled column #'s
              textInput("find", label = "Find", value = "virginica"),
              checkboxInput("checkbox", label = "Exact Match", value = FALSE),
              textInput("replace", label = "Replace", value = "Got it"),
              actionButton("Enter", label = "trial")
              )
      ) # end of tabsetPanel
    
      
      
              ) # end of main panel
    
              ) # end of sidebar Layout
  
              )) # end of fluid page
