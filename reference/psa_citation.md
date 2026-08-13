# Create PSA Citation for Project

Allows the user to create the citation for the GitHub and/or overall
project for users to cite the data and files.

## Usage

``` r
psa_citation(
  bibtype = "Article",
  title = "desc",
  author = "desc",
  journal = NULL,
  year = NULL,
  url = NULL,
  ...
)
```

## Arguments

- bibtype:

  a character string with a BibTeX entry type. See Entry Types for
  details.

- title:

  the title of the manuscript and/or title someone should use to cite
  this resource. The default argument is "desc", in which case the title
  will be pulled from the DESCRIPTION file.

- author:

  an author entry to include the author for citation. Please see the
  build project and/or update description for how to format author
  entries. The default argument is "desc", in which case the author(s)
  will be pulled from the DESCRIPTION file.

- journal:

  The journal or other location to cite for the project. If bibtype is
  "Article", this argument is mandatory.

- year:

  The year of the citation for the project.

- url:

  The url to include for the citation of the project.

- ...:

  Other information that can be passed to bibentry to add more details
  for the citation of the project.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_citation(
  bibtype = "Article",
  title = "My Package",
  author = "desc",
  journal = "My journal",
  year = 2000,
  url = "myurl.com"
)
} # }
```
