
set.seed(581837)
house_dat <- MASS::housing[sample(72, 48), ]

test_that("model object", {

  orig_fit <- MASS::polr(
    Sat ~ Type + Infl + Cont,
    data = house_dat,
    model = TRUE
  )

  tidy_spec <- ordinal_reg() |>
    set_engine("polr") |>
    set_mode("classification")
  tidy_fit <- fit(tidy_spec, Sat ~ Type + Infl + Cont, data = house_dat)

  # remove `call` from comparison
  orig_fit$call <- NULL
  tidy_fit$fit$call <- NULL

  expect_equal(
    orig_fit,
    tidy_fit$fit,
    ignore_formula_env = TRUE
  )
})

# prediction: probability ------------------------------------------------------

test_that("probability prediction", {

  tidy_fit <- ordinal_reg() |>
    set_engine("polr") |>
    fit(Sat ~ Type + Cont, data = house_dat)

  orig_pred <- predict(tidy_fit$fit, newdata = house_dat, type = "probs")
  orig_pred <- as_tibble(orig_pred)
  orig_pred <- set_names(orig_pred, paste0(".pred_", names(orig_pred)))
  tidy_pred <- predict(tidy_fit, house_dat, type = "prob")
  expect_equal(orig_pred, tidy_pred)
})

# prediction: class ------------------------------------------------------------

test_that("class prediction", {

  tidy_fit <- ordinal_reg() |>
    set_engine("polr") |>
    fit(Sat ~ Infl + Cont, data = house_dat)

  orig_pred <- predict(tidy_fit$fit, house_dat)
  # NB: `MASS:::predict.polr()` strips order from `object$model$<outcome>`.
  orig_pred <- ordered(unname(orig_pred), levels(orig_pred))
  orig_pred <- tibble(.pred_class = orig_pred)
  tidy_pred <- predict(tidy_fit, house_dat)
  expect_equal(orig_pred, tidy_pred)
})
