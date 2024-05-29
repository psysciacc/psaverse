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
psa_dependencies <- function(
    scan_folder = "inst",
    add_package = NULL # has to be one at a time
    ) {

  if (!is.null()){

    use_package(add_package)

  } else {
    # get all the files in inst
    all.files <- list.files(
      path = scan_folder, # all folders in this project's inst
      recursive = TRUE,
      include.dirs = TRUE,
      pattern = "*.R|*.Rmd"
    )

    for (i in 1:length(all.files)){
      temp <- readLines(all.files[i])
      temp <- temp[grepl("library\\(.*\\)", temp)]
      temp <- gsub("library\\(|\\)", "", temp)

      sapply(temp, use_package)
    }
  }
}

