#' Play the Monty Hall game
#'
#' @inheritParams setup_MontyHall
#' @param n_games A [natural][checkinput::all_natural()] number giving the
#' number of games to play.
#'
#' @inherit outcome return
#'
#' @section Programming notes:
#' Rewrite using [apply] instead of a [for][Control]-loop, then adjust to use
#' parallel processing, e.g., using package `parallel`, see
#' `optim_bruteforce_knip.R`.
#'
#' @examples
#' #### Play typical game once
#' set.seed(314)
#' play_MontyHall(n_doors = 3, n_prizes = 1)
#'
#' # Same as:
#' set.seed(314)
#' (setup <- setup_MontyHall(n_doors = 3, n_prizes = 1))
#' (chosen_door <- choose_door(status = setup$status))
#' (new_status <- reveal_door(status = setup$status, prize = setup$prize,
#'                            chosen_door = chosen_door))
#' (outcome(status = new_status, prize = setup$prize,
#'          chosen_door = chosen_door))
#'
#' #### Play game with multiple doors and multiple prizes once
#' set.seed(314)
#' play_MontyHall(n_doors = 10, n_prizes = 3)
#'
#' # Same as:
#' set.seed(314)
#' (setup <- setup_MontyHall(n_doors = 10, n_prizes = 3))
#' (chosen_door <- choose_door(status = setup$status))
#' (new_status <- reveal_door(status = setup$status, prize = setup$prize,
#'                            chosen_door = chosen_door))
#' (outcome(status = new_status, prize = setup$prize,
#'          chosen_door = chosen_door))
#'
#' #### Play typical game a hundred times
#' set.seed(314)
#' many_games <- play_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 100)
#' (frac_won_stick <- length(which(many_games$stick)) / length(many_games$stick))
#' (frac_won_change <- length(which(many_games$change)) / length(many_games$change))
#'
#' @export
play_MontyHall <- function(n_doors = 3, n_prizes = 1) {
  initial <- setup_MontyHall(n_doors = n_doors, n_prizes = n_prizes)
  chosen_door <- choose_door(status = initial$status)
  new_status <- reveal_door(status = initial$status, prize = initial$prize,
                            chosen_door = chosen_door)
  outcome(status = new_status, prize = initial$prize,
          chosen_door = chosen_door)
}

#' @rdname play_MontyHall
#' @export
play_MontyHall_repeated <- function(n_doors = 3, n_prizes = 1, n_games = 100) {
  stopifnot(checkinput::is_natural(n_games))
  n_games <- as.integer(round(n_games))

  stick <- rep(NA, n_games)
  change <- stick

  for(i in seq_len(n_games)) {
    outcome <- play_MontyHall(n_doors = n_doors, n_prizes = n_prizes)
    stick[i] <- outcome$stick
    change[i] <- outcome$change
  }
  list(stick = stick, change = change)
}
