# Create Metadata for each folder

Takes a folder from inst (that is, O1_Ethics, O2_Power, etc.), and
outputs a README file with the filenames of every file/subfolder from
the given folder, also indicating whether they are files or subfolders.
A space for modifying a description for every file is also created.

## Usage

``` r
psa_create_metadata(folder, overwrite = FALSE)
```

## Arguments

- folder:

  name of the folder to be documented. If not "ethics", "power", ...,
  "other", must supply full path of the folder.

- overwrite:

  TRUE/FALSE variable for if you want to overwrite a previously created
  metadata file.

## Examples

``` r
if (FALSE) { # \dontrun{
  psa_create_metadata(ethics, overwrite = TRUE)
} # }
```
