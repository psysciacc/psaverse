% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/psa_add_documents.R
\name{psa_add_documents}
\alias{psa_add_documents}
\title{Create Folders in Project}
\usage{
psa_add_documents(
  folder = NULL,
  path = NULL,
  should_replace = FALSE,
  recursive = TRUE
)
}
\arguments{
\item{folder}{the folder to be added.
\itemize{
\item "ethics": creates the "01_Ethics" folder.
\item "power": creates the "02_Power" folder.
\item "materials": creates the "03_Materials" folder.
\item "procedure": creates the "04_Procedure" folder.
\item "data": creates the "05_Data" folder.
\item "analysis": creates the "06_Analysis" folder.
\item "communication": creates the "07_Communication folder.
\item "all": creates all eight main folders.
Any other parameter option will be added into the 08_Other folder.
}}
}
\description{
This function creates the requested folder according to the PSA project
folder structure: 01_Ethics, 02_Power, 03_Materials, 04_Procedure, 05_Data,
06_Analysis, 07_Communication, 08_Other, all within the inst folder.
If the argument is "all", creates all eight non-existing aforementioned
folders. If the requested folder(s) already exist(s), throws an error.
}
\examples{
\dontrun{
psa_create_folder("ethics")
psa_create_folder("all")
}
}
\keyword{create}
\keyword{folder}
