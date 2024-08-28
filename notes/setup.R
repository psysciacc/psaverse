library(usethis)
library(devtools)
library(roxygen2)

roxygenize()

devtools::check()

devtools::install_github("psysciacc/psaverse@check-folder")
