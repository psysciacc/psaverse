#' Add data to a PSA package
#'
#' @param data the data as a data frame
#' @param title short title of the data
#' @param desc longer description of the data
#' @param vardesc list containing a vector of column names and labels (see faux::codebook for details)
#' @param author authors
#' @param source URL for the source, if blank, links to the file in data-raw
#' @param write whether to create/overwrite the package R file for this data set
#' @param filetype type of file to save data as in the R package
#' @param projdir base directory of project
#'
#' @return text of the R file
#' @export
#'
#' @examples
#'
#' \dontrun{
#'   # simulate a small data set
#'   demo <- data.frame(
#'     id = rep(1:3, each = 4),
#'     trial = rep(1:4, times = 3),
#'     condition = rep(c("ctl", "exp"), 6),
#'     rt = rnorm(12, 1000, 300)
#'   )
#'
#'   # set up variable descriptions
#'   vars <- list( description = c(
#'     id = "Subject identifier",
#'     trial = "Trial number",
#'     condition = "Trial condition (ctl or exp)",
#'     rt = "Reaction time in ms"
#'   ))
#'
#'   # add to package
#'   psa_data(data = demo,
#'            title = "Demo Data",
#'            desc = "Demonstrate how to add data to a PSA project",
#'            vardesc = vars)
#' }
psa_data <- function(data,
                     title,
                     desc,
                     vardesc = list(),
                     author = "PSA",
                     source = NULL,
                     write = TRUE,
                     filetype = "csv",
                     projdir = "." # fix this, how will we handle active repo?
                     ) {
  # checks ----
  if (!is.data.frame(data)) {
    stop("data must be in data frame format")
  }

  if (!dir.exists(file.path(projdir, "data-raw"))) {
    stop(paste0("The projdir (", projdir, ") does not contain a directory called 'data-raw'; are you sure you are saving to the right directory?"))
  }

  dataname <- deparse(substitute(data))
  reponame <- file.path(projdir, "..") |>
    normalizePath() |>
    basename()

  # this is awkward, but devtools::document won't work unless
  # the saved data has the name you intend to use for it
  dat <- list()
  dat[[dataname]] <- data
  list2env(dat, envir = environment())
  e <- paste0("usethis::use_data(", dataname, ", overwrite = TRUE)")
  eval(parse(text = e))

  # save data ----
  paste0(dataname, ".", filetype) |>
    file.path(projdir, "data-raw", x = _) |>
    rio::export(data, file = _)

  # make codebook and save ----
  cb <- suppressWarnings(
    faux::codebook(data,
                   vardesc = vardesc,
                   author = author,
                   name = title,
                   description = gsub("\n", " ", desc),
                   license = "CC-BY 4.0")
  )
  paste0(dataname, ".json") |>
    file.path(projdir, "data-raw", x = _) |>
    write(cb, file = _)

  # create Roxygen description ----
  itemdesc <- vardesc$description
  items <- paste0("#'    \\item{", names(itemdesc), "}{", itemdesc, "}")

  if (is.null(source)) source <- sprintf(
    "https://psysciacc.github.io/%s/data/%s.%s", # TODO: fix this
    reponame,
    dataname,
    filetype
  )

  s <- sprintf("# %s ----\n#' %s\n#'\n#' %s\n#'\n#' @format A data frame with %d rows and %d variables:\n#' \\describe{\n%s\n#' }\n#' @source \\url{%s}\n\"%s\"\n\n",
               dataname, title,
               gsub("\n+", "\n#'\n#' ", desc),
               nrow(data), ncol(data),
               paste(items, collapse = "\n"),
               source, dataname
  )
  if (!isFALSE(write)) {
    paste0("data_", dataname, ".R") |>
      file.path(projdir, "R", x = _) |>
      write(s, file = _)
  }

  invisible(s)
}
