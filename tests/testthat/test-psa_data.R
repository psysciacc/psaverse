# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
projdir <- file.path(tdir, "PSA000-demo")
psa_create_project(tdir)
setwd(projdir)

test_that("demo", {
  # simulate a small data set
  demo <- data.frame(
    id = rep(1:3, each = 4),
    trial = rep(1:4, times = 3),
    condition = rep(c("ctl", "exp"), 6),
    rt = rnorm(12, 1000, 300)
  )

  # set up variable descriptions
  vars <- list( description = c(
    id = "Subject identifier",
    trial = "Trial number",
    condition = "Trial condition (ctl or exp)",
    rt = "Reaction time in ms"
  ))

  rtext <- psa_data(
    data = demo,
    title = "Demo Data",
    desc = "Demonstrate how to add data to a PSA project",
    vardesc = vars
  )

  csv <- file.path(projdir, "data-raw", "demo.csv")
  json <- file.path(projdir, "data-raw", "demo.json")
  r <- file.path(projdir, "R", "data_demo.R")
  expect_true(file.exists(csv))
  expect_true(file.exists(json))
  expect_true(file.exists(r))

  # check data saved correctly
  data_csv <- read.csv(csv)
  expect_equal(demo, data_csv)

  # check json file contents

  # check R file contents
})

# clean up
unlink(tdir, recursive = TRUE)
