
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ordered

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ordered)](https://CRAN.R-project.org/package=ordered)
[![R-CMD-check](https://github.com/topepo/ordered/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/topepo/ordered/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/topepo/ordered/branch/main/graph/badge.svg)](https://app.codecov.io/gh/topepo/ordered?branch=main)
<!-- badges: end -->

The goal of ordered is to enable additional classification models for
ordinal outcomes (e.g., “low”, “medium”, “high”). While there are
several model/engine combinations in the parsnip package that can be
used, this package adds:

- ordinal forests [Hornung R.
  (2020)](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C7&q=10.1007%2Fs00357-018-9302-x&btnG=)

More will be added.

There are some existing features in tidymodels packages that are useful
for ordinal outcomes:

- The “partykit” engines for \[parsnip::decision_tree()\] and
  \[parsnip:: rand_forest()\] use the ordered nature of the factors to
  train the model.
- The yardstick package has \[yardstick::kap()\] for weighted and
  unweighted Kappa statistics (the former being of more interest). Also,
  \[yardstick::classification_cost()\] can utilize more complex cost
  structures and uses the class probabilities for estimation.

## Installation

You can install the development version of ordered like so:

``` r
pak::pak("topepo/ordered")
```

## Example

Here is a simple example using computational chemistry data to predict
the permeability of a molecule:

``` r
library(ordered)
#> Loading required package: parsnip
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

data(caco, package = "QSARdata")

caco_dat <-
  inner_join(caco_Outcome, caco_Dragon, by = "Molecule") %>%
  as_tibble() %>%
  select(class = Class, mol_weight = QikProp_mol_MW,
         volume = QikProp_volume, ClogP)
  caco_train <- caco_dat[-(1:5), ]
  caco_test  <- caco_dat[ (1:5), ]

ord_rf_spec <- 
  rand_forest(mtry = 2, trees = 100) %>% # you should really use many more trees
  set_mode("classification") %>%
  set_engine("ordinalForest")

set.seed(382)
ord_rf_fit <- ord_rf_spec %>% fit(class ~ ., data = caco_train)
augment(ord_rf_fit, caco_test)
#> # A tibble: 5 × 8
#>   .pred_class .pred_L .pred_M .pred_H class mol_weight volume ClogP
#>   <fct>         <dbl>   <dbl>   <dbl> <ord>      <dbl>  <dbl> <dbl>
#> 1 M             0.346   0.404  0.250  M           123.   445. 0.799
#> 2 M             0.362   0.514  0.124  L           290.   856. 0.534
#> 3 M             0.204   0.786  0.01   M           519.  1576. 1.02 
#> 4 M             0.190   0.788  0.0221 M           533.  1606. 1.58 
#> 5 M             0.177   0.780  0.0435 M           505.  1517. 1.71
```

## Code of Conduct

Please note that the ordered project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
