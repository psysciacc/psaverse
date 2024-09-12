# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)


# Create model folder to check on
test_path <- system.file("tests", "testthat", package = "psaverse")
file.copy(test_path, tdir, recursive = TRUE)
test_pkg <- file.path(tdir, "testthat", "testCheckFolder")

# Activate dummy package to use the function on it
usethis::proj_activate(test_pkg)

test_that("ethics", {
  expect_no_error(psa_check_folder(folder = "ethics"))
})

test_that("power", {
  expect_no_error(psa_check_folder(folder = "power"))
})

test_that("materials", {
  expect_no_error(psa_check_folder(folder = "materials"))
})

test_that("procedure", {
  expect_no_error(psa_check_folder(folder = "procedure"))
})

test_that("data", {
  expect_no_error(psa_check_folder(folder = "data"))
})

test_that("analysis", {
  expect_no_error(psa_check_folder(folder = "analysis"))
})

test_that("communication", {
  expect_no_error(psa_check_folder(folder = "communication"))
})

test_that("other", {
  expect_no_error(psa_check_folder(folder = "other"))
})

test_that("all", {
  expect_no_error(psa_check_folder(folder = "all"))
})

# clean up
unlink(tdir, recursive = TRUE)
