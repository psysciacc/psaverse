#' Add Author Info to PSA Project
#'
#' @description
#' Adds a person information to the `Authors@R` section of the DESCRIPTION
#' file, creating that field if necessary. Acts as a wrapper for the function
#' usethis::use_author() function.
#'
#'
#' @inheritParams usethis::use_author()
#'
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
#'   comment = c(ORCID = "LUCY-ORCID-ID")
#' }
#'
#'
psa_add_author <- function(...) {
  usethis::use_author(...)
}
