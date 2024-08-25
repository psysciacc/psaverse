
test_that("ethics", {
  # Create model folder to check on
  test_path <- system.file("tests", "testthat", package = "psaverse")
  ethics_test <- file.path(test_path, "testCheckFolder")

  # Activate dummy package to use the function on it
  usethis::proj_activate(ethics_test)

  psa_check_folder(folder = "ethics")

})
