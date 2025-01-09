# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)

# Define the source path and ensure the files exist
# Locate the test path
test_path <- system.file("test-assets", "testCheckFolder", package = "psaverse")

# Fallback for development (when running `devtools::test()` locally)
if (test_path == "" || !dir.exists(test_path)) {
  test_path <- file.path("inst", "test-assets", "testCheckFolder")
}

# Ensure the test path exists
if (!dir.exists(test_path)) {
  stop("The test path does not exist: ", test_path)
}

# Copy the test files to the temporary directory
file.copy(test_path, tdir, recursive = TRUE)
test_pkg <- file.path(tdir, "testCheckFolder")

# Ensure the copied path exists
if (!dir.exists(test_pkg)) {
  dir.create(test_pkg, recursive = TRUE)
}

# Activate the dummy package for testing
usethis::proj_activate(test_pkg)

# Use ethics path as sample
ethics_path <- file.path(test_pkg, "inst", "01_Ethics")

test_that("error message with nonexistent folder", {
  bad_ethics_path <- file.path(test_pkg, "inst", "01_Ethic")
  expect_error(psa_create_metadata(bad_ethics_path, overwrite = TRUE))
})

test_that("file existent", {
  psa_create_metadata("ethics", overwrite = TRUE)
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
