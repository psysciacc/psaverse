#' Add R package dependencies for analysis code
#'
#' This function will look at all .R or .Rmd files for
#' R packages to include in the package dependencies list.
#' You can tell it to scan a specific folder - or use the
#' default `inst` - or add a package directly. If you
#' use the `add_package` option, the `scan_folder` will
#' be ignored.
#'
#' @param scan_folder which folder should be examined
#' for .R or .Rmd files to find package libraries
#' @param add_package Add a single or set of packages
#' to the project, use c("package", "package") to
#' include several at once.
#'
#' @import usethis
#' @keywords dependencies
#'
#' @return NULL
#' @export
#' @examples
#' # psa_dependencies(scan_folder = "inst")
psa_dependencies <- function(
    scan_folder = "inst",
    add_package = NULL
    ) {

  if (!is.null(add_package)){

    for (i in 1:length(add_package)){
      usethis::use_package(add_package[i])
    }

  } else {
    # get all the files in inst
    all.files <- list.files(
      path = scan_folder, # all folders in this project's inst
      recursive = TRUE,
      include.dirs = TRUE,
      full.names = TRUE,
      pattern = "*.R|*.Rmd|*.qmd"
    )

    for (i in 1:length(all.files)){
      temp <- readLines(all.files[i])
      temp <- strsplit(temp, split = ";")
      temp <- unlist(temp)
      temp <- temp[grepl("library\\(.*\\)", temp)]
      temp <- gsub("library\\(|\\)", "", temp)
      temp <- trimws(temp)
      temp <- unique(temp)

      sapply(temp, use_package)
    }
  }
}

