# ==============================================================================
# pud
# ==============================================================================

test_that("pud works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(pud(test_data, x, y), 0)
})

test_that("na.rm works with pud", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(pud(test_data, x, y, na.rm = T), 0)
    expect_true(is.na(pud(test_data, x, y)))
})

# ==============================================================================
# psd
# ==============================================================================

test_that("psd works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(psd(test_data, x, y), 1)
})

test_that("na.rm works with psd", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(psd(test_data, x, y, na.rm = T), 1)
    expect_true(is.na(psd(test_data, x, y)))
})

# ==============================================================================
# ac
# ==============================================================================

test_that("ac works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(ac(test_data, x, y), 0.3414634)
})

test_that("na.rm works with ac", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(ac(test_data, x, y, na.rm = T), 0.36)
    expect_true(is.na(ac(test_data, x, y)))
})

# ==============================================================================
# acs
# ==============================================================================

test_that("acs works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(acs(test_data, x, y), 0.3414634)
})

test_that("na.rm works with acs", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(ac(test_data, x, y, na.rm = T), 0.36)
    expect_true(is.na(ac(test_data, x, y)))
})

# ==============================================================================
# acu
# ==============================================================================

test_that("acu works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(acu(test_data, x, y), 1)
})

test_that("na.rm works with acu", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(acu(test_data, x, y, na.rm = T), 1)
    expect_true(is.na(acu(test_data, x, y)))
})
