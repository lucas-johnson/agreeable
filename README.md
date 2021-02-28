
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R build
status](https://github.com/lucas-johnson/acurragree/workflows/R-CMD-check/badge.svg)](https://github.com/lucas-johnson/acurragree/actions)
[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/accuragree)](https://CRAN.R-project.org/package=accuragree)
<!-- badges: end -->

# accuragree

The goal of accuragree is to provide a set of simple tools to assess
agreement between two matching datasets. The specific use case under
which this package was developed is to assess the agreement between
modeled and observed datasets.

Computations following [Ji and Gallo
2006](https://www.ingentaconnect.com/content/asprs/pers/2006/00000072/00000007/art00006).

## Examples

Here are some of the basic tools made available by acurragree…

### 1. AC

Compute AC (agreement coefficient), ACs (systematic agreement), ACu
(unsystematic agreement), PUD (percentage of unsystematic difference),
and PSD (percentage of systematic difference):

``` r
library(accuragree)
library(data.table)
library(ggplot2)
library(knitr)

kable(head(example_data, 10))
```

|  observed | predicted |
|----------:|----------:|
| 140.61384 | 162.19677 |
| 103.46413 | 142.71354 |
|  89.73531 |  85.00245 |
| 104.44828 | 140.66393 |
| 144.88737 | 190.74080 |
| 122.30545 | 132.33885 |
|  14.33030 |  39.01110 |
| 213.71319 | 172.17009 |
|  91.62893 | 141.74096 |
|  82.64259 | 147.13899 |

``` r
knitr::kable(
    data.table::data.table(
        AC = ac(example_data$observed, example_data$predicted),
        ACs = acs(example_data$observed, example_data$predicted),
        ACu = acu(example_data$observed, example_data$predicted),
        PUD = pud(example_data$observed, example_data$predicted),
        PSD = psd(example_data$observed, example_data$predicted)
    )
)
```

|        AC |      ACs |       ACu |       PUD |       PSD |
|----------:|---------:|----------:|----------:|----------:|
| 0.6428046 | 0.968102 | 0.6747026 | 0.9106988 | 0.0893012 |

### 2. GMFR

Scatter plot with 1:1 and Geometric Mean Functional Relationship (GMFR)
lines:

``` r
# Intercept
a <- a_gmfr(example_data$observed, example_data$predicted)

# Slope
b <- b_gmfr(example_data$observed, example_data$predicted)

ggplot2::ggplot(data = example_data) + 
    ggplot2::geom_point(aes(x = observed, y = predicted), alpha = 0.7, color = "black") + 
    ggplot2::geom_abline(aes(slope = 1, intercept = 0, color = "black")) + 
    ggplot2::geom_abline(aes(slope = b, intercept = a, color = "orange")) + 
    ggplot2::scale_color_identity(labels=c("1:1", "GMFR"), guide="legend", name = "")
```

<img src="man/figures/README-example_2-1.png" width="100%" />

## Installation

<!-- You can install the released version of accuragree from [CRAN](https://CRAN.R-project.org) with: -->

There is no released version of accuragree yet.

<!-- ``` r -->
<!-- install.packages("accuragree") -->
<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lucas-johnson/accuragree")
```
