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

# Activate dummy package to use the function on it
setwd(test_pkg)
usethis::proj_activate(test_pkg)


test_that("CITATION file is correctly created", {

  psa_citation(bibtype = "Article",
               title = "My package",
               author = utils::person(given = "John", family = "Doe"),
               journal = "My journal",
               year = 2000,
               url = "johndoe.com")

  expect_no_error(writeLines(readLines(file.path(test_pkg, "inst", "CITATION"))))
})


test_that("CITATION file is correctly updated", {
  psa_citation(bibtype = "Article",
               title = "My package",
               author = utils::person(given = "John", family = "Doe"),
               journal = "My journal",
               year = 2000,
               url = "johndoe.com")

  psa_citation(bibtype = "Article",
               title = "My new package",
               author = utils::person(given = "John", family = "Doe"),
               journal = "My new journal",
               year = 2000,
               url = "johndoe.com")
  expect_no_error(writeLines(readLines(file.path(test_pkg, "inst", "CITATION"))))
})


test_that("Adding info from DESCRIPTION file", {

  psa_update_description(package_title = "My new title from desc")
  psa_add_author(given = "Charles",
                 family = "Babbage",
                 ORCID_number = "0000-0000-0000-0002",
                 email = "charles@email.com",
                 role = "aut")

  psa_citation(bibtype = "Article",
               title = "desc",
               author = "desc",
               journal = "My new journal",
               year = 2000,
               url = "johndoe.com")

  expect_no_error(writeLines(readLines(file.path(test_pkg, "inst", "CITATION"))))
})

# clean up
unlink(tdir, recursive = TRUE)
