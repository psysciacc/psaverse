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
#' - "communication": creates the "07_Communication"folder.
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
psa_create_folder <- function(
    folder = NULL
    ) {

  if(is.null(folder)){ stop("Please define a folder name or
                            use 'all' to create all folders.")}

  # Failsafe when psa_create_project does not create inst folder
  proj_path <- usethis:::proj_path()
  if(!dir.exists(paste0(proj_path, "/inst"))) {
    dir.create(paste0(proj_path, "/inst"))
  }

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

