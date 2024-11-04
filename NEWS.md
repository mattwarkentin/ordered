# ordered (development version)

* Initial CRAN submission.

## Ordinal random forest



## Ordinal regression model type

The package defines the `ordinal_reg()` model type.
This is experimental; one proposed alternative is to separately define `ordinal_*()` types for cumulative, sequential, and adjacent-category structures.

`ordinal_reg()` comes with the single `'polr'` engine.
The engine has one tunable parameter, the `ordinal_link` passed to the `method` parameter of `MASS::polr()`.

Two prediction types, `'class'` and `'prob'`, are made available.
Unit tests assert agreement between model objects and predictions, including when using case weights.
