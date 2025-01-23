# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
projdir <- file.path(tdir, "PSA000-demo")
psa_create_project(tdir)
setwd(projdir)
dir.create(paste0(projdir, "/inst"))

test_that("demo", {
  # simulate an R file
  demo <- "
  library(dplyr)
  "
  writeLines(text = demo,
             con = file.path(projdir, "inst", "code.R"))

  expect_true(
    file.exists(
      file.path(projdir, "inst", "code.R")
    )
  )

  psa_dependencies(scan_folder = "inst",
                   add_package = NULL)

  # check file customisations
  desc <- readLines(file.path(projdir, "DESCRIPTION"))
  expect_equal(desc[[1]], "Package: PSA000-demo")
  expect_equal(desc[[2]], "Title: Data Archive for PSA000-demo")

  expect_true(as.logical(sum(grepl("dplyr", desc))))

  unlink(projdir, recursive = TRUE)

})

# clean up
unlink(tdir, recursive = TRUE)
