# Add Author Info to PSA Project

Adds a person information to the `Authors@R` section of the DESCRIPTION
file, creating that field if necessary. Acts as a wrapper for the
function usethis::use_author() function.

## Usage

``` r
psa_add_author(
  given = NULL,
  family = NULL,
  ORCID_number = NULL,
  email = NULL,
  role = NULL
)
```

## Arguments

- given:

  given name of author

- family:

  family name of author

- ORCID_number:

  ORCID number associated with author

- email:

  email address of author

- role:

  vector containing roles of author in the project, usually "aut" and
  "cre"; refer to utils::person() documentation for more information.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_add_author(
  given = "Lucy",
  family = "van Pelt",
  role = c("aut", "cre"),
  email = "lucy@example.com",
  ORCID_number = "LUCY-ORCID-ID")
} # }

```
