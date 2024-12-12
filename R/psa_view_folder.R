#' View metadata for a folder
#'
#' @description
#' Allows you to view the metadata for a folder for
#' a PSA project.
#'
#'
#' @param folder what folder you want to view metadata for.
#' Any of the following names can be used:
#' - "ethics": "01_Ethics",
#' - "power": "02_Power"
#' - "materials": "03_Materials"
#' - "procedure": "04_Procedure"
#' - "data": "05_Data"
#' - "analysis": "06_Analysis"
#' - "communication": "07_Communication"
#' - "other": "08_Other"
#'
#' @import usethis
#' @keywords view metadata
#' @return a dataframe of file information for the folder
#' @export
#'
#' @examples
#' \dontrun{
#' psa_view_folder(
#' folder = "ethics"
#' }
#'
#'
psa_view_folder <- function(
    folder = NULL
){

  if (is.null(folder)) {
    stop("Please enter a folder name.")
  }

  folder <- switch(folder,
                   "ethics" = "01_Ethics",
                   "power" = "02_Power",
                   "materials" = "03_Materials",
                   "procedure" = "04_Procedure",
                   "data" = "05_Data",
                   "analysis" = "06_Analysis",
                   "communication" = "07_Communication",
                   "other" = "08_Other",
                   folder
  )

  # read in the readme
  readme_text <- readLines(
    paste0("inst/", folder, "/README.md")
  )

  # find the dataframe
  data_text <- readme_text[grepl("^\\|", readme_text)]

  # remove separator lines
  data_text <- data_text[!grepl("\\|:---.+\\|", data_text)]
  data_text <- sapply(data_text, function(row) substr(row, 2, nchar(row) - 1))

  # Split columns by whitespace and convert into dataframe
  table_df <- read.table(text = data_text, header = TRUE, sep = "|")

  return(table_df)

}
