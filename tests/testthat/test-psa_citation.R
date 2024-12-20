# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)


# Create model folder to check on
test_path <- system.file("tests", "testthat", package = "psaverse")
file.copy(test_path, tdir, recursive = TRUE)
test_pkg <- file.path(tdir, "testthat", "testCheckFolder")

# Activate dummy package to use the function on it
setwd(test_pkg)
usethis:::proj_activate(test_pkg)

# CITATION file still not created
psa_citation(bibtype = "Article",
             title = "My package",
             author = person(given = "John", family = "Doe"),
             journal = "My journal",
             year = 2000,
             url = "johndoe.com")

# Check correct contents of file
test_that("CITATION file is correctly created", {
  expect_no_error(writeLines(readLines(file.path(test_pkg, "inst", "CITATION"))))
})

# CITATION file already created
psa_citation(bibtype = "Article",
             title = "My new package",
             author = person(given = "John", family = "Doe"),
             journal = "My new journal",
             year = 2000,
             url = "johndoe.com")

# Check correct contents of file
test_that("CITATION file is correctly updated", {
  expect_no_error(writeLines(readLines(file.path(test_pkg, "inst", "CITATION"))))
})

# clean up
unlink(tdir, recursive = TRUE)
