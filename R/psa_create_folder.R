#' Add R package dependencies for analysis code
#'
#' This function will look at all .R or .Rmd files for
#' R packages to include in the package dependencies list.
#' You can tell it to scan a specific folder - or use the
#' default `inst` - or add a package directly. If you
#' use the `add_package` option, the `scan_folder` will
#' be ignored.
#'
#' @param scan_folder which folder should be examined for .R or .Rmd
#'  files to find package libraries
#' @param add_package Add a single package directly
#'
#' @import usethis
#' @keywords dependencies
#'
#' @return NULL
#' @export
#' @examples
#' # psa_dependencies(scan_folder = "inst")
psa_create_folder <- function(
    folder = NULL
    ) {

  if(is.null(folder)){ stop("Please define a folder name or
                            use 'all' to create all folders.")}

  folder <- switch(folder,
                   "ethics" = "01_Ethics",
                   "power" = "02_Power",
                   "materials" = "03_Materials",
                   "procedure" = "04_Procedure",
                   "data" = "05_Data",
                   "analysis" = "06_Analysis",
                   "communication" = "07_Communication",
                   folder
  )


  default_folders <- c("01_Ethics", "02_Power", "03_Materials",
                        "04_Procedure", "05_Data", "06_Analysis",
                        "07_Communication", "08_Other")

  if (folder == "all"){
    folders_create <- default_folders
  } else {
    folders_create <- folder
  }

  # if not in list, put into other
  extra_folder <- folders_create[!folders_create %in% default_folders]

  if (length(extra_folder) > 0){
    folders_create <- c(folders_create[folders_create %in% default_folders],
                        paste0("08_Other/", extra_folder))

    if (!dir.exists(paths = paste0("inst/", "08_Other"))){
      folders_create <- c("08_Other", folders_create)
      folders_create <- unique(folders_create)
    }
  }

  # check they don't exist already
  dir_there <- dir.exists(paths = paste0("inst/", folders_create))
  folders_create <- folders_create[!dir_there]

  if (length(folders_create) < 1) { stop("All folders exist.") }

  # make the folders
  sapply(folders_create,
         function(x) { dir.create(path = paste0("inst/", x)) } )

}

