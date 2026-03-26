#' Setup Monty Hall game
#'
#' @param n_doors A [natural][checkinput::all_natural()] number giving the used
#' number of doors. Should be at least three.
#' @param n_prizes A [natural][checkinput::all_natural()] number giving the
#' number of prizes to be hidden. `n_prizes` should be at least one and at least
#' two smaller than `n_doors`.
#'
#' @returns
#' A [list] of length two containing two elements:
#'
#' - `status` with a logical vector of length `n_doors` with the status of the
#'   doors: `TRUE` for closed doors, `FALSE` for open doors
#' - `prize` with an [integer] vector of length `n_prizes` with the indices of
#'   the doors behind which a prize is hidden.
#'
#' @section Programming notes:
#' Check [rep.int()].
#'
#' @seealso
#' [play_MontyHall] to play the game once and [play_MontyHall_repeated] to play
#' the game repeatedly.
#'
#' @examples
#' # Typical game
#' set.seed(314)
#' setup_MontyHall(n_doors = 3, n_prizes = 1)
#'
#' # Game with many doors and multiple prizes
#' set.seed(314)
#' setup_MontyHall(n_doors = 10, n_prizes = 3)
#'
#' @export
setup_MontyHall <- function(n_doors = 3, n_prizes = 1) {
  n_doors <- checkinput::make_natural(n_doors, all = FALSE)
  n_prizes <- checkinput::make_natural(n_prizes, all = FALSE)
  stopifnot(n_doors >= 3L, n_prizes >= 1L, n_prizes <= n_doors - 2L)

  status <- rep(TRUE, n_doors)

  list(status = status,
       prize = sample_safe(x = which(status), size = n_prizes))
}
