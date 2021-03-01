
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![license](https://img.shields.io/badge/license-GPL--3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Codecov test
coverage](https://codecov.io/gh/lucas-johnson/agreeable/branch/main/graph/badge.svg)](https://codecov.io/gh/lucas-johnson/agreeable?branch=main)
[![R build
status](https://github.com/lucas-johnson/agreeable/workflows/R-CMD-check/badge.svg)](https://github.com/lucas-johnson/agreeable/actions)
[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/agreeable)](https://CRAN.R-project.org/package=agreeable)

<!-- badges: end -->

# agreeable

The goal of agreeable is to provide a set of simple tools to assess
agreement between two matching datasets. The specific use case under
which this package was developed is to assess the agreement between
modeled and observed datasets.

Computations following [Ji and Gallo
2006](https://www.ingentaconnect.com/content/asprs/pers/2006/00000072/00000007/art00006).

## Examples

Here are some of the basic tools made available by agreeable…

``` r
library(agreeable)
library(ggplot2)
library(knitr)

set.seed(123)
observed <- sort(rnorm(500, mean = 300, sd = 75))
predicted_systematic <- sort(rnorm(500, mean = 275, sd = 100))

sds <- c(1, 5, 10, 30, 50, 75, 100, 150)
predicted_unsystematic <- sort(rnorm(500, mean = 300, sd = sds))
```

### 1. AC

Compute AC (agreement coefficient), ACs (systematic agreement), ACu
(unsystematic agreement), PUD (percentage of unsystematic difference),
and PSD (percentage of systematic difference):

Systematic differences dominate:

``` r
knitr::kable(
    data.table::data.table(
        AC = ac(observed, predicted_systematic),
        ACs = acs(observed, predicted_systematic),
        ACu = acu(observed, predicted_systematic),
        PUD = pud(observed, predicted_systematic),
        PSD = psd(observed, predicted_systematic)
    )
)
```

|        AC |       ACs |       ACu |       PUD |       PSD |
|----------:|----------:|----------:|----------:|----------:|
| 0.8659736 | 0.8691102 | 0.9968634 | 0.0234028 | 0.9765972 |

Unsystematic (random) differences dominate:

``` r
knitr::kable(
    data.table::data.table(
        AC = ac(observed, predicted_unsystematic),
        ACs = acs(observed, predicted_unsystematic),
        ACu = acu(observed, predicted_unsystematic),
        PUD = pud(observed, predicted_unsystematic),
        PSD = psd(observed, predicted_unsystematic)
    )
)
```

|        AC |       ACs |      ACu |       PUD |       PSD |
|----------:|----------:|---------:|----------:|----------:|
| 0.8553422 | 0.9967902 | 0.858552 | 0.9778108 | 0.0221892 |

### 2. GMFR

Scatter plot with 1:1 and Geometric Mean Functional Relationship (GMFR)
lines:

Systematic differences dominate:

``` r
# Intercept
a <- a_gmfr(observed, predicted_systematic)

# Slope
b <- b_gmfr(observed, predicted_systematic)

ggplot2::ggplot(data = NULL) + 
    ggplot2::geom_point(
        aes(x = observed, y = predicted_systematic), 
        alpha = 0.7, 
        color = "black"
    ) + 
    ggplot2::geom_abline(aes(slope = 1, intercept = 0, color = "black")) + 
    ggplot2::geom_abline(aes(slope = b, intercept = a, color = "orange")) + 
    ggplot2::scale_color_identity(
        labels=c("1:1", "GMFR"), 
        guide="legend", 
        name = ""
    )
```

<img src="man/figures/README-example_2_systematic-1.png" width="100%" />

Unsystematic (random) differences dominate:

``` r
a <- a_gmfr(observed, predicted_unsystematic)

# Slope
b <- b_gmfr(observed, predicted_unsystematic)

ggplot2::ggplot(data = NULL) + 
    ggplot2::geom_point(
        aes(x = observed, y = predicted_unsystematic), 
        alpha = 0.7, 
        color = "black"
    ) + 
    ggplot2::geom_abline(aes(slope = 1, intercept = 0, color = "black")) + 
    ggplot2::geom_abline(aes(slope = b, intercept = a, color = "orange")) + 
    ggplot2::scale_color_identity(
        labels=c("1:1", "GMFR"), 
        guide="legend", 
        name = ""
    )
```

<img src="man/figures/README-example_2_unsystematic-1.png" width="100%" />

## Installation

<!-- You can install the released version of agreeable from [CRAN](https://CRAN.R-project.org) with: -->

There is no released version of agreeable yet.

<!-- ``` r -->
<!-- install.packages("agreeable") -->
<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lucas-johnson/agreeable")
```
