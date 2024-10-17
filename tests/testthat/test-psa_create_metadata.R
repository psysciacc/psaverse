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

test_that("example", {
  ethics_path <- file.path(test_pkg, "inst", "01_Ethics")
  psa_create_metadata(ethics_path, overwrite = TRUE)
  cat(readLines(file.path(ethics_path, "README.md")), sep = '\n')
})

# clean up
unlink(tdir, recursive = TRUE)
