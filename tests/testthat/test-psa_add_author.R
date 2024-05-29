# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

# Creating project with default arguments
psa_create_project(tdir)
usethis::proj_activate(default_dir)

test_that("example", {

  # Empty test, examining function behavior
  psa_add_author(
    given = "Ada",
    family = "Lovelace",
    role = c("aut", "cre"),
    email = "lovelace@example.com",
    comment = c(ORCID = "ADA-ORCID-ID")
  )

  desc <- readLines(file.path(default_dir, "DESCRIPTION"))
  for (item in 1:length(desc)) {
    print(desc[[item]])
  }

  # clean up
  unlink(default_dir, recursive = TRUE)

})

# clean up
unlink(tdir, recursive = TRUE)
