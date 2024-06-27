#' Create Folders in Project
#'
#' This function creates the requested folder according to the PSA project
#' folder structure: 01_Ethics, 02_Power, 03_Materials, 04_Procedure, 05_Data,
#' 06_Analysis, 07_Communication, 08_Other, all within the inst folder.
#' If the argument is "all", creates all eight non-existing aforementioned
#' folders. If the requested folder(s) already exist(s), throws an error.
#'
#' @param folder the folder to be added.
#' - "ethics": creates the "01_Ethics" folder.
#' - "power": creates the "02_Power" folder.
#' - "materials": creates the "03_Materials" folder.
#' - "procedure": creates the "04_Procedure" folder.
#' - "data": creates the "05_Data" folder.
#' - "analysis": creates the "06_Analysis" folder.
#' - "communication": creates the "07_Communication folder.
#' - "all": creates all eight main folders.
#' Any other parameter option will be added into the 08_Other folder.
#'
#' @import usethis
#' @keywords create folder
#'
#' @return NULL
#' @export
#' @examples
#' \dontrun{
#' psa_create_folder("ethics")
#' psa_create_folder("all")
#' }
psa_add_documents <- function(
    folder = NULL, # where should it go
    path = NULL, # to a single file or directory
    should_replace = FALSE, # overwrite existing files?
    recursive = TRUE
    ) {

  if(is.null(folder)){ stop("Please define a folder name to copy files into.")}

  # Failsafe when psa_create_project does not create inst folder
  proj_path <- usethis:::proj_path()
  if(!dir.exists(paste0(proj_path, "/inst"))) {
    dir.create(paste0(proj_path, "/inst"))
  }

  folder <- switch(folder,
                   "ethics" = "inst/01_Ethics",
                   "power" = "inst/02_Power",
                   "materials" = "inst/03_Materials",
                   "procedure" = "inst/04_Procedure",
                   "data" = "inst/05_Data",
                   "analysis" = "inst/06_Analysis",
                   "communication" = "inst/07_Communication",
                   paste0("inst/08_Other/", folder)
  )

  # check directory exists
  if(!dir.exists(paste0(proj_path, "/", folder))) {
    dir.create(paste0(proj_path, "/", folder))
  }

  if (!is.null(path)){
    suppressWarnings(
      file.copy(from = path,
              to = folder,
              overwrite = should_replace,
              recursive = recursive)
    )
  }

}

