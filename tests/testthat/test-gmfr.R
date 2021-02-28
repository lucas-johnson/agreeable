# ==============================================================================
# a_gmfr
# ==============================================================================

test_that("a_gmfr works", {
      x <- c(1, 2, 3)
      y <- c(4, 5, 6)
      expect_equal(a_gmfr(x, y), 3)
})

test_that("a_gmfr fails on vectors of different length", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(a_gmfr(x, y))
    x <- c(1, 2, 3)
    y <- c(4, 5)
    expect_error(a_gmfr(x, y))
})

test_that("na.rm works with a_gmfr", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(a_gmfr(x, y, na.rm = T), 2)
    expect_true(is.na(a_gmfr(x, y)))
})

# ==============================================================================
# b_gmfr
# ==============================================================================

test_that("b_gmfr works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(b_gmfr(x, y), 1)
})

test_that("b_gmfr fails on vectors of different length", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(b_gmfr(x, y))
    x <- c(1, 2, 3)
    y <- c(4, 5)
    expect_error(a_gmfr(x, y))
})

test_that("na.rm works with b_gmfr", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(b_gmfr(x, y, na.rm = T), 1)
    expect_true(is.na(b_gmfr(x, y)))
})

# ==============================================================================
# gmfr
# ==============================================================================

test_that("gmfr works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(gmfr(x, y), list(x = x, y = y))
    
    x <- c(34, 2, 87, 46)
    y <- c(29, 2, 88, 56)
    expect_equal(
        gmfr(x, y), 
        list(
            x = c(
                28.175241,
                2.411275, 
                84.474277, 
                53.939207
            ), 
            y = c(
                35.104204,
                1.568994,
                90.646895,
                47.679907
            )
        )
    )
})

test_that("gmfr fails on vectors of different length", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(gmfr(x, y))
    x <- c(1, 2, 3)
    y <- c(4, 5)
    expect_error(gmfr(x, y))
 
})

test_that("na.rm works with gmfr", {
  x <- c(1, 2, NA)
  y <- c(3, 4, 5)
  expect_true(is.na(b_gmfr(x, y)))
  expect_equal(gmfr(x, y, na.rm = T), list(x = x[1:2], y = y[1:2]))
})
