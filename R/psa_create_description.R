#' Create PSA Project Description
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#'
#' @import usethis
#' @keywords create description
#'
#' @return NULL
#' @export
#' @example
#' #
psa_create_description <- function(
    package_title = NULL,
    description = NULL,
    version = NULL,
    license = NULL
    ) {

  # figure out which ones they want and add them to a list
  fields_update <- list()
  if (!is.null(package_title)) {
    fields_update$Title <- package_title
  }

  #

  use_description(
    fields = fields_update,
    check_name = FALSE
  )

}

