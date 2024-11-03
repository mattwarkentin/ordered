
test_that("model object", {

  orig_fit <- MASS::polr(
    Sat ~ Infl + Type + Cont,
    data = MASS::housing,
    model = TRUE
  )

  tidy_spec <- ordinal_reg() |>
    set_engine("polr") |>
    set_mode("classification")
  tidy_fit <- fit(tidy_spec, Sat ~ Infl + Type + Cont, data = MASS::housing)

  # remove `call` from comparison
  orig_fit$call <- NULL
  tidy_fit$fit$call <- NULL

  expect_equal(
    orig_fit,
    tidy_fit$fit,
    ignore_formula_env = TRUE
  )
})
