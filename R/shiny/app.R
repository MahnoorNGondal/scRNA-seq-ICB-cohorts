
library(shiny)
library(ggplot2)
library(shinythemes)
library(arrow)
library(shinyFiles)
library(ggpubr)
library(rsconnect)
library(googledrive)


## download from googledrive
drive_deauth()
drive_user()
public_file <-  drive_get(as_id("1zoe9lLo_2zStb4MHVOzZRbeYXiAnSZuO"))
drive_download(public_file, overwrite = TRUE)

Yost_BCC <- data.table::fread("Yost_BCC_data.csv")
gene_names <- colnames(Yost_BCC[,c(198:38403)])

ui <- fluidPage( theme = shinytheme("cerulean"),
                 titlePanel("Single-cell ICB cohort"),
                 sidebarLayout(
                   sidebarPanel(
                     selectInput(inputId = "selected_df", label = "Select a sc-ICB Study", choices = c("Bassez_TNBC", 
                                                                                     "Bassez_HER2",
                                                                                     "Bassez_ER",
                                                                                     "Alvarez_Breckenridge",
                                                                                     "Bi_ccRCC",
                                                                                     "Jerby_Arnon_Mel",
                                                                                     "Ma_HCC",
                                                                                     "Ma_iCCA",
                                                                                     "Pozniak_Mel",
                                                                                     "Tirosh_Mel",
                                                                                     "Yost_BCC")),
                     selectInput( inputId = "gene", label = "Select a gene", choices = c(gene_names)),
                   ),
                   mainPanel(
                     plotOutput("selected_plot")
                   )
                 )
)

server <- function(input, output) {
  
  ## download from googledrive
  drive_deauth()
  drive_user()
  public_file <-  drive_get(as_id("1yITgWpqNp7rQOYvT_XM2LeHmEdK3EldJ"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("11CiJbQBpG8OE52JWtdHV-FKKcT-99ouw"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1Bh0LuY8qY7O1gyGVZo7hnWNVfDBQv4CW"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1MtAYrqcOqeOHQTnDkwuuVXDbnMSufWE5"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1RZ1AEyovLHKB_Shrm_h_70_U2qTnlxF6"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1Atg6Jip0crmBbo3UgDYw9PiosM1d_Dzf"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1bj5b0LRyP81Hjl_YMgq0FSEFbIUt63tG"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1jhAOqOimY8ALi4mcVc-90tlXmJM3vFyu"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1wa90PiYxbagTab0g0eeMecqYvUV7aXKF"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1XfvBXOM42WB1ce932ETN_Yx7BOGToPCi"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1zoe9lLo_2zStb4MHVOzZRbeYXiAnSZuO"))
  drive_download(public_file, overwrite = TRUE)
  
  
  # Load your dataframes here
  Bassez_TNBC <- data.table::fread("Bassez_TNBC_data.csv")
  Bassez_HER2 <- data.table::fread("Bassez_HER2_data.csv")
  Bassez_ER <- data.table::fread("Bassez_ER_data.csv")
  Alvarez_Breckenridge <- data.table::fread("Alvarez_Breckenridge_data.csv")
  Bi_ccRCC <- data.table::fread("Bi_ccRCC_data.csv")
  Jerby_Arnon_Mel <- data.table::fread("Jerby_Arnon_Mel_data.csv")
  Ma_HCC <- data.table::fread("Ma_HCC_data.csv")
  M_iCCA <- data.table::fread("M_iCCA_data.csv")
  Pozniak_Mel <- data.table::fread("Pozniak_Mel_data.csv")
  Tirosh_Mel <- data.table::fread("Tirosh_Mel_data.csv")
  Yost_BCC <- data.table::fread("Yost_BCC_data.csv")

  
  
  output$selected_plot <- renderPlot({
    selected_df <- switch(input$selected_df, "Bassez_TNBC" = Bassez_TNBC, 
                          "Bassez_HER2" = Bassez_HER2, 
                          "Bassez_ER" = Bassez_ER, 
                          "Alvarez_Breckenridge" = Alvarez_Breckenridge, 
                          "Bi_ccRCC" = Bi_ccRCC, 
                          "Jerby_Arnon_Mel" = Jerby_Arnon_Mel, 
                          "Ma_HCC" = Ma_HCC, 
                          "Ma_iCCA" = M_iCCA, 
                          "Pozniak_Mel" = Pozniak_Mel, 
                          "Tirosh_Mel" = Tirosh_Mel, 
                          "Yost_BCC" = Yost_BCC)
    
    # Create a plot or visualization using the selected dataframe
    # For example, you can create a boxplot using ggplot2
    
    selected_df$pre_post <- factor (selected_df$pre_post, levels = c ("Pre", "Post" ))
    
   ggboxplot(selected_df, y = input$gene, x = "Outcome", fill = "pre_post", palette = "npg",
              facet.by = "pre_post") +theme(axis.text.x=element_text(size=15))+theme(axis.text.y=element_text(size=15)) + theme(legend.title = element_text(size=15))+
      theme(legend.text = element_text(size=15)) +   theme_classic() +                                                            # Change font size
      theme(strip.text.x = element_text(size = 15)) + theme(text = element_text(size = 15))  + theme(legend.position = "top")  + theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))  +
      theme(axis.text.x=element_text(size=15, angle=90,hjust=0.95,vjust=0.2)) + 
      theme(axis.text.x = element_text( colour = "black")) + 
      theme(axis.text.y = element_text( colour = "black")) + ggtitle(paste("Study nane - ", selected_df$Study_name_cancer))
    

    

  })
}

shinyApp(ui, server)
