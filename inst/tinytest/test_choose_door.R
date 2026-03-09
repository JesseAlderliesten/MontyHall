#### Test the examples ####
# Examples are tested in the file test_play_MontyHall.R.


#### Tests ####
expect_true(choose_door(status = rep(TRUE, 3L)) %in% 1:3)
expect_true(choose_door(status = rep(TRUE, 3L), chosen_door = 1L) %in% 2:3)
expect_true(choose_door(status = rep(TRUE, 3L), chosen_door = 1 - 1e-8) %in% 2:3)
expect_true(choose_door(status = rep(TRUE, 4L)) %in% 1:4)
expect_true(choose_door(status = c(FALSE, TRUE, TRUE, TRUE)) %in% 2:4)
expect_true(choose_door(status = c(TRUE, FALSE, TRUE, TRUE)) %in% c(1L, 3:4))
expect_true(choose_door(status = c(TRUE, TRUE, FALSE, TRUE)) %in% c(1:2, 4L))
expect_true(choose_door(status = c(TRUE, TRUE, TRUE, FALSE)) %in% 1:3)


##### Erroneous input #####
expect_error(
  choose_door(status = c(TRUE, TRUE)),
  pattern = "'length(status)' should be at least three", fixed = TRUE
)

expect_error(
  choose_door(status = c(0, 1, 0)),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  choose_door(status = c(FALSE, NA, FALSE)),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  choose_door(status = c(TRUE, FALSE, FALSE)),
  pattern = "At least two values in 'status' should be 'TRUE'", fixed = TRUE
)

expect_error(
  choose_door(status = c(TRUE, TRUE, TRUE), chosen_door = 4),
  pattern = "'chosen_door' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  choose_door(status = c(TRUE, TRUE, FALSE), chosen_door = 3),
  pattern = "'status[chosen_door]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  choose_door(status = c(TRUE, TRUE, TRUE), chosen_door = 4.1),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  choose_door(status = c(TRUE, TRUE, TRUE), chosen_door = "a"),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)
