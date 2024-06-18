#' Create/Update PSA Project Description
#'
#' @param package_title new title for the package
#' @param description short description of package functionality
#' @param version version number of package (by default 0.0.0.9000)
#' @param license license type of package. Directly available options:
#' - MIT License: "MIT"
#' - Apache License 2.0: "Apache"
#' - GNU General Public License: "GPLv2" or "GPLv3"
#' - GNU Affero General Public License, version 3: "AGPLv3"
#' - GNU Lesser General Public License: "LGPLv2.1" or "LGPLv3"
#' - Creative Commons CC0 Public Domain Dedication: "CC0"
#' - Creative Commons Attribution 4.0 International: "CC-BY"
#' - Proprietary license: "Proprietary"
#'
#' Refer to the documentation on package licenses in the usethis package website for available licenses.
#'
#' @import usethis
#' @keywords create description
#'
#' @return NULL
#' @export
#' @example
#' #
psa_create_description <- function(
    package_title = NULL,
    description = NULL,
    version = NULL,
    license = NULL
    ) {

  proj_activate(proj_path())
  desc <- usethis:::proj_desc()

  fields_update <- list()
  if (!is.null(package_title)) {
    desc$set("Title", package_title)
  }

  if (!is.null(description)) {
    desc$set("Description", description)
  }

  if (!is.null(version)) {
    desc$set("Version", version)
  }

  # Update description file
  desc$write(file = "DESCRIPTION")

  # Set up requested license
  if (!is.null(license)) {
    select_license <- switch(license,
                             "MIT" = quote(use_mit_license()),
                             "Apache" = quote(use_apache_license()),
                             "GPLv2" = quote(use_gpl_license(2)),
                             "GPLv3" = quote(use_gpl3_license()),
                             "AGPLv3" = quote(use_agpl3_license()),
                             "LGPLv2.1" = quote(use_lgpl_license(2.1)),
                             "LGPLv3" = quote(use_lgpl_license(3)),
                             "CC0" = quote(use_cc0_license()),
                             "CC-BY" = quote(use_ccby_license()))
    if (!is.null(select_license)) {
      eval(select_license)
    }
  }


}

