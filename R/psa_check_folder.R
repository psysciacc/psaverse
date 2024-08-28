#' Create PSA Project
#'
#' DESCRIPTION
#' ADD INFORMATION ABOUT \\ OR / FOR WINDOWS
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#'
#' @import usethis
#' @keywords create project
#'
#' @return NULL
#' @export

psa_check_folder <- function(folder = "all"){

  proj_location <- usethis:::proj_path()

  if (folder == "ethics" | folder == "all"){
    # Verify that ethics folder exists
    if (!dir.exists(file.path(proj_location, "inst", "01_Ethics"))) {
      stop("Folder \"inst/01_Ethics\" does not exist.")
    }
    working_folder <- file.path(proj_location, "inst", "01_Ethics")
    psa_check_folder_ethics(working_folder)
  }

  if (folder == "power" | folder == "all"){
    # Verify that ethics folder exists
    if (!dir.exists(file.path(proj_location, "inst", "02_Power"))) {
      stop("Folder \"inst/02_Power\" does not exist.")
    }
    working_folder <- file.path(proj_location, "inst", "02_Power")
    psa_check_folder_power(working_folder)
  }

  if (folder == "materials" | folder == "all"){
    # Verify that ethics folder exists
    if (!dir.exists(file.path(proj_location, "inst", "03_Materials"))) {
      stop("Folder \"inst/03_Materials\" does not exist.")
    }
    working_folder <- file.path(proj_location, "inst", "03_Materials")
    psa_check_folder_materials(working_folder)
  }

}

psa_check_folder_ethics <- function(working_folder) {


  # Requirements at first depth level of ethics folder
  ethics_patterns <- c("README\\.md", "lab_ethics_summary\\.csv", "+[cC]ollaboration+", "PI_IRB", "Local_IRB", "No_Ethics", "Rely_PI")
  ethics_requirements <- c("README.md", "lab_ethics_summary.csv", "Collaboration Agreement", "PI_IRB", "Local_IRB", "No_Ethics", "Rely_PI")

  ethics_missing <- get_missing_reqs(ethics_patterns, ethics_requirements, working_folder)

  # Requirements at second depth level of ethics folder
  ethics_required <- c()

  if(!require_pattern_in_folder(folder = file.path(working_folder, "PI_IRB"), "V[0-9]+_IRB_Submission")) {
    append(ethics_required, "PI_IRB/V[#]_IRB_Submission")
  }
  if(!require_pattern_in_folder(folder = file.path(working_folder, "PI_IRB"), "V[0-9]+_IRB_Approval")) {
    append(ethics_required, "V[#]_IRB_Approval")
  }
  if(!require_pattern_in_folder(folder = file.path(working_folder, "Local_IRB"), "[0-9]+_[a-zA-z]+")) {
    append(ethics_required, "Local_IRB/NUMBER_Name")
  }
  if(!require_pattern_in_folder(folder = file.path(working_folder, "No_Ethics"), "[0-9]+_[a-zA-z]+")) {
    append(ethics_required, "Local_IRB/NUMBER_Name")
  }
  if(!require_pattern_in_folder(folder = file.path(working_folder, "Rely_PI"), "[0-9]+_[a-zA-z]+")) {
    append(ethics_required, "Local_IRB/NUMBER_Name")
  }

  print_missing_reqs(c(ethics_missing, ethics_required), folder = working_folder)

}

psa_check_folder_power <- function(working_folder) {
  # Requirements (only one depth level)
  power_patterns <- c("README\\.md", ".*power.*analysis\\.R(md)?")
  power_requirements <- c("README.md", "Power Analysis")

  power_missing <- get_missing_reqs(power_patterns, power_requirements, working_folder)

  print_missing_reqs(power_missing, folder = working_folder)
}

psa_check_folder_materials <- function(working_folder) {
  # Requirements
  materials_patterns <- c("README\\.md", ".*power.*analysis\\.R(md)?")
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

get_missing_reqs <- function(patterns, requirements, folder) {
  req_df <- data.frame(patterns = patterns, requirements = requirements)

  req_df$found <- sapply(patterns, check_pattern_in_folder, folder = folder)

  missing_reqs <- req_df[req_df$found == FALSE, "requirements"]
}

print_missing_reqs <- function(missing_reqs, folder) {
  if (length(missing_reqs) == 0) {
    usethis::ui_done(paste0("All requirements for ", folder, " satisfied!"))
  }
  else {
    for (i in 1:len(missing_reqs)) {
      usethis::ui_todo(paste0("You need to include ", missing_reqs[i]))
    }
  }
}


