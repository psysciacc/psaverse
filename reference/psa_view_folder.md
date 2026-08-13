# View metadata for a folder

Allows you to view the metadata for a folder for a PSA project. Returns
a dataframe of the entered metadata from the readme file.

## Usage

``` r
psa_view_folder(folder = NULL)
```

## Arguments

- folder:

  what folder you want to view metadata for. Any of the following names
  can be used:

  - "ethics": "01_Ethics",

  - "power": "02_Power"

  - "materials": "03_Materials"

  - "procedure": "04_Procedure"

  - "data": "05_Data"

  - "analysis": "06_Analysis"

  - "communication": "07_Communication"

  - "other": "08_Other"

## Value

a dataframe of file information for the folder

## Examples
