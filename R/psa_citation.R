

psa_citation <- function(
    bibtype = "Article",
    title = "desc",
    author = "desc",
    journal = NULL,
    year = NULL,
    url = NULL,
    ...
) {

  proj_location <- usethis:::proj_path()
  setwd(proj_location)



  # Read description file and find author and title info
  if(title == "desc" || author == "desc") {
    if(!file.exists(file.path(proj_location, "DESCRIPTION"))) {
      stop("DESCRIPTION file does not exist: manually indicate title and
           author information or create DESCRIPTION file.")
    }
    desc <- usethis:::proj_desc()
    if(title == "desc") {
      title <- desc$get("Title")
    }
    if(author == "desc") {
      author <- desc$get_authors()
    }
  }

  pkg_citation <- bibentry(
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
