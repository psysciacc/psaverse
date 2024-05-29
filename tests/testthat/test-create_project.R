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

  proj_activate(default_dir)

  # check if default directory exists
  existing_files <- list.files(tdir)
  expect_true(dir.exists(default_dir))

  # check expected directory structure
  expected_subfiles <- c("DESCRIPTION", "LICENSE.md", "NAMESPACE")
  subfiles <- list.files(default_dir, recursive = TRUE)
  expect_equal(subfiles, expected_subfiles)

  # check file customisations
  desc <- usethis:::proj_desc()
  expect_equal(desc$get("Package")[[1]], "PSA000-demo")
  expect_equal(desc$get("Title")[[1]], "Data Archive for PSA000-demo")

  # clean up
  unlink(default_dir, recursive = TRUE)
})

test_that("with author info", {
  # make default project
  psa_create_project(tdir, given = "Ada", family = "Lovelace",
                     email = "lovelace@example.com",
                     role = c("aut", "cre"),
                     comment = c(ORCID = "ADA-ORCID-ID"))

  proj_activate(default_dir)

  # check if default directory exists
  existing_files <- list.files(tdir)
  expect_true(dir.exists(default_dir))

  # check file customisations
  desc <- usethis:::proj_desc()
  expect_equal(desc$get_authors(), person(given = "Ada", family = "Lovelace",
                                          email = "lovelace@example.com",
                                          role = c("aut", "cre"),
                                          comment = c(ORCID = "ADA-ORCID-ID")))

  # clean up
  unlink(default_dir, recursive = TRUE)
})

# clean up
unlink(tdir, recursive = TRUE)
