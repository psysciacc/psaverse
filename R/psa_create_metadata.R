#' Create Metadata for each folder
#'
#' Input: a folder in inst.
#' Output: a README with info about the files in the folder, and templates for
#' the author to insert description.
#'
#' @param folder name of the folder to be documented.
#'
#' @import usethis knitr
#' @keywords create metadata folder
#'
#' @return NULL
#' @export
psa_create_metadata <- function(folder_path, overwrite = FALSE) {
  # For now, folder means the path to the folder
  # Just need file name of every file and a check on whether it is a dir
  if (!dir.exists(folder_path)) {
    stop(usethis::ui_oops(paste0("Pathname ", folder_path, " is not a valid folder.")))
  }

  # If there is no README file, create it
  folder_readme <- file.path(folder_path, "README.md")
  if(!file.exists(folder_readme)) {
    file.create(folder_readme)
  }

  files_df <- psa_metadata_table(folder_path)

  markdown_table <- knitr::kable(files_df, format = "markdown",
                                 row.names = FALSE)

  # Overwrite current README
  write("(FOLDER NAME) documentation\n\n", folder_readme, append = !overwrite)
  write("(SHORT DESCRIPTION)\n\n", folder_readme, append = TRUE)
  write("File information:\n", folder_readme, append = TRUE)
  cat(markdown_table, file = folder_readme, append = TRUE, sep = "\n")

}

psa_metadata_table <- function(folder_path) {
  files <- list.files(folder_path, full.names = TRUE) # Need full names for dir.exists
  are_files_dirs <- sapply(files, dir.exists)
  descriptions <- rep(c("INSERT FILE DESCRIPTION"), length(files))

  files <- sapply(files, basename)
  files_df <- data.frame(name = files,
                         isdir = are_files_dirs,
                         descriptions = descriptions)
  return(files_df)
}
