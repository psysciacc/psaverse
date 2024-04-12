# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

test_that("errors", {
  expect_error(psa_create_project(tdir, "P001-faces"))
  expect_error(psa_create_project(tdir, "PSALONGNAME001-faces"))
  expect_error(psa_create_project(tdir, "psa001-faces"))
  expect_error(psa_create_project(tdir, "PSA001-FACES"))
  expect_error(psa_create_project(tdir, "PSA001-face-perception"))
  expect_error(psa_create_project(tdir, "PSA001-faceperceptionmodels"))
})

test_that("defaults", {
  # make default project
  psa_create_project(tdir)

  # check if default directory exists
  existing_files <- list.files(tdir)
  expect_true(dir.exists(default_dir))

  # check expected directory structure
  expected_subfiles <- c("DESCRIPTION")
  subfiles <- list.files(default_dir, recursive = TRUE)
  expect_equal(subfiles, expected_subfiles)

  # check file customisations
  desc <- readLines(file.path(default_dir, "DESCRIPTION"))
  # expect_equal(desc[[1]], "Package: PSA000")
  # expect_equal(desc[[2]], "Title: Data Archive for PSA000")
  # expect_equal(desc[[8]], "License: CC BY 4.0")

  # clean up
  unlink(default_dir, recursive = TRUE)
})

# clean up
unlink(tdir, recursive = TRUE)
