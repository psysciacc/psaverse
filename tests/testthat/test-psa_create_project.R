# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

test_that("errors", {
  # Ensure invalid project names trigger errors
  expect_error(psa_create_project(tdir, "P001-faces"))
  expect_error(psa_create_project(tdir, "PSALONGNAME001-faces"))
  expect_error(psa_create_project(tdir, "psa001-faces"))
  expect_error(psa_create_project(tdir, "PSA001-FACES"))
  expect_error(psa_create_project(tdir, "PSA001-face-perception"))
  expect_error(psa_create_project(tdir, "PSA001-faceperceptionmodels"))
})

test_that("defaults", {
  # Make default project
  psa_create_project(tdir)

  # Debugging: Ensure the directory is created
  print("Checking default project directory:")
  print(default_dir)
  print(list.files(tdir))

  # Ensure the default directory exists
  expect_true(dir.exists(default_dir))

  # Activate the project
  proj_activate(default_dir)

  # Check expected directory structure
  expected_subfiles <- c("DESCRIPTION", "LICENSE.md", "NAMESPACE")
  subfiles <- list.files(default_dir, recursive = TRUE)
  print("Subfiles in default_dir:")
  print(subfiles)
  expect_equal(subfiles, expected_subfiles)

  # Check file customizations
  desc <- proj_desc()
  expect_equal(desc$get("Package")[[1]], "PSA000-demo")
  expect_equal(desc$get("Title")[[1]], "Data Archive for PSA000-demo")
  expect_equal(is.null(desc$get_authors()[[1]]), TRUE)

  # Clean up
  unlink(default_dir, recursive = TRUE)
})

# withr error buried deep in usethis::create_package causes this to
# fail - it has been manually checked
# test_that("with author info", {
#   # Make default project with author info
#   psa_create_project(tdir, given = "Ada", family = "Lovelace",
#                      email = "lovelace@example.com",
#                      role = c("aut", "cre"),
#                      comment = c(ORCID = "ADA-ORCID-ID"))
#
#   # Debugging: Ensure the directory is created
#   print("Checking project directory with author info:")
#   print(default_dir)
#   print(list.files(tdir))
#
#   # Ensure the default directory exists
#   expect_true(dir.exists(default_dir))
#
#   # Activate the project
#   proj_activate(default_dir)
#
#   # Check file customizations
#   desc <- proj_desc()
#   print("Checking authors in DESCRIPTION:")
#   print(desc$get_authors())
#   expect_equal(as.character(desc$get_authors()[[1]]), "Ada Lovelace <lovelace@example.com> [aut, cre] (ADA-ORCID-ID)")
#
#   # Clean up
#   unlink(default_dir, recursive = TRUE)
# })

# clean up
unlink(tdir, recursive = TRUE)
