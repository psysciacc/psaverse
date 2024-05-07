#' Create PSA Project
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#' @param organisation github org to create the repo
#'
#' @return NULL
#' @export

psa_create_project <- function(path = "./",
                               psa_name = "PSA000-demo",
                               organisation = "psysciacc") {
  usethis::ui_todo("Checking...")
  # check name formatting ----
  name_ok <- grepl("^[A-Z]{3,6}[0-9]{3}-[a-z0-9]{1,15}$", psa_name)
  if (!name_ok) {
    stop("PSA-style names are usually in a format like 'PSA001-faces',
         with the project code made of uppercase letters and 3 numbers, a dash,
         and then a short name (1 to 15 characters) made of only lowercase letters
         and numbers")
  }

  # clone project locally ----
  usethis::ui_todo("Setting up project...")
  template_dir <- system.file("template", package = "psaverse")
  file.copy(template_dir,
            file.path(path),
            recursive = TRUE)
  file.rename(file.path(path, "template"),
              file.path(path, psa_name))

  # update with current project info ----
  usethis::ui_todo("Customising files...")

  ## DESCRIPTION ----
  desc_file <- file.path(path, psa_name, "DESCRIPTION")
  desc <- readLines(desc_file)
  gitname <- gsub("-[a-z0-9]*$", "", psa_name)
  desc[[1]] <- paste("Package:", gitname)
  desc[[2]] <- paste("Title: Data Archive for", psa_name)
  write(desc, desc_file)

  # check github access ----

  # create github repo ----

  # push to repo ----


  usethis::ui_done("Done!")
}
