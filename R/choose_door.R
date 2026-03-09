#' The contestant chooses a closed door
#'
#' The contestant chooses a closed door behind which the price might be
#'
#' @inheritParams reveal_door
#' @param status A logical vector of length `n_doors` (at least three) with the
#' status of the doors (`TRUE` for closed doors, `FALSE` for open doors): can
#' use element `status` of the output of [setup_MontyHall()].
#'
#' @details
#' At least two doors should be closed. `chosen_door` should be provided if the
#' participant changes to another door.
#'
#' @returns
#' A single [integer] with the index of the door chosen by the contestant.
#'
#' @seealso
#' [play_MontyHall] to play the game once and [play_MontyHall_repeated] to play
#' the game repeatedly.
#'
#' @examples
#' set.seed(314)
#' (setup <- setup_MontyHall(n_doors = 3, n_prizes = 1))
#' (chosen_door <- choose_door(status = setup$status))
#'
#' @export
choose_door <- function(status, chosen_door = NULL) {
  if(!is.null(chosen_door)) {
    stopifnot(checkinput::is_natural(chosen_door))
    chosen_door <- as.integer(round(chosen_door))
  }
  check_status(status = status, chosen_door = chosen_door)

  if(!is.null(chosen_door)) {
    status[chosen_door] <- FALSE
  }
  sample_safe(x = which(status), size = 1L)
}
