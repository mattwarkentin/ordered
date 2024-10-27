if (rlang::is_installed("QSARdata")) {
  library(dplyr)
  data(caco, package = "QSARdata")

  set.seed(1)
  caco_dat <-
    dplyr::inner_join(caco_Outcome, caco_Dragon, by = "Molecule") %>%
    dplyr::as_tibble() %>%
    dplyr::select(class = Class, mol_weight = QikProp_mol_MW,
                  volume = QikProp_volume, ClogP) %>%
    dplyr::slice_sample(n = 20, by = class)
  caco_train <- caco_dat[-c(1:2, 21:22, 41:42), ]
  caco_test  <- caco_dat[ c(1:2, 21:22, 41:42), ]
}
