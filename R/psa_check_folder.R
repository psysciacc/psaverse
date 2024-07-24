#' Create PSA Project
#'
#' DESCRIPTION
#' ADD INFORMATION ABOUT \\ OR / FOR WINDOWS
#'
#' @param path path to directory where the local project will be
#' @param psa_name name of the repo (e.g., PSA000-demo)
#'
#' @import usethis
#' @keywords create project
#'
#' @return NULL
#' @export

psa_check_folder <- function(folder = "all"){

  if (folder == "ethics" | folder == "all"){
    file_list <- list.files(
      path = "inst/01_Ethics",
      recursive = TRUE
    )

    # this is probably a mess
    look_for <- c("^PI_IRB/.+", "README.md")
    for (i in 1:length(look_for)){
      if (sum(grepl(look_for[i], file_list)) == 0){
        usethis::ui_todo(paste0("You need to include ", look_for[i]))
      }
    }
  }

}
