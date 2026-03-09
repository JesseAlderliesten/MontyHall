#### To do ####
# Restore the random seed, see rngSeed.R in progutils_knip for ideas.
warning("Tests for 'sample_safe' are not yet complete!")


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

sample_safe(x = integer(0), size = 0L)

##### Erroneous input #####
expect_error(
  sample_safe(x = integer(0), size = 1L),
  pattern = "invalid first argument", fixed = TRUE
)

expect_error(
  sample_safe(x = x, size = 11L, replace = FALSE),
  pattern = "cannot take a sample larger than the population when 'replace = FALSE'",
  fixed = TRUE
)

#### Remove objects used in tests ####
rm(x)
