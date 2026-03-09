#### Create objects to use in tests ####
status <- c(TRUE, TRUE, TRUE)
reveal_p1_c1 <- reveal_door(status = status, prize = 1L, chosen_door = 1L)
reveal_p1_c2 <- reveal_door(status = status, prize = 1L, chosen_door = 2L)
reveal_p1_c3 <- reveal_door(status = status, prize = 1L, chosen_door = 3L)

reveal_p2_c1 <- reveal_door(status = status, prize = 2L, chosen_door = 1L)
reveal_p2_c2 <- reveal_door(status = status, prize = 2L, chosen_door = 2L)
reveal_p2_c3 <- reveal_door(status = status, prize = 2L, chosen_door = 3L)

reveal_p3_c1 <- reveal_door(status = status, prize = 3L, chosen_door = 1L)
reveal_p3_c2 <- reveal_door(status = status, prize = 3L, chosen_door = 2L)
reveal_p3_c3 <- reveal_door(status = status, prize = 3L, chosen_door = 3L)

reveal_many <- reveal_door(status = c(rep(TRUE, 4), rep(FALSE, 3)),
                           prize = 2:4, chosen_door = 3L)


#### Test the examples ####
# Examples are tested in the file test_play_MontyHall.R.


#### Tests ####
expect_true(isTRUE(all.equal(reveal_p1_c1, c(TRUE, FALSE, TRUE))) ||
              isTRUE(all.equal(reveal_p1_c1, c(TRUE, TRUE, FALSE))))
expect_true(isTRUE(all.equal(reveal_p1_c2, c(TRUE, TRUE, FALSE))))
expect_true(isTRUE(all.equal(reveal_p1_c3, c(TRUE, FALSE, TRUE))))

expect_true(isTRUE(all.equal(reveal_p2_c1, c(TRUE, TRUE, FALSE))))
expect_true(isTRUE(all.equal(reveal_p2_c2, c(FALSE, TRUE, TRUE))) ||
              isTRUE(all.equal(reveal_p2_c2, c(TRUE, TRUE, FALSE))))
expect_true(isTRUE(all.equal(reveal_p2_c3, c(FALSE, TRUE, TRUE))))

expect_true(isTRUE(all.equal(reveal_p3_c1, c(TRUE, FALSE, TRUE))))
expect_true(isTRUE(all.equal(reveal_p3_c2, c(FALSE, TRUE, TRUE))))
expect_true(isTRUE(all.equal(reveal_p3_c3, c(FALSE, TRUE, TRUE))) ||
              isTRUE(all.equal(reveal_p3_c3, c(TRUE, FALSE, TRUE))))

expect_identical(length(reveal_many), 7L)
expect_true(isTRUE(all(reveal_many %in% c(TRUE, FALSE))))

##### Erroneous input #####
expect_error(
  reveal_door(prize = 1L, chosen_door = 1L),
  pattern = "argument \"status\" is missing, with no default", fixed = TRUE
)

expect_error(
  reveal_door(status = status, chosen_door = 1L),
  pattern = "argument \"prize\" is missing, with no default", fixed = TRUE
)

expect_error(
  reveal_door(status = status, prize = 1L),
  pattern = "argument \"chosen_door\" is missing, with no default", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE), prize = 1L, chosen_door = 1L),
  pattern = "'length(status)' should be at least three", fixed = TRUE
)

expect_error(
  reveal_door(status = c(0, 1, 0), prize = 1L, chosen_door = 1L),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  reveal_door(status = c(FALSE, NA, FALSE), prize = 1L, chosen_door = 1L),
  pattern = "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'",
  fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, FALSE, FALSE), prize = 1L, chosen_door = 1L),
  pattern = "At least two values in 'status' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 4L, chosen_door = 2L),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = c(2:4, 8L),
              chosen_door = 2L),
  pattern = "'prize' should not be larger than 'length(status)'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, FALSE), prize = 3L, chosen_door = 2L),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = 2:5,
              chosen_door = 2L),
  pattern = "'status[prize]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 4.1, chosen_door = 2L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = c(2, 3, 4.1),
              chosen_door = 2L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = "a", chosen_door = 2L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(rep(TRUE, 4), rep(FALSE, 3)), prize = "a",
              chosen_door = 2L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = rep(TRUE, 3L), prize = integer(0), chosen_door = 2L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = rep(TRUE, 3L), prize = numeric(0), chosen_door = 2L),
  pattern = "checkinput::all_natural(prize) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = 4),
  pattern = "'chosen_door' should not be larger than 'length(status)'",
  fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, FALSE), prize = 1L, chosen_door = 3),
  pattern = "'status[chosen_door]' should be 'TRUE'", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = 4.1),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = "a"),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = c(TRUE, TRUE, TRUE, TRUE), prize = 1L, chosen_door = 3:4),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = rep(TRUE, 3L), prize = 1L, chosen_door = integer(0)),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)

expect_error(
  reveal_door(status = rep(TRUE, 3L), prize = 1L, chosen_door = numeric(0)),
  pattern = "checkinput::is_natural(chosen_door) is not TRUE", fixed = TRUE
)


#### Remove objects used in tests ####
rm(reveal_many, reveal_p1_c1, reveal_p1_c2, reveal_p1_c3, reveal_p2_c1,
   reveal_p2_c2, reveal_p2_c3, reveal_p3_c1, reveal_p3_c2, reveal_p3_c3, status)
