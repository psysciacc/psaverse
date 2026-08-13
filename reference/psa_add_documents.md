# Add Documents to Project

This function copies the requested file/directory to the specified
folder within the project folder structure. If the requested folder does
not already exist, it is created automatically.

## Usage

``` r
psa_add_documents(
  folder = NULL,
  path = NULL,
  should_replace = FALSE,
  recursive = FALSE
)
```

## Arguments

- folder:

  the folder to be added.

  - "ethics": creates the "01_Ethics" folder.

  - "power": creates the "02_Power" folder.

  - "materials": creates the "03_Materials" folder.

  - "procedure": creates the "04_Procedure" folder.

  - "data": creates the "05_Data" folder.

  - "analysis": creates the "06_Analysis" folder.

  - "communication": creates the "07_Communication folder. Any other
    parameter option will be added into the 08_Other folder.

- path:

  path of the requested file/directory. Must be a valid path within the
  current device.

- should_replace:

  whether the requested file must overwrite an already existing one
  within the project.

- recursive:

  whether directories should be copied recursively.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_add_documents(folder = "ethics",
  path = "~/Downloads")
psa_add_documents(folder = "ethics",
  path = "~/Downloads",
  recursive = TRUE)
} # }
```
