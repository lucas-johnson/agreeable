test_that("ac works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(ac(x, y), 0.3414634)
})

test_that("ac fails on vectors of different lengths", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(ac(x, y))
})

test_that("na.rm works with ac", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(ac(x, y, na.rm = T), 0.36)
    expect_true(is.na(ac(x, y)))
})

test_that("acs works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(acs(x, y), 0.3414634)
})

test_that("acs fails on vectors of different lengths", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(acs(x, y))
})

test_that("na.rm works with acs", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(acs(x, y, na.rm = T), 0.36)
    expect_true(is.na(acs(x, y)))
})

test_that("acu works", {
    x <- c(1, 2, 3)
    y <- c(4, 5, 6)
    expect_equal(acu(x, y), 1)
})

test_that("acu fails on vectors of different lengths", {
    x <- c(1, 2)
    y <- c(3, 4, 5)
    expect_error(acu(x, y))
})

test_that("na.rm works with acu", {
    x <- c(1, 2, NA)
    y <- c(3, 4, 5)
    expect_equal(acu(x, y, na.rm = T), 1)
    expect_true(is.na(acu(x, y)))
})