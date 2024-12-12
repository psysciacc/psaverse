#' Create PSA Project
#'
#' Use this function to initialize a PSA structured R project
#' to put on GitHub and share. Remember that file paths need
#' to be either "C:/Windows/blah" or "C:\\Windows\\blah" if you
#' are using a Windows machine.
#'
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#' @param given given name of first author
#' @param family family name of first author
#' @param email email address of first author
#' @param role role of first author, usually "aut" and "cre";
#'  refer to the documentation for utils::person() for more details.
#'  You may only have one "cre" (maintainer).
#' @param comment additional information, e.g. ORCID number
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
                               email = NULL,
                               role = NULL,
                               comment = NULL) {

  # check the name of the project
  ui_todo("Checking...")
  # check name formatting ----
  name_ok <- grepl("^[A-Z]{3,6}[0-9]{3}-[a-z0-9]{1,15}$", psa_name)
  if (!name_ok) {
    stop("PSA-style names are usually in a format like 'PSA001-faces',
         with the project code made of uppercase letters and 3
         numbers, a dash, and then a short name (1 to 15 characters)
         made of only lowercase letters
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
                                        email = email,
                                        role = role,
                                        comment = comment),
                  License = use_ccby_license()),
    check_name = FALSE
  )

  ui_info("This package makes use of the CC BY 4.0 license.")

  if (is.null(given) && is.null(family) &&
      is.null(email) && is.null(role) && is.null(comment)) {

    ui_todo("No author information supplied. Please execute the
            psa_add_author function to add more authors.")
  }

  ui_todo("Refer to the function psa_create_description to add
          more information to the DESCRIPTION file, or manually edit it.")

  ui_done("Done!")

}
