#### Create objects to use in tests ####
status <- c(TRUE, TRUE, TRUE)
status_many <- c(rep(TRUE, 4), rep(FALSE, 3))

#### Test the examples ####
# Examples are tested in the file test_play_MontyHall.R.


#### Tests ####
expect_silent(
  expect_identical(
    lengths(outcome(status = status, prize = 1L, chosen_door = 1L)),
    c(stick = 1L, change = 1L)
  )
)

expect_silent(
  expect_true(
    all(unlist(outcome(status = status, prize = 1L, chosen_door = 1L)) %in%
          c(TRUE, FALSE))
  )
)

expect_silent(
  expect_identical(
    lengths(outcome(status = status_many, prize = 2:4, chosen_door = 3L)),
    c(stick = 1L, change = 1L)
  )
)

expect_silent(
  expect_true(
    all(unlist(outcome(status = status_many, prize = 2:4, chosen_door = 3L)) %in%
          c(TRUE, FALSE))
  )
)

##### Erroneous input #####
expect_error(
  outcome(status = c(TRUE, TRUE), prize = 1L, chosen_door = 1L),
  pattern = "'length(status)' should be at least three", fixed = TRUE
)

expect_error(
  outcome(status = c(0, 1, 0), prize = 1L, chosen_door = 1L),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  outcome(status = c(FALSE, NA, FALSE), prize = 1L, chosen_door = 1L),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, FALSE, FALSE), prize = 1L, chosen_door = 1L),
  pattern = "At least two values in 'status' should be 'TRUE'", fixed = TRUE
)

expect_error(
  outcome(status = status),
  pattern = "argument \"prize\" is missing, with no default", fixed = TRUE
)

expect_error(
  outcome(status = status, chosen_door = 1L),
  pattern = "argument \"prize\" is missing, with no default", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE), prize = 4L, chosen_door = 1L),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  outcome(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = c(2:4, 8L),
          chosen_door = 1L),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, FALSE), prize = 3L, chosen_door = 1L),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  outcome(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = 2:5,
          chosen_door = 1L),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE), prize = 4.1, chosen_door = 1L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = c(2, 3, 4.1),
          chosen_door = 1L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE), prize = "a", chosen_door = 1L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = "a",
          chosen_door = 1L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = rep(TRUE, 3L), prize = integer(0), chosen_door = 1L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = rep(TRUE, 3L), prize = numeric(0), chosen_door = 1L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = status, prize = 1L),
  pattern = "argument \"chosen_door\" is missing, with no default",
  fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = 4),
  pattern = "'chosen_door' should not be larger than 'length(status)'",
  fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, FALSE), prize = 1L, chosen_door = 3),
  pattern = "'status[chosen_door]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = 4.1),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = "a"),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = c(TRUE, TRUE, TRUE, TRUE), prize = 1L, chosen_door = 3:4),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = rep(TRUE, 3L), prize = 1L, chosen_door = integer(0)),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  outcome(status = rep(TRUE, 3L), prize = 1L, chosen_door = numeric(0)),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)


#### Remove objects used in tests ####
rm(status, status_many)
