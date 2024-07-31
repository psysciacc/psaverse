#' Add Documents to Project
#'
#' This function copies the requested file/directory to the specified folder within the project folder structure. If the requested folder does not already exist, it is created automatically.
#'
#' @param folder the folder to be added.
#' - "ethics": creates the "01_Ethics" folder.
#' - "power": creates the "02_Power" folder.
#' - "materials": creates the "03_Materials" folder.
#' - "procedure": creates the "04_Procedure" folder.
#' - "data": creates the "05_Data" folder.
#' - "analysis": creates the "06_Analysis" folder.
#' - "communication": creates the "07_Communication folder.
#' Any other parameter option will be added into the 08_Other folder.
#' @param path path of the requested file/directory. Must be a valid path within the current device.
#' @param should_replace whether the requested file must overwrite an already existing one within the project.
#' @param recursive whether directories should be copied recursively.
#'
#' @import usethis
#' @keywords add documents
#'
#' @return NULL
#' @export
#' @examples
#' \dontrun{
#' psa_add_documents(folder = "ethics", path = f1_path)
#' psa_add_documents(folder = "ethics", path = sample_dir, recursive = TRUE)
#' }
psa_add_documents <- function(
    folder = NULL, # where should it go
    path = NULL, # to a single file or directory
    should_replace = FALSE, # overwrite existing files?
    recursive = FALSE
    ) {

  if(is.null(folder)){ stop("Please define a folder name to copy files into.")}
  if(is.null(path)){ stop("Please specify a valid path to a file or directory.")}

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
  if(!dir.exists(file.path(proj_path, folder))) {
    dir.create(file.path(proj_path, folder))
  }

  # Check that path is valid
  if (!file.exists(path)) { stop("Please specify a valid path to a file or directory.")}

  # If path is a file, copy regardless of argument
  if (!file.info(path)$isdir) {
    file.copy(from = path,
              to = folder,
              overwrite = should_replace,
              recursive = recursive)
  }
  else if (recursive){
    # Path is a directory, copy recursively
    files_copy <- list.files(path = path,
                             full.names = TRUE,
                             include.dirs = TRUE,
                             recursive = recursive)
    sapply(files_copy, FUN = function(x){
      file.copy(from = x,
                to = folder,
                overwrite = should_replace,
                recursive = recursive)
    })

  }
  else {
    # get all the files in the directory
    files_copy <- list.files(path = path,
                             full.names = TRUE,
                             include.dirs = FALSE)
    files_copy <- files_copy[!file.info(files_copy)$isdir]
    sapply(files_copy, FUN = function(x){
      file.copy(from = x,
                to = folder,
                overwrite = should_replace,
                recursive = recursive)
    })

  }

}

