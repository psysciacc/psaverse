# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

# Creating project with default arguments
psa_create_project(tdir)
usethis::proj_activate(default_dir)

test_that("example with license", {

  psa_update_description(
    package_title = "New Title",
    description = "Short description",
    version = "0.0.1.0000",
    license = "MIT"
  )

  desc <- usethis:::proj_desc(default_dir)

  expect_equal(desc$get("Title")[[1]], "New Title")
  expect_equal(desc$get("Description")[[1]], "Short description")
  expect_equal(desc$get("Version")[[1]], "0.0.1.0000")
  expect_equal(desc$get("License")[[1]], "MIT + file LICENSE")

})

test_that("example without license", {

  psa_update_description(
    package_title = "New Title 2",
    description = "Short description 2"
  )

  desc <- usethis:::proj_desc(default_dir)

  expect_equal(desc$get("Title")[[1]], "New Title 2")
  expect_equal(desc$get("Description")[[1]], "Short description 2")
  expect_equal(desc$get("Version")[[1]], "0.0.1.0000")
})

# clean up
unlink(default_dir, recursive = TRUE)
unlink(tdir, recursive = TRUE)
