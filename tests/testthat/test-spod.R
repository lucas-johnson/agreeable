test_that("spod works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(spod(x, y), 41)
})

test_that("spod fails on vectors of different lengths", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(spod(x, y))
})

test_that("na.rm works with spod", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(spod(x, y, na.rm = T), 18)
    expect_true(is.na(spod(x, y)))
})