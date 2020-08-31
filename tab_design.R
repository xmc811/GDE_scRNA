
select_path <- "./data/"

tab_scrna <- tabPanel(
    
    title = "scRNA-seq",
    fluid = TRUE,
    value = "v_scrna",
    
    sidebarLayout(
        
        sidebarPanel = sidebarPanel(
            
            uiOutput("upload_panel"),
            
            conditionalPanel(
                condition = "input.data_source == 'Upload'",
                fileInput(inputId = "scrna_upload",
                          label = "Upload local Seurat objects",
                          buttonLabel = "Browse..")
            ),
            
            conditionalPanel(
                condition = "input.data_source == 'Select'",
                selectInput(inputId = "scrna_select", 
                            label = "Select Seurat objects from path",
                            choices = list.files(select_path))
            ),
            br(),
            
            conditionalPanel(
                condition = "input.scrna_panel != 1",
                uiOutput("plot_size")
            ),
            
            tags$head(tags$style(HTML("
                              .shiny-split-layout > div {
                                overflow: visible;
                              }
                              .progress-bar {
                              height: 20px;
                              }
                              .shiny-notification {
                              width: 200px;
                              top: 50%;
                              right: 30%;
                              position: fixed;
                              }
                              ")))
        ),
        
        mainPanel(
            tabsetPanel(
                id = "scrna_panel",
                tabPanel(
                    value = 1,
                    title = "Information",
                    br(),
                    verbatimTextOutput("object_info"),
                ),
                tabPanel(
                    value = 2,
                    title = "Dimension Reduction",
                    br(),
                    plotOutput("scrna_dim_red")
                ),
                tabPanel(
                    value = 3,
                    title = "Statistics",
                    br(),
                    plotOutput("scrna_stat", width = "100%") 
                ),
                tabPanel(
                    value = 4,
                    title = "Measures - Boxplot",
                    br(),
                    plotOutput("scrna_mea_box")
                ),
                tabPanel(
                    value = 5,
                    title = "Measures - Dim",
                    br(),
                    plotOutput("scrna_mea_dim")
                ),
                tabPanel(
                    value = 6,
                    title = "Heatmap",
                    br(),
                    plotOutput("scrna_hm", width = "100%") 
                ),
                tabPanel(
                    value = 7,
                    title = "GO Analysis",
                    br(),
                    plotOutput("scrna_go")
                )
            )
        )
    )
)



tab_about <- tabPanel(
    
    title = "About",
    fluid = TRUE,
    value = "v_about",
    
    sidebarLayout(
        
        sidebarPanel = sidebarPanel(
            
            
            
        ),
        
        mainPanel(
            br(),
            h4("Authors:"),
            br(),
            h4("Mingchu Xu"),
            br(),
            h4("Xiaogang (Sean) Wu"),
            br(),
            h4("Jianhua (John) Zhang")
        )
    )
    
)