#' Create PSA Citation for Project
#'
#' Allows the user to create the citation for the GitHub and/or
#' overall project for users to cite the data and files.
#'
#' @param bibtype	a character string with a BibTeX entry type.
#' See Entry Types for details.
#' @param title the title of the manuscript and/or title someone
#' should use to cite this resource. The default argument is "desc",
#' in which case the title will be pulled from the DESCRIPTION file.
#' @param author an author entry to include the author for citation.
#' Please see the build project and/or update description for
#' how to format author entries. The default argument is "desc",
#' in which case the author(s) will be pulled from the DESCRIPTION file.
#' @param journal The journal or other location to cite for the
#' project. If bibtype is "Article", this argument is mandatory.
#' @param year The year of the citation for the project.
#' @param url The url to include for the citation of the project.
#' @param ... Other information that can be passed to bibentry to
#' add more details for the citation of the project.
#'
#' @import usethis rbibutils backports
#' @keywords create citation
#'
#' @return NULL
#' @export
#'
#' @examples
#' \dontrun{
#' psa_citation(
#'   bibtype = "Article",
#'   title = "My Package",
#'   author = "desc",
#'   journal = "My journal",
#'   year = 2000,
#'   url = "myurl.com"
#' )
#' }
#'

psa_citation <- function(
    bibtype = "Article",
    title = "desc",
    author = "desc",
    journal = NULL,
    year = NULL,
    url = NULL,
    ...
) {

  proj_location <- usethis::proj_path()
  setwd(proj_location)

  # Read description file and find author and title info
  if(title == "desc" || author == "desc") {
    if(!file.exists(file.path(proj_location, "DESCRIPTION"))) {
      stop("DESCRIPTION file does not exist: manually indicate title and
           author information or create DESCRIPTION file.")
    }
    desc <- proj_desc()
    if(title == "desc") {
      title <- desc$get("Title")
    }
    if(author == "desc") {
      author <- desc$get_authors()
    }
  }

  pkg_citation <- utils::bibentry(
    bibtype = bibtype,
    title = title,
    author = author,
    journal = journal,
    year = year,
    url = url,
    ... = ...
  )

  if(!dir.exists(file.path(proj_location, "inst"))) {
    stop("/inst folder does not exist; please create /inst folder within main
         folder structure of the project.")
  }
  citation_file <- file.path(proj_location, "inst", "CITATION")
  if(!file.exists(citation_file)) {
    file.create(citation_file)
  }

  capture.output(print(pkg_citation, style = "R"),
                 file = citation_file,
                 append = FALSE)



}
