#### Create objects to use in tests ####
status <- c(TRUE, TRUE, TRUE)


#### Test the examples ####
# Examples are tested in the file test_play_MontyHall.R.


#### Tests ####
expect_silent(expect_null(check_status(status = status)))
expect_silent(expect_null(check_status(status = status, prize = 1L)))
expect_silent(expect_null(check_status(status = status, chosen_door = 1L)))

expect_silent(expect_null(check_status(status = status, prize = 1L, chosen_door = 1L)))
expect_silent(expect_null(check_status(status = status, prize = 1L, chosen_door = 2L)))
expect_silent(expect_null(check_status(status = status, prize = 1L, chosen_door = 3L)))

expect_silent(expect_null(check_status(status = status, prize = 2L, chosen_door = 1L)))
expect_silent(expect_null(check_status(status = status, prize = 2L, chosen_door = 2L)))
expect_silent(expect_null(check_status(status = status, prize = 2L, chosen_door = 3L)))

expect_silent(expect_null(check_status(status = status, prize = 3L, chosen_door = 1L)))
expect_silent(expect_null(check_status(status = status, prize = 3L, chosen_door = 2L)))
expect_silent(expect_null(check_status(status = status, prize = 3L, chosen_door = 3L)))

expect_silent(expect_null(check_status(status = c(rep(TRUE, 4), rep(FALSE, 3)),
                                       prize = 2:4, chosen_door = 3L)))

##### Erroneous input #####
expect_error(
  check_status(status = c(TRUE, TRUE)),
  pattern = "'length(status)' should be at least three", fixed = TRUE
)

expect_error(
  check_status(status = c(0, 1, 0)),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  check_status(status = c(FALSE, NA, FALSE)),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, FALSE, FALSE)),
  pattern = "At least two values in 'status' should be 'TRUE'", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE), prize = 4L),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  check_status(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = c(2:4, 8L)),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, FALSE), prize = 3L),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  check_status(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = 2:5),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE), prize = 4.1),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = c(2, 3, 4.1)),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE), prize = "a"),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = "a"),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = rep(TRUE, 3L), prize = integer(0)),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = rep(TRUE, 3L), prize = numeric(0)),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE), chosen_door = 4),
  pattern = "'chosen_door' should not be larger than 'length(status)'",
  fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, FALSE), chosen_door = 3),
  pattern = "'status[chosen_door]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE), chosen_door = 4.1),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE), chosen_door = "a"),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = c(TRUE, TRUE, TRUE, TRUE), chosen_door = 3:4),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = rep(TRUE, 3L), chosen_door = integer(0)),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  check_status(status = rep(TRUE, 3L), chosen_door = numeric(0)),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)


#### Remove objects used in tests ####
rm(status)
