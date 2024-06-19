#' Add R package to PsySciAcc Organization
#'
#' This function will initialize the use of github
#' and direct the package to be included in the
#' PsySciAcc organization. You can then use RStudio's
#' built in git push/pull, the command line, or your
#' favorite gui desktop app to push and pull to
#' github.
#'
#' @param organisation should be "psysciacc" - please
#' note you should confirm you have the priveleges
#' to push to the organization first
#' @param private a TRUE/FALSE variable with the
#' default to start as private until you are ready
#' to release the project package.
#'
#' @import usethis
#' @keywords github
#'
#' @return NULL
#' @export
#' @examples
#' # psa_git()
psa_git <- function(
    organisation = "psysciacc",
    private = TRUE,
    ) {

  use_github(
    organisation = organisation,
    private = private,
  )

}

