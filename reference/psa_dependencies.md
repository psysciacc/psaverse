# Add R package dependencies for analysis code

This function will look at all .R or .Rmd files for R packages to
include in the package dependencies list. You can tell it to scan a
specific folder - or use the default `inst` - or add a package directly.
If you use the `add_package` option, the `scan_folder` will be ignored.

## Usage

``` r
psa_dependencies(scan_folder = "inst", add_package = NULL)
```

## Arguments

- scan_folder:

  which folder should be examined for .R or .Rmd files to find package
  libraries

- add_package:

  Add a single or set of packages to the project, use c("package",
  "package") to include several at once.

## Examples

``` r
# psa_dependencies(scan_folder = "inst")
```
