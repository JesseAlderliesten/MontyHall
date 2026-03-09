#### Preparations ####
set.seed(314)


#### Create objects to use in tests ####
x <- 1:10


#### Test the examples ####
expect_silent(
  expect_identical(
    length(sample_safe(x = x)),
    10L
  )
)

expect_silent(
  expect_identical(
    length(sample_safe(x = c(0, 1), size = 5, replace = TRUE)),
    5L
  )
)

expect_silent(
  expect_identical(
    length(sample(x = x[x > 8])),
    2L
  )
)

expect_silent(
  expect_identical(
    length(sample(x = x[x > 9])),
    10L
  )
)

expect_silent(
  expect_identical(
    length(sample(x = x[x > 10])),
    0L
  )
)

expect_silent(
  expect_identical(
    length(sample_safe(x = x[x > 8])),
    2L
  )
)

expect_silent(
  expect_identical(
    length(sample_safe(x = x[x > 9])),
    1L
  )
)

expect_silent(
  expect_identical(
    length(sample_safe(x = x[x > 10])),
    0L
  )
)


#### Tests ####
expect_identical(length(sample_safe(x = x, size = 3L, replace = TRUE)), 3L)
expect_identical(length(sample_safe(x = x, size = 3L, replace = FALSE)), 3L)

expect_identical(length(sample_safe(x = x, size = 10L, replace = TRUE)), 10L)
expect_identical(length(sample_safe(x = x, size = 10L, replace = FALSE)), 10L)

expect_identical(length(sample_safe(x = x, size = 11L, replace = TRUE)), 11L)
expect_identical(length(sample_safe(x = x, size = 11L, replace = 1)), 11L)
expect_identical(length(sample_safe(x = x, size = 11L, replace = 2)), 11L)

expect_identical(sample_safe(x = integer(0), size = 0L), integer(0))
expect_identical(sample_safe(x = character(0), size = 0L), character(0))

expect_identical(sample_safe(x = x, size = 0L), integer(0))
expect_identical(sample_safe(x = "a", size = 0L), character(0))


##### Erroneous input #####
expect_error(
  sample_safe(x = integer(0), size = 1L),
  pattern = "invalid first argument", fixed = TRUE
)

expect_error(
  sample_safe(x = character(0), size = 1L),
  pattern = "invalid first argument", fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = -1L),
  pattern = "invalid 'size' argument", fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = 1L, replace = NA),
  pattern = "invalid 'replace' argument", fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = 1L, replace = "a"),
  pattern = "invalid 'replace' argument", fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = 11L, replace = FALSE),
  pattern = "cannot take a sample larger than the population when 'replace = FALSE'",
  fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = 11L, replace = 0),
  pattern = "cannot take a sample larger than the population when 'replace = FALSE'",
  fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = 3L, prob = c(0.1, 0.2)),
  pattern = "incorrect number of probabilities", fixed = TRUE)

expect_error(
  # Using a vector of `TRUE` is fine as input to 'sample()'
  sample_safe(x = x, size = 3L, prob = rep(TRUE, 10L)),
  pattern = "is.null(prob) || checkinput::all_nonnegative(prob) is not TRUE",
  fixed = TRUE)


#### Remove objects used in tests ####
rm(x)
