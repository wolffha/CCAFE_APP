box::use(
  shiny[...],
  argonR[...],
  argonDash[...],
  reactable[...],
  tibble[...]
)

guideUI <- function(id) {
  ns <- NS(id)
  tagList(
    argonRow(
      argonColumn(
        width = 12,
        argonH1(display = 1, "Application Guide"),
        
        argonLead(
          "The CCAFE Shiny Application contains a distinct interface, 
          displaying the analysis output table as described below."
        ),
        reactableOutput(ns("ccafe_description_table"))
      )
    ),
    br(),
    argonRow(
      argonColumn(
        width = 12,
        argonH1(display = 3, "Quick Start Guide"),
        argonLead(
          tagList(
            "How to use the ", argonBadge("Analysis", status = "primary"),
            "module"
          )
        ),
        br(),
        argonTabSet(
          id = ns("analysis_steps"),
          card_wrapper = TRUE,
          horizontal = TRUE,
          size = "sm",
          width = 12,
          iconList = list(argonIcon("zoom-split-in"), argonIcon("settings-gear-65"), argonIcon("check-bold")),
          
          # step 1
          argonTab(
            tabName = "Step 1",
            active = TRUE,
            argonRow(
              argonColumn(
                width = 6,
                imageOutput(ns("step1_image"), height = "auto")
              ),
              argonColumn(
                width = 6,
                tagList(   # Use tagList() to wrap everything
                  argonTextColor(
                    tags$p(
                      "Once within the ", argonBadge("Analysis"), " module you will be able to upload your data."
                    ),
                    color = "dark"
                  ),
                  argonTextColor(
                    tags$p(
                      "To do so, click the ", argonBadge("Upload"), 
                      " button, which will open your file browser. Select your desired file, which will populate the 
                      selected file name."
                    ),
                    color = "dark"
                  ),
                  argonTextColor(
                    tags$p(
                      "Once you have ensured you selected the desired file, click the ", argonBadge("Process File"), 
                      " button, which will perform pre-processing of the file and show a preview table. This step removes 
                      rows with missing data and standardizes column headers."
                    ),
                    color = "dark"
                  )
                )
              )
            )
          ),
          
          # step 2
          argonTab(
            tabName = "Step 2",
            argonRow(
              argonColumn(
                width = 6,
                imageOutput(ns("step2_image"), height = "auto")
              ),
              argonColumn(
                width = 6,
                argonTextColor(
                  tagList(
                    "Scroll up/down or use the search bar to find the variable for population group. Click the desired variable,",
                    strong("finnish"), "in this example"),
                  color = "dark"
                )
              )
            )
          ),
          argonTab(
            tabName = "Step 3",
            argonRow(
              argonColumn(
                width = 6,
                imageOutput(ns("step3_image"), height = "auto")
              ),
              argonColumn(
                width = 6,
                argonTextColor(
                  tagList(
                    "In the", strong("Effect Estimate Calculattion"),
                    "widget, toggle the button and the selected variable with its available categories or levels will display.",
                    strong("BETA"), "in this example, is displayed if beta is included instead of", strong("OR"), 
                    ". If the selected variable in the previous step contains OR, then there is no need to apply this filter."
                  ),
                  color = "dark"
                ),
                br(),
                br(),
                argonTextColor(
                  tagList(
                    "TO ADD"),
                  color = "dark"
                )
              )
            )
          )
        )
      )
    )
  )
}

# Server Module
guideServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$ccafe_description_table <- renderReactable({
      ccafe_description_table <- tibble(
        tab = c(
          "Analysis: CaseControlAF()",
          "Analysis: CaseControlSE()"
        ),
        input = c(
          "position, chromosome, total allele frequency",
          "position, chromosome, odds ration, population group"
        ),
        output = c(
          "Table 00-0.00 GWAS Summary Statistics: Unadjusted Case and Control Allele Frequencies",
          "Table 00-0.00 GWAS Summary Statistics: Adjusted Case and Control Allele Frequencies"
        )
      )
      reactable(ccafe_description_table)
    })
    
    output$step1_image <- renderImage({
      list(
        src = "app/static/UploadDataset1.png",
        alt = "Filter Screenshot 1",
        width = "80%",
        height = "auto"
      )
    }, deleteFile = FALSE)
    
    output$step2_image <- renderImage({
      list(
        src = "app/static/CCAFE-hex.png",
        alt = "Filter Screenshot 2",
        width = "20%",
        height = "auto"
      )
    }, deleteFile = FALSE)
    
    output$step3_image <- renderImage({
      list(
        src = "app/static/CCAFE-hex.png",
        alt = "Filter Screenshot 3",
        width = "20%",
        height = "auto"
      )
    }, deleteFile = FALSE)
  })
}