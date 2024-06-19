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

psa_add_author <- function(
  given = NULL,
  family = NULL,
  ORCID_number = NULL,
  email = NULL,
  role = NULL # add the rest c("aut", "cre")
){

   use_author(
     given = given,
     family = family,
     comment = c(ORCID = ORCID_number),
     email = email,
     role = role

   )
}

