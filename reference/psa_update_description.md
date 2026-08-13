# Create/Update PSA Project Description

Create/Update PSA Project Description

## Usage

``` r
psa_update_description(
  package_title = NULL,
  description = NULL,
  version = NULL,
  license = NULL
)
```

## Arguments

- package_title:

  new title for the package

- description:

  short description of package functionality

- version:

  version number of package (by default 0.0.0.9000)

- license:

  license type of package. Directly available options:

  - MIT License: "MIT"

  - Apache License 2.0: "Apache"

  - GNU General Public License: "GPLv2" or "GPLv3"

  - GNU Affero General Public License, version 3: "AGPLv3"

  - GNU Lesser General Public License: "LGPLv2.1" or "LGPLv3"

  - Creative Commons CC0 Public Domain Dedication: "CC0"

  - Creative Commons Attribution 4.0 International: "CC-BY"

  - Proprietary license: "Proprietary"

  Refer to the documentation on package licenses in the usethis package
  website for available licenses.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_update_description(
 package_title = "New Title",
 description = "Short description",
 version = "0.0.1.0000",
 license = "MIT"
)
} # }
#
```
