test_that("defaults", {
  tdir <- tempdir()
  psa_create_project(tdir)
  existing_files <- list.files(tdir)
  expect_true("PSA000-demo" %in% existing_files)
})
