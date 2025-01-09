# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

# Creating project with default arguments
psa_create_project(tdir)
usethis::proj_activate(default_dir)

test_that("example", {

  psa_add_author(
    given = "Ada",
    family = "Lovelace",
    ORCID_number = "ADA-ORCID-ID",
    role = c("aut", "cre"),
    email = "lovelace@example.com"
  )

  psa_add_author(
    given = "Charles",
    family = "Babbage",
    ORCID_number = "CHARLES-ORCID-ID",
    role = c("aut", "cre"),
    email = "babbage@example.com"
  )

  desc <- proj_desc()
  expect_equal(as.character(desc$get_authors()[[1]]), "Ada Lovelace <lovelace@example.com> [aut, cre] (ADA-ORCID-ID)")
  expect_equal(as.character(desc$get_authors()[[2]]), "Charles Babbage <babbage@example.com> [aut, cre] (CHARLES-ORCID-ID)")

  # clean up
  unlink(default_dir, recursive = TRUE)

})

# clean up
unlink(tdir, recursive = TRUE)
