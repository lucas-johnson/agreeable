
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

### Simulated data generation:

``` r
library(agreeable)
library(ggplot2)
library(knitr)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(data.table)
#> 
#> Attaching package: 'data.table'
#> The following objects are masked from 'package:dplyr':
#> 
#>     between, first, last

set.seed(123)
data <- data.table(
    observed = sort(rnorm(500, mean = 300, sd = 75)),
    predicted_systematic = sort(rnorm(500, mean = 275, sd = 100))
)
sds <- c(1, 5, 10, 30, 50, 75, 100, 150)
data$predicted_unsystematic <- sort(rnorm(500, mean = 300, sd = sds))
```

### 1. AC

Compute AC (agreement coefficient), ACs (systematic agreement), ACu
(unsystematic agreement), PUD (percentage of unsystematic difference),
and PSD (percentage of systematic difference):

Systematic differences dominate:

``` r
knitr::kable(
    data.table::data.table(
        AC = data %>% ac(observed, predicted_systematic),
        ACs = data %>% acs(observed, predicted_systematic),
        ACu = data %>% acu(observed, predicted_systematic),
        PUD = data %>% pud(observed, predicted_systematic),
        PSD = data %>% psd(observed, predicted_systematic)
    )
)
```

|        AC |       ACs |       ACu |       PUD |       PSD |
|----------:|----------:|----------:|----------:|----------:|
| 0.8659736 | 0.9352026 | 0.9307709 | 0.5165329 | 0.4834671 |

Unsystematic (random) differences dominate:

``` r
knitr::kable(
    data.table::data.table(
        AC = data %>% ac(observed, predicted_unsystematic),
        ACs = data %>% acs(observed, predicted_unsystematic),
        ACu = data %>% acu(observed, predicted_unsystematic),
        PUD = data %>% pud(observed, predicted_unsystematic),
        PSD = data %>% psd(observed, predicted_unsystematic)
    )
)
```

|        AC |       ACs |       ACu |       PUD |       PSD |
|----------:|----------:|----------:|----------:|----------:|
| 0.8553422 | 0.9992637 | 0.8560785 | 0.9949103 | 0.0050897 |

### 2. GMFR

Scatter plot with 1:1 and Geometric Mean Functional Relationship (GMFR)
lines:

Systematic differences dominate:

``` r
inter <- data %>% gmfr_intercept(observed, predicted_systematic)
slope <- data %>% gmfr_slope(observed, predicted_systematic)

ggplot2::ggplot(data, aes(x=observed, y = predicted_systematic)) +
    ggplot2::geom_point(
        alpha = 0.7, 
        color = "black"
    ) + 
    ggplot2::geom_abline(aes(slope = 1, intercept = 0, color = "black")) + 
    ggplot2::geom_abline(aes(slope = slope, intercept = inter, color = "orange")) + 
    ggplot2::scale_color_identity(
        labels=c("1:1", "GMFR"), 
        guide="legend", 
        name = ""
    )
```

<img src="man/figures/README-example_2_systematic-1.png" width="100%" />

Unsystematic (random) differences dominate:

``` r
inter <- data %>% gmfr_intercept(observed, predicted_unsystematic)
slope <- data %>% gmfr_slope(observed, predicted_unsystematic)

ggplot2::ggplot(data, aes(x = observed, y = predicted_unsystematic)) + 
    ggplot2::geom_point(
        alpha = 0.7, 
        color = "black"
    ) + 
    ggplot2::geom_abline(aes(slope = 1, intercept = 0, color = "black")) + 
    ggplot2::geom_abline(aes(slope = slope, intercept = inter, color = "orange")) + 
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
