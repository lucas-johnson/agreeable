test_that("a_gmfr works", {
      x <- c(1, 2, 3)
      y <- c(4, 5, 6)
      expect_equal(a_gmfr(x, y), 3)
})

test_that("b_gmfr works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(b_gmfr(x, y), 1)
})

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