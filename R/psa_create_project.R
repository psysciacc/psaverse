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
  # clone project locally ----
  usethis::ui_todo("Setting up project...")
  template_dir <- system.file("template", package = "psaverse")
  file.copy(template_dir,
            file.path(path),
            recursive = TRUE)
  file.rename(file.path(path, "template"),
              file.path(path, psa_name))

  # update with current project info ----

  ## DESCRIPTION ----

  # check github access ----

  # create github repo ----

  # push to repo ----


  usethis::ui_done("Done!")
}
