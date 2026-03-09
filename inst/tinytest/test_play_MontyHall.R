#### Create objects to use in tests ####
set.seed(314)
play_normal <- play_MontyHall(n_doors = 3, n_prizes = 1)
play_large <- play_MontyHall(n_doors = 10, n_prizes = 3)
play_noninteger <- play_MontyHall(n_doors = 5 - 1e-10, n_prizes = 1 - 1e-10)
play_once <- play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 1)
play_repeated <- play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 100)


#### Test the examples ####
# Examples are tested in 'Tests' below.


#### Tests ####
expect_silent(
  expect_identical(
    lengths(play_normal), c(stick = 1L, change = 1L)
  )
)

expect_silent(
  expect_true(
    all(unlist(play_normal) %in% c(TRUE, FALSE))
  )
)

expect_silent(
  expect_identical(
    lengths(play_large), c(stick = 1L, change = 1L)
  )
)

expect_silent(
  expect_true(
    all(unlist(play_large) %in% c(TRUE, FALSE))
  )
)

expect_silent(
  expect_identical(
    lengths(play_noninteger), c(stick = 1L, change = 1L)
  )
)

expect_silent(
  expect_true(
    all(unlist(play_noninteger) %in% c(TRUE, FALSE))
  )
)

expect_silent(
  expect_identical(
    lengths(play_once), c(stick = 1L, change = 1L)
  )
)

expect_silent(
  expect_true(
    all(unlist(play_once) %in% c(TRUE, FALSE))
  )
)

expect_silent(
  expect_identical(
    lengths(play_repeated), c(stick = 100L, change = 100L)
  )
)

expect_silent(
  expect_true(
    all(unlist(play_repeated) %in% c(TRUE, FALSE))
  )
)

##### Erroneous input #####
expect_error(
  play_MontyHall(n_doors = "a"),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_doors = 3.1),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_doors = 2),
  pattern = "n_doors >= 3L is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_doors = 0),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_prizes = "a"),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_prizes = 3.1),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_prizes = 0),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_prizes = 0),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall(n_doors = 3, n_prizes = 2),
  pattern = "n_prizes <= n_doors - 2L is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = "a", n_games = 100),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3.1, n_games = 100),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 2, n_games = 100),
  pattern = "n_doors >= 3L is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 0, n_games = 100),
  pattern = "checkinput::is_natural(n_doors) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_prizes = "a", n_games = 100),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_prizes = 3.1, n_games = 100),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_prizes = 0, n_games = 100),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_prizes = 0, n_games = 100),
  pattern = "checkinput::is_natural(n_prizes) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 2, n_games = 100),
  pattern = "n_prizes <= n_doors - 2L is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = "a"),
  pattern = "checkinput::is_natural(n_games) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 3.1),
  pattern = "checkinput::is_natural(n_games) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 0),
  pattern = "checkinput::is_natural(n_games) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = "a"),
  pattern = "checkinput::is_natural(n_games) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 3.1),
  pattern = "checkinput::is_natural(n_games) is not TRUE", fixed = TRUE
)

expect_error(
  play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 0),
  pattern = "checkinput::is_natural(n_games) is not TRUE", fixed = TRUE
)


#### Remove objects used in tests ####
rm(play_large, play_noninteger, play_normal, play_once, play_repeated)
