#' usethis project description functions
#'
#' Quiet functions for our project
#'
#' @import usethis desc
#' @param path file path
proj_desc <- function(path = proj_get()) {
  desc::desc(file = path)
}

