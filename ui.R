library(markdown)

shinyUI(navbarPage("Navbar!",
                   tabPanel("Instructions",
                            fluidRow(
                              column(6,includeMarkdown("instructions.md")
                              )
                              )
                            
                   ),
                   tabPanel("Document",
                            fluidRow(
                              column(6,includeMarkdown("document.md")
                              )
                            )
                            
                   ),
                   tabPanel("Plot",
                            sidebarLayout(
                              sidebarPanel(
                                h3('Select features for building classification algorithm'),
                              
                                checkboxGroupInput("cb","Checkbox",
                                                   c("Age"="age",
                                                     "Gender"="gender",
                                                     "Control"="control"),
                                                   selected=c("age","gender","control"))
                              ),
                              mainPanel(
                                h3('Results of prediction'),
                                h4('You selected'),
                                #verbatimTextOutput("inputValue"),
                                verbatimTextOutput("cbvalue"),
                                h4('Test set'),
                                verbatimTextOutput("test"),
                                h4('Model'),
                                verbatimTextOutput("model"),
                                h4('Which resulted in a MSE(Mean square error) '),
                                verbatimTextOutput("mse")
                              )
                            )
                   )
))