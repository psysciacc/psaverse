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

