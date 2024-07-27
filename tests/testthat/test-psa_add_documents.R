# setup
tdir <- file.path(tempdir(), "PSA")
if (dir.exists(tdir)) unlink(tdir, recursive = TRUE)
dir.create(tdir, showWarnings = FALSE)
default_dir <- file.path(tdir, "PSA000-demo")

# make default project
psa_create_project(tdir)
proj_activate(default_dir)

test_that("single file, no overwrite", {
  # Create directory with test files somewhere else
  sample_dir <- file.path(tempdir(), "samples")
  dir.create(sample_dir, showWarnings = FALSE)
  sub_sample_dir <- file.path(sample_dir, "subsamples")
  dir.create(sub_sample_dir, showWarnings = FALSE)

  psa_create_folder("all")

  f1_path <- file.path(sample_dir, "test1.txt")
  file.create(f1_path)
  write("Test", f1_path)
  # Null folder argument should yield an error
  expect_error(psa_add_documents(folder = NULL, path = f1_path))

  # Move test1.txt to the project
  psa_add_documents(folder = "ethics", path = f1_path)
  expect_equal(file.exists(file.path("./inst/01_Ethics/test1.txt")), TRUE)
  psa_add_documents(folder = "power", path = f1_path)
  expect_equal(file.exists(file.path("./inst/02_Power/test1.txt")), TRUE)
  psa_add_documents(folder = "materials", path = f1_path)
  expect_equal(file.exists(file.path("./inst/03_Materials/test1.txt")), TRUE)
  psa_add_documents(folder = "procedure", path = f1_path)
  expect_equal(file.exists(file.path("./inst/04_Procedure/test1.txt")), TRUE)
  psa_add_documents(folder = "data", path = f1_path)
  expect_equal(file.exists(file.path("./inst/05_Data/test1.txt")), TRUE)
  psa_add_documents(folder = "analysis", path = f1_path)
  expect_equal(file.exists(file.path("./inst/06_Analysis/test1.txt")), TRUE)
  psa_add_documents(folder = "communication", path = f1_path)
  expect_equal(file.exists(file.path("./inst/07_Communication/test1.txt")), TRUE)

  psa_add_documents(folder = "extra", path = f1_path)
  expect_equal(file.exists(file.path("./inst/08_Other/extra/test1.txt")), TRUE)


  # Attempt to move non-existent file
  expect_warning(psa_add_documents(folder = "ethics", path = file.path(sample_dir, "test0.txt")))

  # Modify file and do NOT overwrite
  write("New test", f1_path, append = FALSE)
  psa_add_documents(folder = "ethics", path = f1_path, should_replace = TRUE)
  new_f1_path <- file.path("./inst/01_Ethics/test1.txt")
  expect_equal(file.exists(new_f1_path), TRUE)
  line <- readLines(new_f1_path, 1)
  expect_equal("New test", line)

  unlink("./inst", recursive = TRUE)
  unlink(sample_dir, recursive = TRUE)

})

test_that("single file, overwrite", {
  # Create directory with test files somewhere else
  sample_dir <- file.path(tempdir(), "samples")
  dir.create(sample_dir, showWarnings = FALSE)
  sub_sample_dir <- file.path(sample_dir, "subsamples")
  dir.create(sub_sample_dir, showWarnings = FALSE)

  psa_create_folder("all")

  f1_path <- file.path(sample_dir, "test1.txt")
  file.create(f1_path)
  write("Test", f1_path)

  psa_add_documents(folder = "ethics", path = f1_path)
  # Add file to project
  new_f1_path <- file.path("./inst/01_Ethics/test1.txt")
  expect_equal(file.exists(new_f1_path), TRUE)
  line <- readLines(new_f1_path, 1)
  expect_equal("Test", line)

  # Modify file and overwrite
  write("New test", f1_path, append = FALSE)
  psa_add_documents(folder = "ethics", path = f1_path, should_replace = TRUE)
  expect_equal(file.exists(new_f1_path), TRUE)
  line <- readLines(new_f1_path, 1)
  expect_equal("New test", line)


  unlink("./inst", recursive = TRUE)
  unlink(sample_dir, recursive = TRUE)
})

test_that("directory, no overwrite, recursive", {
  # Create directory with test files somewhere else
  sample_dir <- file.path(tempdir(), "samples")
  dir.create(sample_dir, showWarnings = FALSE)
  sub_sample_dir <- file.path(sample_dir, "subsamples")
  dir.create(sub_sample_dir, showWarnings = FALSE)

  # Create multiple test files and subdirectory
  f1_path <- file.path(sample_dir, "test1.txt")
  file.create(f1_path)
  write("Test", f1_path, append = FALSE)
  f2_path <- file.path(sample_dir, "test2.txt")
  file.create(f2_path)
  write("Test", f2_path, append = FALSE)
  f3_path <- file.path(sub_sample_dir, "test3.txt")
  file.create(f3_path)
  write("Test", f3_path, append = FALSE)

  psa_create_folder("all")

  # Copy samples directory to project
  psa_add_documents(folder = "ethics", path = sample_dir)

  # Verify existence of files
  new_sample_dir <- file.path("./inst/01_Ethics/samples")
  new_sub_sample_dir <- file.path("./inst/01_Ethics/samples/subsamples")
  expect_equal(dir.exists(new_sample_dir), TRUE)
  expect_equal(dir.exists(new_sub_sample_dir), TRUE)
  expect_equal(file.exists(file.path(new_sample_dir, "test1.txt")), TRUE)
  expect_equal(file.exists(file.path(new_sample_dir, "test2.txt")), TRUE)
  expect_equal(file.exists(file.path(new_sub_sample_dir, "test3.txt")), TRUE)

  # Verify file contents
  new_sample_dir <- file.path("./inst/01_Ethics/samples")
  new_sub_sample_dir <- file.path("./inst/01_Ethics/samples/subsamples")

  line1 <- readLines(file.path(new_sample_dir, "test1.txt"), 1)
  line2 <- readLines(file.path(new_sample_dir, "test2.txt"), 1)
  line3 <- readLines(file.path(new_sub_sample_dir, "test3.txt"), 1)

  expect_equal(line1, "Test")
  expect_equal(line2, "Test")
  expect_equal(line3, "Test")


  psa_add_documents(folder = "extra", path = sample_dir)

  new_sample_dir <- file.path("./inst/08_Other/extra/samples")
  new_sub_sample_dir <- file.path("./inst/08_Other/extra/samples/subsamples")
  expect_equal(dir.exists(new_sample_dir), TRUE)
  expect_equal(dir.exists(new_sub_sample_dir), TRUE)
  expect_equal(file.exists(file.path(new_sample_dir, "test1.txt")), TRUE)
  expect_equal(file.exists(file.path(new_sample_dir, "test2.txt")), TRUE)
  expect_equal(file.exists(file.path(new_sub_sample_dir, "test3.txt")), TRUE)

  # Verify file contents
  new_sample_dir <- file.path("./inst/08_Other/extra/samples")
  new_sub_sample_dir <- file.path("./inst/08_Other/extra/samples/subsamples")

  line1 <- readLines(file.path(new_sample_dir, "test1.txt"), 1)
  line2 <- readLines(file.path(new_sample_dir, "test2.txt"), 1)
  line3 <- readLines(file.path(new_sub_sample_dir, "test3.txt"), 1)

  expect_equal(line1, "Test")
  expect_equal(line2, "Test")
  expect_equal(line3, "Test")


  # Modify files and do NOT overwrite
  write("New test", f1_path, append = FALSE)
  write("New test", f2_path, append = FALSE)
  write("New test", f3_path, append = FALSE)

  psa_add_documents(folder = "extra", path = sample_dir)

  new_sample_dir <- file.path("./inst/01_Ethics/samples")
  new_sub_sample_dir <- file.path("./inst/01_Ethics/samples/subsamples")

  line1 <- readLines(file.path(new_sample_dir, "test1.txt"), 1)
  line2 <- readLines(file.path(new_sample_dir, "test2.txt"), 1)
  line3 <- readLines(file.path(new_sub_sample_dir, "test3.txt"), 1)

  expect_equal(line1, "Test") # Not overwritten
  expect_equal(line2, "Test")
  expect_equal(line3, "Test")

  unlink("./inst", recursive = TRUE)
  unlink(sample_dir, recursive = TRUE)

})

test_that("directory, overwrite, recursive", {
  # Create directory with test files somewhere else
  sample_dir <- file.path(tempdir(), "samples")
  dir.create(sample_dir, showWarnings = FALSE)
  sub_sample_dir <- file.path(sample_dir, "subsamples")
  dir.create(sub_sample_dir, showWarnings = FALSE)

  # Create multiple test files and subdirectory
  f1_path <- file.path(sample_dir, "test1.txt")
  file.create(f1_path)
  write("Test", f1_path, append = FALSE)
  f2_path <- file.path(sample_dir, "test2.txt")
  file.create(f2_path)
  write("Test", f2_path, append = FALSE)
  f3_path <- file.path(sub_sample_dir, "test3.txt")
  file.create(f3_path)
  write("Test", f3_path, append = FALSE)

  psa_create_folder("all")

  # Add files to project
  psa_add_documents(folder = "ethics", path = sample_dir)

  # Verify file contents
  new_sample_dir <- file.path("./inst/01_Ethics/samples")
  new_sub_sample_dir <- file.path("./inst/01_Ethics/samples/subsamples")

  line1 <- readLines(file.path(new_sample_dir, "test1.txt"), 1)
  line2 <- readLines(file.path(new_sample_dir, "test2.txt"), 1)
  line3 <- readLines(file.path(new_sub_sample_dir, "test3.txt"), 1)

  expect_equal(line1, "Test")
  expect_equal(line2, "Test")
  expect_equal(line3, "Test")

  # Modify and overwrite
  write("New test", f1_path, append = FALSE)
  write("New test", f2_path, append = FALSE)
  write("New test", f3_path, append = FALSE)

  # Overwrite samples directory in project
  psa_add_documents(folder = "ethics", path = sample_dir, should_replace = TRUE)

  new_sample_dir <- file.path("./inst/01_Ethics/samples")
  new_sub_sample_dir <- file.path("./inst/01_Ethics/samples/subsamples")

  line1 <- readLines(file.path(new_sample_dir, "test1.txt"), 1)
  line2 <- readLines(file.path(new_sample_dir, "test2.txt"), 1)
  line3 <- readLines(file.path(new_sub_sample_dir, "test3.txt"), 1)

  expect_equal(line1, "New test")
  expect_equal(line2, "New test")
  expect_equal(line3, "New test")

  unlink("./inst", recursive = TRUE)
  unlink(sample_dir, recursive = TRUE)

})


test_that("directory, no overwrite, no recursive", {
  # Create directory with test files somewhere else
  sample_dir <- file.path(tempdir(), "samples")
  dir.create(sample_dir, showWarnings = FALSE)
  sub_sample_dir <- file.path(sample_dir, "subsamples")
  dir.create(sub_sample_dir, showWarnings = FALSE)

  # Create multiple test files and subdirectory
  f1_path <- file.path(sample_dir, "test1.txt")
  file.create(f1_path)
  write("Test", f1_path, append = FALSE)
  f2_path <- file.path(sample_dir, "test2.txt")
  file.create(f2_path)
  write("Test", f2_path, append = FALSE)
  f3_path <- file.path(sub_sample_dir, "test3.txt")
  file.create(f3_path)
  write("Test", f3_path, append = FALSE)

  psa_create_folder("all")

  # Copy samples directory to project
  psa_add_documents(folder = "ethics", path = sample_dir, recursive = FALSE)
  print(list.files("./inst/01_Ethics"))

  new_sample_dir <- file.path("./inst/01_Ethics/samples")
  expect_equal(dir.exists(new_sample_dir), FALSE)
  expect_equal(file.exists(file.path("./inst/01_Ethics", "test1.txt")), TRUE)
  expect_equal(file.exists(file.path("./inst/01_Ethics", "test2.txt")), TRUE)

})



# clean up
unlink(default_dir, recursive = TRUE)
unlink(tdir, recursive = TRUE)
