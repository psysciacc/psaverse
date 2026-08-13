# Check PSA Project Folder Structure

Checks the current project's folder structure according to the PSAVerse
standard structure, either one project folder (i.e., 01_Ethics,
02_Power, etc.) at a time, or everything at once.

## Usage

``` r
psa_check_folder(folder = "all")
```

## Arguments

- folder:

  name of the folder to check, or "all" to check all folders.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_check_folder("ethics")
psa_check_folder("all")
} # }
```
