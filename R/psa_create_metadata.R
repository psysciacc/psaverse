#' Create Metadata for each folder
#'
#' Takes a folder from inst (that is, O1_Ethics,
#' O2_Power, etc.), and outputs a README file with
#' the filenames of every file/subfolder from the given
#' folder, also indicating whether they are files or
#' subfolders. A space for modifying a description
#' for every file is also created.
#'
#' @param folder name of the folder to be documented.
#' If not "ethics", "power", ..., "other", must supply
#' full path of the folder.
#' @param overwrite TRUE/FALSE variable for if you
#' want to overwrite a previously created metadata file.
#'
#' @import usethis knitr
#' @keywords create metadata folder
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#'   psa_create_metadata(ethics, overwrite = TRUE)
#' }
#'
psa_create_metadata <- function(folder, overwrite = FALSE) {

  # Support for inst folder names
  project_path <- usethis::proj_path()
  inst <- file.path(project_path, "inst")

  switch (folder,
    ethics = {folder_path <- file.path(project_path, "inst", "01_Ethics")},
    power = {folder_path <- file.path(project_path, "inst", "02_Power")},
    materials = {folder_path <- file.path(project_path, "inst", "03_Materials")},
    procedure = {folder_path <- file.path(project_path, "inst", "04_Procedure")},
    data = {folder_path <- file.path(project_path, "inst", "05_Data")},
    analysis = {folder_path <- file.path(project_path, "inst", "06_Analysis")},
    communication = {folder_path <- file.path(project_path, "inst", "07_Communication")},
    other = {folder_path <- file.path(project_path, "inst", "08_Other")},
    {folder_path <- folder}
  )

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
