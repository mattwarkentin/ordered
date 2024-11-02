
make_ordinal_reg <- function() {

parsnip::set_new_model("ordinal_reg")

parsnip::set_model_mode("ordinal_reg", "classification")

}

# ------------------------------------------------------------------------------

make_ordinal_reg_polr <- function() {

parsnip::set_model_engine("ordinal_reg", "classification", "polr")
parsnip::set_dependency("ordinal_reg",
                        eng = "polr",
                        pkg = "ordered",
                        mode = "classification")

parsnip::set_fit(
  model = "ordinal_reg",
  eng = "polr",
  mode = "classification",
  value = list(
    interface = "formula",
    protect = c("formula", "data", "weights"),
    func = c(pkg = "MASS", fun = "polr"),
    defaults = list(
      method = "logistic"
    )
  )
)

parsnip::set_encoding(
  model = "ordinal_reg",
  eng = "polr",
  mode = "classification",
  options = list(
    predictor_indicators = "traditional",
    compute_intercept = TRUE,
    remove_intercept = FALSE,
    allow_sparse_x = FALSE
  )
)

parsnip::set_pred(
  model = "ordinal_reg",
  eng = "polr",
  mode = "classification",
  type = "class",
  value = list(
    pre = NULL,
    post = NULL,
    func = c(fun = "predict"),
    args =
      list(
        object = quote(object$fit),
        newdata = quote(new_data),
        type = "class"
      )
  )
)

parsnip::set_pred(
  model = "ordinal_reg",
  eng = "polr",
  mode = "classification",
  type = "prob",
  value = list(
    pre = NULL,
    post = function(x, object) {
      tibble::as_tibble(x)
    },
    func = c(fun = "predict"),
    args =
      list(
        object = quote(object$fit),
        newdata = quote(new_data),
        type = "probs"
      )
  )
)

}
