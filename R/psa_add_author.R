#' Add Author Info to PSA Project
#'
#' @description
#' Adds a person information to the `Authors@R` section of the DESCRIPTION
#' file, creating that field if necessary. Acts as a wrapper for the function
#' usethis::use_author() function.
#'
#'
#' @param given given name of author
#' @param family family name of author
#' @param ORCID_number ORCID number associated with author
#' @param email email address of author
#' @param role vector containing roles of author in the project,
#' usually "aut" and "cre"; refer to utils::person() documentation for
#' more information.
#'
#' @import usethis
#' @keywords add author
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#' psa_add_author(
#'   given = "Lucy",
#'   family = "van Pelt",
#'   role = c("aut", "cre"),
#'   email = "lucy@example.com",
#'   ORCID_number = "LUCY-ORCID-ID")
#' }
#'
#'
psa_add_author <- function(
    given = NULL,
    family = NULL,
    ORCID_number = NULL,
    email = NULL,
    role = NULL # add the rest c("aut", "cre")
){

  if (is.null(given) && is.null(family) && is.null(ORCID_number) && is.null(email) && is.null(role)) {
    # Add default author
    usethis::use_author(
      given = "First",
      family = "Last",
      comment = c(ORCID = "YOUR-ORCID-ID"),
      email = "first.last@example.com",
      role = c("aut", "cre")
    )

  }
  else {
    usethis::use_author(
      given = given,
      family = family,
      comment = c(ORCID = ORCID_number),
      email = email,
      role = role
    )
  }
}
