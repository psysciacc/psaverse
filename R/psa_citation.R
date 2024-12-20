

psa_citation <- function(
    bibtype = "Article",
    title = "desc",
    author = "desc",
    journal = NULL,
    year = NULL,
    url = NULL,
    ...
) {

  # Set active project to user's project
  # Execute the base citation/bibentry function, with possibly some
  # extra things given by Erin
  proj_location <- usethis:::proj_path()
  setwd(proj_location)

  # Which parameters are the most important?
  # Title, author, year, possibly a url since we're citing a package
  # Should I pull things from the DESCRIPTION file? Can give a parameter to let
  # the user decide.

  # If executed twice in a row, does it overwrite the previous file (good)
  # or does it create another? (bad)

  # Create bibentry object based on parameters, then travel to inst folder,
  # create citation file there, print the bibentry object with style citation.

  pkg_citation <- bibentry(
    bibtype = bibtype,
    title = title,
    author = author,
    journal = journal,
    year = year,
    url = url,
    ... = ...
  )
  # Set up option from desc file later

  # Create citation file in inst folder
  if(!dir.exists(file.path(proj_location, "inst"))) {
    stop("/inst folder does not exist; please create /inst folder within main
         folder structure of the project.")
  }
  citation_file <- file.path(proj_location, "inst", "CITATION")
  if(!file.exists(citation_file)) {
    file.create(citation_file)
  }

  # Write info from bibentry object to file
  capture.output(print(pkg_citation, style = "R"),
                 file = citation_file,
                 append = FALSE)



}
