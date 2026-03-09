#### Create objects to use in tests ####
set.seed(314)
setup_normal <- setup_MontyHall(n_doors = 3, n_prizes = 1)
setup_large <- setup_MontyHall(n_doors = 10, n_prizes = 3)
setup_noninteger <- setup_MontyHall(n_doors = 5 - 1e-10, n_prizes = 1 - 1e-10)


#### Test the examples ####
# Examples are tested in 'Tests' below.


#### Tests ####
# Also used as an example
expect_silent(
  expect_identical(
    setup_normal$status,
    rep(TRUE, 3L)
  )
)

# Also used as an example
expect_silent(
  expect_identical(
    length(setup_normal$prize),
    1L
  )
)

# Also used as an example
expect_silent(
  expect_true(
    all(setup_normal$prize %in% 1:3),
  )
)

# Also used as an example
expect_silent(
  expect_identical(
    setup_large$status,
    rep(TRUE, 10L)
  )
)

# Also used as an example
expect_silent(
  expect_identical(
    length(setup_large$prize),
    3L
  )
)

# Also used as an example
expect_silent(
  expect_true(
    all(setup_large$prize %in% 1:10),
  )
)

# Check if values are rounded before use
expect_silent(
  expect_identical(
    setup_noninteger$status,
    rep(TRUE, 5L)
  )
)

expect_silent(
  expect_identical(
    length(setup_noninteger$prize),
    1L
  )
)

expect_silent(
  expect_true(
    setup_noninteger$prize %in% 1:5,
  )
)

##### Erroneous input #####
expect_error(
  setup_MontyHall(n_doors = "a"),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_doors = 3.1),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_doors = 2),
  pattern = "n_doors >= 3L is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_doors = 0),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_prizes = "a"),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_prizes = 3.1),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_prizes = 0),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_prizes = 0),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  setup_MontyHall(n_doors = 3, n_prizes = 2),
  pattern = "n_prizes <= n_doors - 2L is not TRUE", fixed = TRUE
)


#### Remove objects used in tests ####
rm(setup_large, setup_noninteger, setup_normal)
