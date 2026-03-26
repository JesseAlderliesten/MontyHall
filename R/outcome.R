#' Get the outcome of the Monty Hall game
#'
#' Get the outcome of the Monty Hall game if the contestant sticks to the
#' initial choice or changes to another door.
#'
#' @inheritParams reveal_door
#'
#' @details
#' `status` here is the status after the host has revealed what is behind one of
#' the doors.
#'
#' @returns
#' A list of length two, each containing a vector with the same length as the
#' number of games that were played, containing `TRUE` or `FALSE` indicating if
#' the contestant chose a door with a prize behind it:
#'
#' - element `stick`: the contestant sticks to the initial choice made before
#'   the host revealed what was behind one of the closed doors
#' - element `change`: the contestant changes to another door after the host
#'   revealed what was behind one of the closed doors
#'
#' @seealso
#' [play_MontyHall] to play the game once and [play_MontyHall_repeated] to play
#' the game repeatedly.
#'
#' @examples
#' set.seed(314)
#' (setup <- setup_MontyHall(n_doors = 3, n_prizes = 1))
#' (chosen_door <- choose_door(status = setup$status))
#' (new_status <- reveal_door(status = setup$status, prize = setup$prize,
#'                            chosen_door = chosen_door))
#' (outcome(status = new_status, prize = setup$prize,
#'          chosen_door = chosen_door))
#'
#' @export
outcome <- function(status, prize, chosen_door) {
  prize <- checkinput::make_natural(prize, all = TRUE)
  chosen_door <- checkinput::make_natural(chosen_door, all = FALSE)
  check_status(status = status, prize = prize, chosen_door = chosen_door)

  list(stick = chosen_door %in% prize,
       change = choose_door(status = status, chosen_door = chosen_door) %in% prize)
}
