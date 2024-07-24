# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

# make default project
psa_create_project(tdir)
proj_activate(default_dir)

test_that("no arguments", {
  expect_error(psa_create_folder())
})

test_that("individual folder from structure", {
  expect_equal(dir.exists("./inst"), FALSE)

  # Create non-existing folder
  psa_create_folder("ethics")

  expect_equal(dir.exists("./inst"), TRUE)
  expect_equal(dir.exists("./inst/01_Ethics"), TRUE)

  file.create("./inst/01_Ethics/test.txt")

  # Attempt to create folder again
  expect_error(psa_create_folder("ethics"))
  expect_equal(file.exists("./inst/01_Ethics/test.txt"), TRUE)
})

test_that("individual miscelaneous folder", {
  # Create non-existing folder
  psa_create_folder("annex")

  expect_equal(dir.exists("./inst/08_Other"), TRUE)
  expect_equal(dir.exists("./inst/08_Other/annex"), TRUE)

  file.create("./inst/08_Other/annex/test.txt")

  # Attempt to create folder again
  expect_error(psa_create_folder("annex"))
  expect_equal(file.exists("./inst/08_Other/annex/test.txt"), TRUE)
})

test_that("all folders", {
  # Create all folders when some already exist
  psa_create_folder("all")

  expect_equal(dir.exists("./inst/01_Ethics"), TRUE)
  expect_equal(dir.exists("./inst/02_Power"), TRUE)
  expect_equal(dir.exists("./inst/03_Materials"), TRUE)
  expect_equal(dir.exists("./inst/04_Procedure"), TRUE)
  expect_equal(dir.exists("./inst/05_Data"), TRUE)
  expect_equal(dir.exists("./inst/06_Analysis"), TRUE)
  expect_equal(dir.exists("./inst/07_Communication"), TRUE)
  expect_equal(dir.exists("./inst/08_Other"), TRUE)

  # Verify that files in existing folders are unchanged
  expect_equal(file.exists("./inst/01_Ethics/test.txt"), TRUE)
  expect_equal(file.exists("./inst/08_Other/annex/test.txt"), TRUE)

  # Attempt to create all folders when they all exist
  file.create("./inst/02_Power/test.txt")
  file.create("./inst/03_Materials/test.txt")
  file.create("./inst/04_Procedure/test.txt")
  file.create("./inst/05_Data/test.txt")
  file.create("./inst/06_Analysis/test.txt")
  file.create("./inst/07_Communication/test.txt")

  expect_error(psa_create_folder("all"))
  expect_equal(file.exists("./inst/01_Ethics/test.txt"), TRUE)
  expect_equal(file.exists("./inst/02_Power/test.txt"), TRUE)
  expect_equal(file.exists("./inst/03_Materials/test.txt"), TRUE)
  expect_equal(file.exists("./inst/04_Procedure/test.txt"), TRUE)
  expect_equal(file.exists("./inst/05_Data/test.txt"), TRUE)
  expect_equal(file.exists("./inst/06_Analysis/test.txt"), TRUE)
  expect_equal(file.exists("./inst/07_Communication/test.txt"), TRUE)
  expect_equal(file.exists("./inst/08_Other/annex/test.txt"), TRUE)

  # Create folders when none exist
  unlink("./inst/01_Ethics", recursive = TRUE, force = TRUE)
  unlink("./inst/02_Power", recursive = TRUE, force = TRUE)
  unlink("./inst/03_Materials", recursive = TRUE, force = TRUE)
  unlink("./inst/04_Procedure", recursive = TRUE, force = TRUE)
  unlink("./inst/05_Data", recursive = TRUE, force = TRUE)
  unlink("./inst/06_Analysis", recursive = TRUE, force = TRUE)
  unlink("./inst/07_Communication", recursive = TRUE, force = TRUE)
  unlink("./inst/08_Other", recursive = TRUE, force = TRUE)

  psa_create_folder("all")
  expect_equal(dir.exists("./inst/01_Ethics"), TRUE)
  expect_equal(dir.exists("./inst/02_Power"), TRUE)
  expect_equal(dir.exists("./inst/03_Materials"), TRUE)
  expect_equal(dir.exists("./inst/04_Procedure"), TRUE)
  expect_equal(dir.exists("./inst/05_Data"), TRUE)
  expect_equal(dir.exists("./inst/06_Analysis"), TRUE)
  expect_equal(dir.exists("./inst/07_Communication"), TRUE)
  expect_equal(dir.exists("./inst/08_Other"), TRUE)

})

# clean up
unlink(default_dir, recursive = TRUE)
unlink(tdir, recursive = TRUE)

