
source("loading.R")
source("tab_design.R")

options(shiny.maxRequestSize = 100 * 1024 ^ 2)
options(spinner.color = "#3182bd")
options(spinner.type = 8)

# user interface
ui <- navbarPage(
    
    theme = shinytheme("yeti"),
    title = "Genomic Data Explorer",
    id = "tabs",
    
    tab_scrna,
    tab_about,
    
    tags$head(tags$link(rel="stylesheet", 
                        type="text/css", 
                        href="style.css"))
)

# server function
server <- function(input, output, session) {
    
    # RNA
    
    observeEvent(input$scrna_start, {
        
        library(Scillus)
        
        scrna_input <- if(input$data_source == "Example") {
            reactive({readRDS("./large_data/scRNA_sample.rds")})
        } else if (input$data_source == "Upload"){
            reactive({
                validate(
                    need(input$scrna_input, 
                         "Please Upload Data")
                )
                readRDS(input$scrna_input$datapath)})
        } else {
            reactive({
                readRDS(paste0("./large_data/",input$scrna_select))})
        }
        
        scrna_plot_height <- reactive({
            validate(
                need(input$scrna_plot_height < 4000, "Plot height shouldn't exceed 4000px.")
            )
            return(input$scrna_plot_height)
        })
        
        scrna_plot_width <- reactive({
            validate(
                need(input$scrna_plot_width < 4000, "Plot width shouldn't exceed 4000px.")
            )
            return(input$scrna_plot_width)
        })
        
        output$scrna_dim_red <- renderPlot({
            plot_scdata(scrna_input())
        }, 
        height = scrna_plot_height, 
        width = scrna_plot_width)
        
        output$scrna_stat <- renderPlot({
            plot_stat(scrna_input(), plot_type = "prop_fill")
        }, 
        height = scrna_plot_height, 
        width = scrna_plot_width)
        
        output$scrna_mea_box <- renderPlot({
            plot_measure(scrna_input(), 
                         measures = c("nFeature_RNA","nCount_RNA","percent.mt","KRT14"), 
                         group_by = "seurat_clusters")
        }, 
        height = scrna_plot_height, 
        width = scrna_plot_width)
        
        output$scrna_mea_dim <- renderPlot({
            plot_measure_dim(scrna_input(), 
                             measures = c("nFeature_RNA","nCount_RNA","percent.mt","KRT14"))
        }, 
        height = scrna_plot_height, 
        width = scrna_plot_width)
    })
    
}

shinyApp(ui = ui, server = server)
