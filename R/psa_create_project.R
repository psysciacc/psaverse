#' Create PSA Project
#'
#' DESCRIPTION
#' ADD INFORMATION ABOUT \\ OR / FOR WINDOWS
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#'
#' @import usethis
#'
#' @keywords create project
#'
#' @return NULL
#' @export
#' @examples
#' # psa_create_project(path = "~/Downloads", psa_name = "PSA001-Faces")
#' # psa_create_project(path = "C:\\Downloads", psa_name = "PSA001-Faces")

psa_create_project <- function(path = "./",
                               psa_name = "PSA000-demo") {

  # check the name of the project
  ui_todo("Checking...")
  # check name formatting ----
  name_ok <- grepl("^[A-Z]{3,6}[0-9]{3}-[a-z0-9]{1,15}$", psa_name)
  if (!name_ok) {
    stop("PSA-style names are usually in a format like 'PSA001-faces',
         with the project code made of uppercase letters and 3 numbers, a dash,
         and then a short name (1 to 15 characters) made of only lowercase letters
         and numbers.")
  }

  # check for trailing slash
  if (grepl("/$", path)) {
    path <- substr(path, 1, nchar(path)-1)
  }

  # create the project
  ui_todo("Setting up project...")
  create_package(
    path = paste0(path, "/", psa_name),
    fields = list(Title = paste0("Data Archive for", " ", psa_name)),
    check_name = FALSE
  )

  ui_done("Done!")
}
