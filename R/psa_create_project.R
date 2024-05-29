#' Create PSA Project
#'
#' DESCRIPTION
#' ADD INFORMATION ABOUT \\ OR / FOR WINDOWS
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#' @param given
#'
#' @import usethis
#'
#' @keywords create project
#'
#' @return NULL
#' @export
#' @examples
#' \dontrun{
#' psa_create_project(path = "~/Downloads", psa_name = "PSA001-Faces")
#' psa_create_project(path = "C:\\Downloads", psa_name = "PSA001-Faces")
#' }

psa_create_project <- function(path = "./",
                               psa_name = "PSA000-demo",
                               given = NULL,
                               family = NULL,
                               middle = NULL,
                               email = NULL,
                               role = NULL,
                               comment = NULL) {

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
    fields = list(Title = paste0("Data Archive for", " ", psa_name),
                  "Authors@R" = person(given = given,
                                        family = family,
                                        middle = middle,
                                        email = email,
                                        role = role,
                                        comment = comment),
                  License = use_ccby_license()),
    check_name = FALSE
  )

  ui_info("This package makes use of the CC BY 4.0 license.")

  if (is.null(given) && is.null(family) && is.null(middle)
      && is.null(email) && is.null(role) && is.null(comment)) {

    # Add default author with psa_add_author: for now the Authors field is NULL


    ui_todo("No author information supplied: placeholder author introduced in DESCRIPTION file. Please edit the DESCRIPTION file to remove it.")
  }

  ui_todo("Refer to the function psa_create_description to add more information to the DESCRIPTION file, or manually edit it.")

  ui_done("Done!")
}
