# ==============================================================================
# gmfr_intercept
# ==============================================================================

test_that("gmfr_intercept works", {
    test_data <- data.frame(
        a = c(1, 2, 3),
        b = c(4, 5, 6)
    )
    expect_equal(gmfr_intercept(test_data, a, b), 3)
})

test_that("na.rm works with gmfr_intercept", {
    test_data <- data.frame(
        a = c(1, 2, NA),
        b = c(3, 4, 5)
    )
    expect_equal(gmfr_intercept(test_data, a, b, na.rm = T), 2)
    expect_true(is.na(gmfr_intercept(test_data, a, b)))
})

# ==============================================================================
# gmfr_slope
# ==============================================================================

test_that("gmfr_slope works", {
    test_data <- data.frame(
        a = c(1, 2, 3),
        b = c(4, 5, 6)
    )
    expect_equal(gmfr_slope(test_data, a, b), 1)
})

test_that("na.rm works with gmfr_slope", {
    test_data <- data.frame(
        a = c(1, 2, NA),
        b = c(3, 4, 5)
    )
    expect_equal(gmfr_slope(test_data, a, b, na.rm = T), 1)
    expect_true(is.na(gmfr_slope(test_data, a, b)))
})

# ==============================================================================
# gmfr
# ==============================================================================

test_that("gmfr works", {
    test_data <- data.frame(
      x = c(1, 2, 3),
      y = c(4, 5, 6)
    )
    gmfr_test <- test_data %>% gmfr(x, y)
    expect_equal(gmfr_test$data, test_data)
    
    test_data <- data.frame(
        a = c(34, 2, 87, 46),
        b = c(29, 2, 88, 56)
    )
    test_out <- data.frame(
        x = c(
            28.819570,
            4.235054, 
            82.541290, 
            53.404086
        ), 
        y = c(
            34.6894190,
            -0.4546528,
            92.8967879,
            47.8684459
        )
    )
    gmfr_test <- test_data %>% gmfr(a, b)
    expect_equal(
        gmfr_test$data, 
        test_out
    )
})


test_that("na.rm works with gmfr", {
    test_data <- data.frame(
        a = c(1, 2, NA),
        b = c(3, 4, 5)
    )
    expect_true(
        all(is.na(gmfr(test_data, a, b)$data$a)) & 
            all(is.na(gmfr(test_data, a, b)$data$b))
    )
    expect_equal(
        gmfr(test_data, a, b, na.rm = T)$data, 
        data.frame(x = c(1, 2), y= c(3, 4))
    )
})
