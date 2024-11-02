#' Ordinal regression
#' @examples
#' # translate a specification
#' ordinal_reg() |> translate(engine = "polr")
#'
#' # train and test a model
#' house_split <- initial_split(MASS::housing, prop = .8)
#' house_train <- training(house_split)
#' house_test <- testing(house_split)
#' house_spec <- ordinal_reg(engine = "polr") |> set_args(method = "cloglog")
#' house_fit <-
#'   fit(house_spec, Sat ~ Infl + Type + Cont, data = house_train)
#' house_fit
#' predict(house_fit, new_data = house_test, type = "class")
#' predict(house_fit, new_data = house_test, type = "prob")
#'
#' # check Tidymodels fit & predictions against original
#' MASS::polr(Sat ~ Infl + Type + Cont, data = house_train, method = "cloglog")
#'
#' @export
ordinal_reg <-
  function(mode = "classification", engine = "polr") {

    if (mode != "classification") {
      rlang::abort("`mode` should be 'classification'")
    }

    args <- list()

    parsnip::new_model_spec(
      "ordinal_reg",
      args = args,
      eng_args = NULL,
      mode = mode,
      user_specified_mode = !missing(mode),
      method = NULL,
      engine = engine,
      user_specified_engine = ! missing(engine)
    )
  }
