#' {ordered}: parsnip Engines for Ordinal Regression Models
#'
#' {ordered} provides engines for ordinal regression models for the {parsnip}
#' package. The models may have cumulative, sequential, or adjacent-category
#' structure, and in future these may be disaggregated into separate model
#' types. A vignette will provide thorough illustrations of {ordered}
#' functionality. See below for examples of fitting ordinal regression models
#' with {censored}.
#'
#' @examples
#' set.seed(561246)
#' train_inds <- sort(sample(nrow(MASS::housing), size = 48))
#' house_train <- MASS::housing[train_inds, ]
#' house_test <- MASS::housing[-train_inds, ]
#'
#' # Cumulative-link proportional-odds probit regression model
#'
#' fit_cpop <- ordinal_reg() |>
#'   set_engine("polr") |>
#'   set_args(method = "probit") |>
#'   fit(Sat ~ Infl + Type + Cont, data = house_train)
#' predict(fit_cpop, house_test, type = "prob")
#'
#' # Ordinal forest
#'
#' fit_orf <- rand_forest(mode = "classification") |>
#'   set_engine("ordinalForest") |>
#'   fit(Sat ~ Infl + Type + Cont, data = house_train)
#' predict(fit_orf, house_test, type = "prob")
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @import rlang
#' @import parsnip
## usethis namespace: end
NULL
