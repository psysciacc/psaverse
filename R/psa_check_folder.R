#' Check PSA Project Folder Structure
#'
#' Checks the current project's folder structure according to the PSAVerse
#' standard structure, either one project folder (i.e., 01_Ethics, 02_Power,
#' etc.) at a time, or everything at once.
#'
#' @param folder name of the folder to check, or "all" to check all folders.
#'
#' @import usethis
#' @keywords check folder
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#' psa_check_folder("ethics")
#' psa_check_folder("all")
#' }
psa_check_folder <- function(folder = "all"){

  proj_location <- usethis::proj_path()

  if (folder == "all") {
    usethis::ui_info("Checking all folders...")
  }

  # Verify every folder

  if (folder == "ethics" | folder == "all"){
    # Verify that ethics folder exists
    if (!dir.exists(file.path(proj_location, "inst", "01_Ethics"))) {
      usethis::ui_oops("Folder \"inst/01_Ethics\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "01_Ethics")
      usethis::ui_info("Checking O1_Ethics folder...")
      psa_check_folder_ethics(working_folder)
    }
  }

  if (folder == "power" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "02_Power"))) {
      usethis::ui_oops("Folder \"inst/02_Power\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "02_Power")
      usethis::ui_info("Checking 02_Power folder...")
      psa_check_folder_power(working_folder)
    }
  }

  if (folder == "materials" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "03_Materials"))) {
      usethis::ui_oops("Folder \"inst/03_Materials\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "03_Materials")
      usethis::ui_info("Checking 03_Materials folder...")
      psa_check_folder_materials(working_folder)
    }
  }

  if (folder == "procedure" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "04_Procedure"))) {
      usethis::ui_oops("Folder \"inst/04_Procedure\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "04_Procedure")
      usethis::ui_info("Checking 04_Procedure folder...")
      psa_check_folder_procedure(working_folder)
    }
  }

  if (folder == "data" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "05_Data"))) {
      usethis::ui_oops("Folder \"inst/05_Data\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "05_Data")
      usethis::ui_info("Checking 05_Data folder...")
      psa_check_folder_data(working_folder)
    }
  }

  if (folder == "analysis" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "06_Analysis"))) {
      usethis::ui_oops("Folder \"inst/06_Analysis\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "06_Analysis")
      usethis::ui_info("Checking 06_Analysis folder...")
      psa_check_folder_analysis(working_folder)
    }
  }

  if (folder == "communication" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "07_Communication"))) {
      usethis::ui_oops("Folder \"inst/07_Communication\" does not exist.")
    }
    else {
      working_folder <- file.path(proj_location, "inst", "07_Communication")
      usethis::ui_info("Checking 07_Communication folder...")
      psa_check_folder_communication(working_folder)
    }
  }

  if (folder == "other" | folder == "all"){
    if (!dir.exists(file.path(proj_location, "inst", "08_Other"))) {
      usethis::ui_oops("Folder \"inst/08_Other\" does not exist.")
    }
    else {
      usethis::ui_done("Folder \"inst/08_Other\" exists!")
    }
  }

  # What should be done with the 08_Other function?
  # Is this documented with a vignette? I don't think that putting
  # a whole encyclopedia in here is the way to go

  usethis::ui_done("Checking finished.")

}

## Helper functions for each folder

psa_check_folder_ethics <- function(working_folder) {

  # Requirements at first depth level of ethics folder
  ethics_patterns <- c("README\\.md", "lab_ethics_summary\\.csv", "+[cC]ollaboration+", "PI_IRB", "Local_IRB", "No_Ethics", "Rely_PI")
  ethics_requirements <- c("README.md", "lab_ethics_summary.csv", "Collaboration Agreement", "PI_IRB", "Local_IRB", "No_Ethics", "Rely_PI")
  ethics_folders <- c("PI_IRB", "Local_IRB", "No_Ethics", "Rely_PI")

  ethics_missing <- get_missing_reqs(ethics_patterns, ethics_requirements, working_folder)

  all_ethics_subfolders_exist <- all_subfolders_exist(ethics_folders, working_folder)

  if (all_ethics_subfolders_exist) {

    # Requirements at second depth level of ethics folder
    # This only executes if all subfolders exist

    if(!require_pattern_in_folder(folder = file.path(working_folder, "PI_IRB"), "V[0-9]+_IRB_Submission|V[0-9]+_IRB_Approval")) {
      append(ethics_missing, "PI_IRB/V[#]_IRB_Submission or PI_IRB/V[#]_IRB_Approval")
    }
    if(!require_pattern_in_folder(folder = file.path(working_folder, "Local_IRB"), "[0-9]+_[a-zA-z]+")) {
      append(ethics_missing, "Local_IRB/NUMBER_Name")
    }
    if(!require_pattern_in_folder(folder = file.path(working_folder, "No_Ethics"), "[0-9]+_[a-zA-z]+")) {
      append(ethics_missing, "No_Ethics/NUMBER_Name")
    }
    if(!require_pattern_in_folder(folder = file.path(working_folder, "Rely_PI"), "[0-9]+_[a-zA-z]+")) {
      append(ethics_missing, "Rely_PI/NUMBER_Name")
    }
  }

  print_missing_reqs(ethics_missing, folder = working_folder)

  if (length(ethics_missing) == 0 &&
      all_ethics_subfolders_exist) {
    print_satisfied(working_folder)
  }

}

psa_check_folder_power <- function(working_folder) {
  # Requirements (only one depth level)
  power_patterns <- c("README\\.md", ".*power.*analysis\\.R(md)?")
  power_requirements <- c("README.md", "Power Analysis")

  power_missing <- get_missing_reqs(power_patterns, power_requirements, working_folder)

  print_missing_reqs(power_missing, folder = working_folder)

  if (length(power_missing) == 0) {
    print_satisfied(working_folder)
  }

}

psa_check_folder_materials <- function(working_folder) {
  # Requirements
  materials_folders <- c("Text", "Audio", "Video", "Translation")
  materials_formats <- c("Text", "Audio", "Video")
  materials_patterns <- c("README\\.md", materials_folders)
  materials_requirements <- c("README.md", materials_folders)
  materials_subfolders <- list.dirs(working_folder, full.names = FALSE, recursive = FALSE)
  materials_missing <- get_missing_reqs(materials_patterns,
                                        materials_requirements, working_folder)

  are_all_materials_folders_missing <- !(FALSE %in% (materials_formats %in% materials_missing))
  if (are_all_materials_folders_missing) {
    # All material folders with format missing
    usethis::ui_todo("You need to include at least one of the following folders: Text, Audio or Video.")
  }
  else {
    # Exclude all format material folders from missing list
    materials_missing <- setdiff(materials_missing, materials_formats)
  }

  # If there is any subfolder not from the required formats, throw warning
  external_subfolder <- FALSE %in% (materials_subfolders %in% materials_folders)
  if (external_subfolder) {
    usethis::ui_oops("All subfolders with material files must be exactly named Text, Audio or Video.")
  }

  # Translation folder and at least one of the format folders must be there
  # before checking emptiness
  are_required_folders_occupied <- FALSE
  if (!("Translation" %in% materials_missing) && !are_all_materials_folders_missing) {

    # Format folders within the Materials folder
    existing_format_folders <- intersect(materials_folders, list.dirs(working_folder))
    append(existing_format_folders, "Translation")

    existing_format_folders <- sapply(existing_format_folders, file.path, working_folder)

    are_required_folders_occupied <- are_folders_occupied(existing_format_folders, working_folder)
  }

  print_missing_reqs(materials_missing, working_folder)

  if (length(materials_missing) == 0 && !are_all_materials_folders_missing &&
      !external_subfolder && are_required_folders_occupied) {
    print_satisfied(working_folder)
  }


}

psa_check_folder_procedure <- function(working_folder) {
  # Requirements
  procedure_patterns <- c("README\\.md", "English", "Translation", "lab_notebook\\.csv")
  procedure_requirements <- c("README.md", "English", "Translation", "lab_notebook.csv")
  procedure_folders <- c("English", "Translation")

  procedure_missing <- get_missing_reqs(procedure_patterns,
                                        procedure_requirements,
                                        working_folder)


  procedure_missing_folders <- intersect(procedure_folders, procedure_missing)
  are_procedure_folders_missing <- length(procedure_missing_folders) != 0

  # All folders must be there before checking emptiness
  are_procedure_folders_occupied <- FALSE
  if (!are_procedure_folders_missing) {
    are_procedure_folders_occupied <- are_folders_occupied(procedure_folders, working_folder)
  }

  print_missing_reqs(procedure_missing, working_folder)

  if (!are_procedure_folders_missing && are_procedure_folders_occupied) {
    print_satisfied(working_folder)
  }

}

psa_check_folder_data <- function(working_folder) {
  # Requirements
  data_patterns <- c("README\\.md", "Raw Data", "Processed_Data", "Scripts")
  data_requirements <- c("README\\.md", "Raw_Data", "Processed_Data", "Scripts")
  data_folders <- c("Raw_Data", "Processed_Data", "Scripts")

  data_missing <- get_missing_reqs(data_patterns,
                                   data_requirements,
                                   working_folder)


  data_missing_folders <- intersect(data_folders, data_missing)
  are_data_folders_missing <- length(data_missing_folders) != 0

  # All folders must be there before checking emptiness
  are_data_folders_occupied <- FALSE
  if (!are_data_folders_missing) {
    are_data_folders_occupied <- are_folders_occupied(data_folders, working_folder)
  }

  print_missing_reqs(data_missing, working_folder)

  if (!are_data_folders_missing && are_data_folders_occupied) {
    print_satisfied(working_folder)
  }
}

psa_check_folder_analysis <- function(working_folder) {
  # Requirements
  analysis_patterns <- c("README\\.md", "Outputs", "Images", "Includes")
  analysis_requirements <- c("README\\.md", "Outputs", "Images", "Includes")
  analysis_folders <- c("Outputs", "Images", "Includes")

  analysis_missing <- get_missing_reqs(analysis_patterns,
                                   analysis_requirements,
                                   working_folder)


  analysis_missing_folders <- intersect(analysis_folders, analysis_missing)
  are_analysis_folders_missing <- length(analysis_missing_folders) != 0

  # All folders must be there before checking emptiness
  are_analysis_folders_occupied <- FALSE
  if (!are_analysis_folders_missing) {
    are_analysis_folders_occupied <- are_folders_occupied(analysis_folders, working_folder)
  }

  print_missing_reqs(analysis_missing, working_folder)

  if (!are_analysis_folders_missing && are_analysis_folders_occupied) {
    print_satisfied(working_folder)
  }

  # Suggest Supplemental folder
  if (!("Supplemental" %in% list.dirs(working_folder, full.names = FALSE))) {
    usethis::ui_info("Suggestion: add \"Supplemental\" folder.")
  }
}

psa_check_folder_communication <- function(working_folder) {
  # Requirements
  communication_patterns <- c("README\\.md", "Pre-Registration", "Manuscript")
  communication_requirements <- c("README\\.md", "Pre-Registration", "Manuscript")
  communication_folders <- c("Pre-Registration", "Manuscript")

  communication_missing <- get_missing_reqs(communication_patterns,
                                       communication_requirements,
                                       working_folder)


  communication_missing_folders <- intersect(communication_folders, communication_missing)
  are_communication_folders_missing <- length(communication_missing_folders) != 0

  # All folders must be there before checking emptiness
  are_communication_folders_occupied <- FALSE
  if (!are_communication_folders_missing) {
    are_communication_folders_occupied <- are_folders_occupied(communication_folders, working_folder)
  }

  # Verify that tenzing file exists, assuming that
  is_there_tenzing_file <- FALSE
  if ("Manuscript" %in% list.dirs(working_folder, full.names = FALSE)) {
    # Verify that there is a file in Manuscript with the word tenzing
    manuscript <- file.path(working_folder, "Manuscript")
    is_there_tenzing_file <- check_pattern_in_folder(manuscript, ".*tenzing.*")
    if (!is_there_tenzing_file) {
      append(communication_missing, "tenzing")
    }
  }

  print_missing_reqs(communication_missing, working_folder)

  if (!are_communication_folders_missing && are_communication_folders_occupied
      && is_there_tenzing_file) {
    print_satisfied(working_folder)
  }

  # Suggest Supplemental folder
  if (!("Presentations" %in% list.dirs(working_folder, full.names = FALSE))) {
    usethis::ui_info("Suggestion: add \"Presentations\" folder.")
  }
}

## Utility functions

are_folders_occupied <- function(required_folders, working_folder) {
  required_folders <- sapply(required_folders, function(x) file.path(working_folder, x))

  required_empty_folders <- sapply(required_folders,
                                   function(x) length(list.files(x)) == 0)
  required_empty_folders <- required_folders[unlist(required_empty_folders)]

  if (length(required_empty_folders) == 0) {
    return(TRUE)
  }
  else {
    required_empty_folders <- paste(basename(required_empty_folders), collapse = ', ')
    usethis::ui_todo(
      paste0("The following required empty folders are empty: ", required_empty_folders)
    )
    return(FALSE)
  }
}


check_pattern_in_folder <- function(folder = ".", pattern) {
  # Checks whether there exists a file following the given pattern
  # in the given folder.
  if (is.null(folder) || is.null(pattern)) {
    stop("Please supply non-null folder paths and patterns.")
  }
  if (missing(pattern)) {
    stop("Please provide a pattern.")
  }

  if (!dir.exists(folder)) {
    stop("Specified folder does not exist.")
  }

  files <- list.files(folder)
  TRUE %in% sapply(files, grepl, pattern = pattern)

}

require_pattern_in_folder <- function(folder = ".", pattern) {
  # Checks whether all files in folder follow the given pattern.
  if (is.null(folder) || is.null(pattern)) {
    stop("Please supply non-null folder paths and patterns.")
  }
  if (missing(pattern)) {
    stop("Please provide a pattern.")
  }

  if (!dir.exists(folder)) {
    stop("Specified folder does not exist.")
  }

  files <- list.files(folder)
  !(FALSE %in% sapply(files, grepl, pattern = pattern))

}

all_subfolders_exist <- function(req_subfolders, folder_path) {
  # Determines whether the given subfolders all exist within the given folder.
  subfolder_paths <- sapply(req_subfolders, function(y) file.path(folder_path, y))
  !(FALSE %in% sapply(subfolder_paths, file.exists))
}

get_missing_reqs <- function(patterns, requirements, folder) {
  req_df <- data.frame(patterns = patterns, requirements = requirements)

  req_df$found <- sapply(patterns, check_pattern_in_folder, folder = folder)

  missing_reqs <- req_df[req_df$found == FALSE, "requirements"]
}

print_missing_reqs <- function(missing_reqs, folder) {
  # Generate list of missing reqs, then print only one thing
  msg <- ""
  for (req in missing_reqs) {
    msg <- paste0(msg, "\n", "- ", req)
  }
  if (length(missing_reqs) > 0) {
  usethis::ui_todo(paste0("You need to include: ", msg))
  }
}

print_satisfied <- function(folder) {
  usethis::ui_done(paste0("All requirements for ", basename(folder), " satisfied!"))
}


