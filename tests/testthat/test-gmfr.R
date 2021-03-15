# ==============================================================================
# a_gmfr
# ==============================================================================

test_that("a_gmfr works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(a_gmfr(test_data, x, y), 3)
})

test_that("na.rm works with a_gmfr", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(a_gmfr(test_data, x, y, na.rm = T), 2)
    expect_true(is.na(a_gmfr(test_data, x, y)))
})

# ==============================================================================
# b_gmfr
# ==============================================================================

test_that("b_gmfr works", {
    test_data <- data.frame(
        x = c(1, 2, 3),
        y = c(4, 5, 6)
    )
    expect_equal(b_gmfr(test_data, x, y), 1)
})

test_that("na.rm works with b_gmfr", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_equal(b_gmfr(test_data, x, y, na.rm = T), 1)
    expect_true(is.na(b_gmfr(test_data, x, y)))
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
        x = c(34, 2, 87, 46),
        y = c(29, 2, 88, 56)
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
    gmfr_test <- test_data %>% gmfr(x, y)
    expect_equal(
        gmfr_test$data, 
        test_out
    )
})


test_that("na.rm works with gmfr", {
    test_data <- data.frame(
        x = c(1, 2, NA),
        y = c(3, 4, 5)
    )
    expect_true(
        all(is.na(gmfr(test_data, x, y)$data$x)) & 
            all(is.na(gmfr(test_data, x, y)$data$y))
    )
    expect_equal(
        gmfr(test_data, x, y, na.rm = T)$data, 
        data.frame(x = c(1, 2), y = c(3, 4))
    )
})
