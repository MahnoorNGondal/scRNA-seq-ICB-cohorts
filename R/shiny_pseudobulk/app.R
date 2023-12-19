
library(shiny)
library(ggplot2)
library(shinythemes)
#library(arrow)
library(shinyFiles)
library(ggpubr)
library(rsconnect)
library(googledrive)
library(stats)

## download from googledrive
drive_deauth()
drive_user()
public_file <-  drive_get(as_id("1PsYMT3koKNGF7Hmo3QYJnosJNNHbp4GO"))
drive_download(public_file, overwrite = TRUE)

Yost_BCC <- data.table::fread("Yost_BCC_data.csv")
gene_names <- colnames(Yost_BCC[,c(2:38207)])

ui <- fluidPage(   fluidRow(
          h4("For single-cell data: ", a("Search for it", href = "https://drive.google.com/drive/folders/1bntoBZRUUkiBcf7p2wPQZw-fiOZiB15a?ths=true"))
),
fluidRow(
  h4("For Pseudobulk level data: ", a("Search for it", href = "https://drive.google.com/drive/folders/1mWKPFfQV0h0ReEC_p1y8zozH5ocs_2Xn?ths=true"))
),
fluidRow(
  h4("For normalized Pseudobulk level data: ", a("Search for it", href = "https://drive.google.com/drive/folders/14PK_L5GriFYbFD22jWIChqh7apWCpn6d?ths=true"))
)
,
theme = shinytheme("journal"),
                 titlePanel("Single-cell ICB cohort - Pseudobulk"),
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
                                                                                     "Yost_BCC",
                                                                                     "Combined_data")),
                     selectInput( inputId = "gene", label = "Select a gene x", choices = c(gene_names)),
                     selectInput( inputId = "gene2", label = "Select a gene y", choices = c(gene_names)),
                   ),
                   mainPanel("Results are being generated - please wait",
                             fluidRow(
                               splitLayout(style = "border: 1px solid silver:", cellWidths = c("40%", "60%"), 
                                           plotOutput("selected_plot"),  
                                           plotOutput("selected_plot3")
                               )
                             )
                   
                   )
                 )
)

server <- function(input, output) {
  
  ## download from googledrive
  drive_deauth()
  drive_user()
  public_file <-  drive_get(as_id("17Ai7nAvxuTjTGb1rEc_I2Czit2QhOWfO"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("19u74JLwMnH5kY13yWSe36h2SDUbq4KFq"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1KnSoxEppEbu901-I9xEnF0ZKvrAcLhin"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1ktbCU7k4YT7o52Iu9Yt4zYyyDGmhdDMo"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1WnW1PXXwVJlhzD_mFZ9PEswDSQdcZsGD"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("11I5tlgV4MJHOK0MZ-dGQPbdFxKbLDOnP"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1niFMTzRYSbTsUPwod7s0tAa8_vuMx18E"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1i-yoOoIadLk_0oWv4h-UJlJL-K4s0iuX"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1w5uWkvzHWrO_zTmEIPiRWkg7nOV-uaNh"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1OAQUNC1WhQd-OzIiCSMTPzX5X7HU82Qv"))
  drive_download(public_file, overwrite = TRUE)
  
  public_file <-  drive_get(as_id("1PsYMT3koKNGF7Hmo3QYJnosJNNHbp4GO"))
  drive_download(public_file, overwrite = TRUE)
  
  # combined
  public_file <-  drive_get(as_id("1vMnULAUN76eQ44cVdrq7zFX-V33Y5bBd"))
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

  
  Combined_data <- data.table::fread("Combined_data.csv")
  
  
  
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
                          "Yost_BCC" = Yost_BCC,
                          "Combined_data" = Combined_data)
    
    

    # Create a plot or visualization using the selected dataframe
    # For example, you can create a boxplot using ggplot2
    
    selected_df$pre_post <- factor (selected_df$pre_post, levels = c ("Pre", "Post" ))
    

    
   ggboxplot(selected_df, y = input$gene, x = "Combined_outcome", color = "pre_post", palette = "npg") +
     facet_wrap(~pre_post, scales = "free_y") +theme(axis.text.x=element_text(size=15))+theme(axis.text.y=element_text(size=15)) + theme(legend.title = element_text(size=15))+
      theme(legend.text = element_text(size=15)) +
      xlab(NULL) +   theme_classic() +                                                            # Change font size
      theme(strip.text.x = element_text(size = 15)) + theme(text = element_text(size = 15))  + theme(legend.position = "top")  + theme(axis.text.x = element_text(angle = 90, vjust = 1, hjust=1))  +
      theme(axis.text.x=element_text(size=15, angle=90,hjust=0.95,vjust=0.2)) + 
      theme(axis.text.x = element_text( colour = "black")) + 
      theme(axis.text.y = element_text( colour = "black")) + ggtitle(paste(  "      Boxplot")) 
    

    

  })
  
  
  output$selected_plot3 <- renderPlot({
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
                          "Yost_BCC" = Yost_BCC,
                          "Combined_data" = Combined_data)
    
    # Create a plot or visualization using the selected dataframe
    # For example, you can create a boxplot using ggplot2
    
    selected_df$pre_post <- factor (selected_df$pre_post, levels = c ("Pre", "Post" ))
    
    ggscatter(selected_df, x = input$gene, y = input$gene2, add = "reg.line", 
                   conf.int = TRUE,  
                   palette = "Paired"  ,
                   label.x.npc = "left", cor.coef = TRUE, cor.coeff.args = list(method = "spearman", color = "black",label.sep='\n'), cor.coef.size =5, star.plot.lwd = 15, repel = TRUE  ) + 
      facet_wrap(~pre_post, scales = "free_y") + 
      guides(color=guide_legend(title="Cancer type")) + theme(legend.position = "none") +theme(axis.text.x=element_text(size=50))+
      theme(axis.text.y=element_text(size=50)) + 
      theme(legend.title = element_text(size=50))+
      theme(legend.text = element_text(size=50)) +                                                               # Change font size
      theme(strip.text.x = element_text(size = 50)) + theme(text = element_text(size = 50))  + theme(legend.position = "none") +
      theme_classic() +geom_point(aes(color=Study_name_cancer)) + theme(legend.position = "none") +
      theme_classic()+theme(axis.text.x=element_text(size=15))+theme(axis.text.y=element_text(size=15)) + theme(legend.title = element_text(size=15))+
      theme(legend.text = element_text(size=15)) +                                                               # Change font size
      theme(strip.text.x = element_text(size = 15)) + theme(text = element_text(size =15))+ 
      theme(axis.text.x = element_text( colour = "black")) + 
      theme(axis.text.y = element_text( colour = "black"))+ theme(legend.position = "right")  + ggtitle(paste("      Scatterplot"))  
  
  })
  
}

shinyApp(ui, server)
