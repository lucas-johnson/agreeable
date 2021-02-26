test_that("ssd works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(ssd(x, y), 27)
})

test_that("ssd fails on vectors of different lengths", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(ssd(x, y))
})

test_that("na.rm works with ssd", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(ssd(x, y, na.rm = T), 8)
    expect_true(is.na(ssd(x, y)))
})