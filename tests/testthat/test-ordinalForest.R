test_that("ordinal forests",{
  skip_if_not_installed("ordinalForest")
  skip_if_not_installed("QSARdata")

  orf_spec <-
    rand_forest() %>%
    set_mode("classification") %>%
    set_engine("ordinalForest")

  expect_snapshot(orf_spec %>% translate())

  expect_no_error({
    set.seed(13)
    orf_f_fit <- fit(orf_spec, class ~ ., data = caco_train)
  })
  expect_snapshot(orf_f_fit)

  orf_f_cls <- predict(orf_f_fit, new_data = caco_test)
  expect_named(orf_f_cls, ".pred_class")
  expect_true(nrow(orf_f_cls) == nrow(caco_test))
  expect_s3_class(orf_f_cls$.pred_class, "ordered")

  orf_f_prob <- predict(orf_f_fit, new_data = caco_test, type = "prob")
  expect_named(orf_f_prob, c(".pred_L", ".pred_M", ".pred_H"))
  expect_true(nrow(orf_f_prob) == nrow(orf_f_prob))

  expect_no_error({
    set.seed(13)
    orf_xy_fit <- fit_xy(orf_spec, x = caco_train[, -1], y = caco_train$class)
  })
  expect_snapshot(orf_xy_fit)

  expect_equal(
    orf_f_fit$fit$perffunctionvalues,
    orf_xy_fit$fit$perffunctionvalues
  )

  ###

  orf_arg_spec <-
    rand_forest(mtry = 2, min_n = 11, trees = 100) %>%
    set_mode("classification") %>%
    set_engine("ordinalForest")

  expect_snapshot(orf_arg_spec %>% translate())

  # This warning is a bug that I'll report
  expect_snapshot({
    set.seed(13)
    orf_arg_fit <- fit(orf_arg_spec, class ~ ., data = caco_train)
  })
  expect_equal(orf_arg_fit$fit$ntreefinal, 100)
})
