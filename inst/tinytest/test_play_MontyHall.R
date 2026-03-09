warning("Determine thresholds for proportions in 'many_games <-",
        " play_MontyHall_repeated(n_doors = 3L, n_prizes = 1L, n_games = 100L)',
        e.g., when forgetting to omit initial choice, or forget to take revealed door into account")
warning("test_play_MontyHall not yet implemented correct tests")

#### Create objects to use in tests ####
status <- c(TRUE, TRUE, TRUE)
reveal_p1_c1 <- reveal_door(status = status, prize = 1, chosen_door = 1)
reveal_p1_c2 <- reveal_door(status = status, prize = 1, chosen_door = 2)
reveal_p1_c3 <- reveal_door(status = status, prize = 1, chosen_door = 3)

reveal_p2_c1 <- reveal_door(status = status, prize = 2, chosen_door = 1)
reveal_p2_c2 <- reveal_door(status = status, prize = 2, chosen_door = 2)
reveal_p2_c3 <- reveal_door(status = status, prize = 2, chosen_door = 3)

reveal_p3_c1 <- reveal_door(status = status, prize = 3, chosen_door = 1)
reveal_p3_c2 <- reveal_door(status = status, prize = 3, chosen_door = 2)
reveal_p3_c3 <- reveal_door(status = status, prize = 3, chosen_door = 3)


#### Test the examples ####
# Examples are tested in the file test_play_MontyHall.R.


#### Tests ####
expect_true(all(reveal_p1_c1 == c(TRUE, FALSE, TRUE)) ||
              all(reveal_p1_c1 == c(TRUE, TRUE, FALSE)))
expect_true(all(reveal_p1_c2 == c(TRUE, TRUE, FALSE)))
expect_true(all(reveal_p1_c3 == c(TRUE, FALSE, TRUE)))

expect_true(all(reveal_p2_c1 == c(TRUE, TRUE, FALSE)))
expect_true(all(reveal_p2_c2 == c(FALSE, TRUE, TRUE)) ||
              all(reveal_p2_c2 == c(TRUE, TRUE, FALSE)))
expect_true(all(reveal_p2_c3 == c(FALSE, TRUE, TRUE)))

expect_true(all(reveal_p3_c1 == c(TRUE, FALSE, TRUE)))
expect_true(all(reveal_p3_c2 == c(FALSE, TRUE, TRUE)))
expect_true(all(reveal_p3_c3 == c(FALSE, TRUE, TRUE)) ||
              all(reveal_p3_c3 == c(TRUE, FALSE, TRUE)))

##### Erroneous input #####
expect_error(
  reveal_door(status = c(TRUE, TRUE), prize = 1, chosen_door = 1),
  pattern = "'length(status)' should be at least three", fixed = TRUE
)

expect_error(
  reveal_door(status = c(0, 1, 0), prize = 1, chosen_door = 1),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(FALSE, NA, FALSE), prize = 1, chosen_door = 1),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, FALSE, FALSE), prize = 1, chosen_door = 1),
  pattern = "At least two values in 'status' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(FALSE, TRUE, TRUE, TRUE), prize = 1, chosen_door = 2),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(FALSE, TRUE, TRUE, TRUE), prize = 2, chosen_door = 1),
  pattern = "'status[chosen_door]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 0, chosen_door = 1),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 1, chosen_door = 0),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 4, chosen_door = 1),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 1, chosen_door = 4),
  pattern = "'chosen_door' should not be larger than 'length(status)'",
  fixed = TRUE
)
