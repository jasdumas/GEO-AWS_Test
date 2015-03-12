library(shiny)
library(GEOquery)
library(Biobase)
library(reshape2)
library(survival)
library(affy)
library(limma)


shinyUI(fluidPage(
  titlePanel("GEO analysis with Shiny"),
    sidebarLayout(
    sidebarPanel(
          
# entering the GEO number to start the entire process
      textInput("GSE", "GEO Accession Number", "GSE13"),
      actionButton("go1", "Get Gene Series"),
      hr(),
# Platform numerical input box
      numericInput("platform", value = 1, label = "Platform")   
      
                ),
                
    
  mainPanel(tabsetPanel(type = "tabs", 
                
                tabPanel("Gene Series", verbatimTextOutput("series")), 
                tabPanel("Expression Data", dataTableOutput("exprs")),
                tabPanel("Phenotypic Data", dataTableOutput("data"))
                
                )
      
      
    ))
  )
)