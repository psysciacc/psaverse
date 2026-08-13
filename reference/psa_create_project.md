# Create PSA Project

Use this function to initialize a PSA structured R project to put on
GitHub and share. Remember that file paths need to be either
"C:/Windows/blah" or "C:\Windows\blah" if you are using a Windows
machine.

## Usage

``` r
psa_create_project(
  path = "./",
  psa_name = "PSA000-demo",
  given = NULL,
  family = NULL,
  email = NULL,
  role = NULL,
  comment = NULL,
  open = FALSE
)
```

## Arguments

- path:

  path to directory where the local project will be

- psa_name:

  name of the repo (e.g., PSA000-demo)

- given:

  given name of first author

- family:

  family name of first author

- email:

  email address of first author

- role:

  role of first author, usually "aut" and "cre"; refer to the
  documentation for utils::person() for more details. You may only have
  one "cre" (maintainer).

- comment:

  additional information, e.g. ORCID number

- open:

  Defaults to FALSE, determine if you want to immediately open the new
  package in an RStudio window.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_create_project(path = "~/Downloads", psa_name = "PSA001-Faces")
psa_create_project(path = "C:\\Downloads", psa_name = "PSA001-Faces")
} # }
```
