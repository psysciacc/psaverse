# Create a temporary directory for the test
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
