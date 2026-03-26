#' Reveal a door
#'
#' The host opens a closed door to reveal what is behind it. It is *not* the
#' door chosen by the contestant and *not* a door with a price behind it.
#'
#' @inheritParams choose_door
#' @param prize A vector with [natural][checkinput::all_natural()] numbers
#' giving the indices of the doors behind which a prize is hidden: can use
#' element `prize` of the output of [setup_MontyHall()].
#' @param chosen_door A single [natural][checkinput::all_natural()] number with
#' the index of the door chosen by the contestant: can use the output of
#' [choose_door()].
#'
#' @details
#' At least two doors should be closed.
#'
#' @returns
#' `status` with one more open door that was revealed by the host: a logical
#' vector of length `n_doors` with the status of the doors: `TRUE` for closed
#' doors, `FALSE` for open doors.
#'
#' @section Programming notes:
#' For games with more than three doors, you can reveal more doors.
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
#'
#' @export
reveal_door <- function(status, prize, chosen_door) {
  prize <- checkinput::make_natural(prize, all = TRUE)
  chosen_door <- checkinput::make_natural(chosen_door, all = FALSE)

  check_status(status = status, prize = prize, chosen_door = chosen_door)

  ind_revealed <- sample_safe(
    x = progutils::not_in(x = which(status), table = c(prize, chosen_door)),
    size = 1L)
  status[ind_revealed] <- FALSE
  status
}
