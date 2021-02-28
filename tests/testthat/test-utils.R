test_that("vec_narm works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(vec_narm(x, y), list(x = x, y = y))
    
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(vec_narm(x, y), list(x = c(1, 2), y = c(3, 4)))
    
    x <- c(1, 2, NA)
    y <- c(NA, 4, 5)
    expect_equal(vec_narm(x, y), list(x = c(2), y = c(4)))
})
