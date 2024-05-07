# PSAverse discussions

## May 7 2024

### Folders 

- Make this as a general function 
  - `psa_create_folder(folder = "ethics")`
    - arguments for what folder you are adding documents 
    - create the folder and the readme for that folder 
    - if it's one of these keywords, then make it specifically
      - ethics = 01_Ethics
      - power = 02_Power
      - materials = 03_Materials
      - procedure = 04_Procedure
      - data = 05_Data
      - analysis = 06_Analysis
      - communication = 07_Communication
    - any other keyword
      - put automatically into 08_Other 
- Make specific functions 
  - `psa_check_folder(folder = "ethics")`: users should use this one 
    - check what files are in the folder 
    - spit out an example readme for the person to fill in
    - note if anything appears missing (within limits)
    - check if specific labeling is applied 
  - `psa_check_*()` for each folder with the rules 

### Functionality 

- Other functions
  - `psa_citation()`: pick a file to get the citation for --> this would be a function to add that function to the project 
  - `psa_load_data()`: ways to load data from the project 
  - `psa_meta_data()`: ways to load information on the project, not citation style 

For example: load_data

## Project Manager 

  - `build_available_data()`: for the package it would be a function that reads the data folder and creates a CSV or something that gets it into the right structure for them to edit (helping the person building the package to create the file that available data needs to run)

## User of the Package 

  - `available_data()`: the user of the package would need to know what data is there 
  - `load_data()`: would use the output data csv and take the names from that to pick which one to load 


# Ideas

Remit: To facilitate archiving and sharing all of the data and materials for PSA projects in a standardized, transparent way. A helper package for the D&M committee to check the structure of project data. Modeled on usethis.

## Workflow

1. create master project
  - done by PM or DM implementation person
  - will be a github repo (ideally in the PSA org)
  - create and link OSF project? 
    - control permissions so OSF can't add things to github
  - create and link to Google Drive folder?
  - structured as an R package?
  - minimal info required to start, add later
    - PSA number
    - shortname (for repo)
    - Long name
    - Corresponding author for repo
    - Description (describe project and add funding info, other required info)
2. control access
  - add people or remove them
  - set up different roles
  - view-only roles?
  - give access overview with roles
3. add materials
  - happen throughout project
  - many directly from project management app
  - PSA-specific JSON template files
4. validation
  - checklists (in github issues?) set up at start of project and completed where relevant (require documentation)
  - functions to run for validation manually
  - added as CI?

100. Create Zenodo snapshot
  - can happen at multiple important timepoints (e.g., stage 1)
  
  
## Potential Issues

### private or public 
    - two versions with a CI to create the public one from a whitelist (burn down the public one every update, or just on mistakes)
    - .gitignore (may require too much competence)
    - fork a private version to team's account and keep anything private/in-progress there (requires git skills or lots of app hand-holding)
    
### Dealing with large files

    
## Ideas

- import tenzig for CRediT 
- phased data release 
- to set up initial project, clone template directory (located in inst, or located on github as a template repo)

## Template

- R
- data
- data-raw

## Next steps

- set up good template package directory
- think about workflow more

