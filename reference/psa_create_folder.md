# Create Folders in Project

This function creates the requested folder according to the PSA project
folder structure: 01_Ethics, 02_Power, 03_Materials, 04_Procedure,
05_Data, 06_Analysis, 07_Communication, 08_Other, all within the inst
folder. If the argument is "all", creates all eight non-existing
aforementioned folders. If the requested folder(s) already exist(s),
throws an error.

## Usage

``` r
psa_create_folder(folder = NULL)
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

  - "communication": creates the "07_Communication"folder.

  - "all": creates all eight main folders. Any other parameter option
    will be added into the 08_Other folder.

## Examples

``` r
if (FALSE) { # \dontrun{
psa_create_folder("ethics")
psa_create_folder("all")
} # }
```
