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

# Use ethics path as sample
ethics_path <- file.path(test_pkg, "inst", "01_Ethics")

test_that("error message with nonexistent folder", {
  bad_ethics_path <- file.path(test_pkg, "inst", "01_Ethic")
  expect_error(psa_create_metadata(bad_ethics_path, overwrite = TRUE))
})

test_that("file existent", {
  psa_create_metadata(ethics_path, overwrite = TRUE)
  expect_true(file.exists(file.path(ethics_path, "README.md")))
})

test_that("file lists match", {
  ethics_files_table <- psa_metadata_table(ethics_path)
  ethics_filenames <- ethics_files_table$name
  folder_filenames <- list.files(ethics_path, full.names = FALSE)
  # Verify that file lists contain the same elements
  expect_identical(sort(ethics_filenames), sort(folder_filenames))
})

# clean up
unlink(tdir, recursive = TRUE)
