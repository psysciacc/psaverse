# Add R package to PsySciAcc Organization

This function will initialize the use of github and direct the package
to be included in the PsySciAcc organization. You can then use RStudio's
built in git push/pull, the command line, or your favorite gui desktop
app to push and pull to github.

## Usage

``` r
psa_git(organisation = "psysciacc", private = TRUE)
```

## Arguments

- organisation:

  should be "psysciacc" - please note you should confirm you have the
  privileges to push to the organization first

- private:

  a TRUE/FALSE variable with the default to start as private until you
  are ready to release the project package.

## Examples

``` r
# psa_git()
```
