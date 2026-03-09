#' Check status
#'
#' Helper function to check the content of object `status`.
#'
#' @inheritParams reveal_door
#'
#' @returns
#' [NULL], returned [invisibly][invisible].
#'
#' @examples
#' check_status(status = c(TRUE, TRUE, TRUE))
#' check_status(status = c(TRUE, TRUE, TRUE), prize = 1L, chosen_door = 1L)
#' try(check_status(status = c(TRUE, TRUE)))
#' try(check_status(status = c(TRUE, FALSE, FALSE)))
#' try(check_status(status = c(TRUE, TRUE, FALSE), prize = 3L))
#' try(check_status(status = c(TRUE, TRUE, TRUE), prize = 1L))
#' try(check_status(status = c(TRUE, TRUE, FALSE), prize = 1L, chosen_door = 3))
#'
#' @export
check_status <- function(status, prize = NULL, chosen_door = NULL) {
  stopifnot(
    is.null(dim(status)),
    "'length(status)' should be at least three to use at least three doors" =
      length(status) >= 3L,
    "Values in 'status' should be either 'TRUE' or 'FALSE', not 'NA'" =
      is.logical(status) && !anyNA(status),
    "At least two values in 'status' should be 'TRUE', indicating closed doors" =
      sum(status) >= 2L
  )

  if(!is.null(prize)) {
    stopifnot(checkinput::all_natural(prize))
    prize <- as.integer(round(prize))

    stopifnot(
      "'prize' should not be larger than 'length(status)' to have the prize behind an existing door" =
        prize %in% seq_along(status),
      "'status[prize]' should be 'TRUE' to have the prize behind a closed door" =
        all(prize %in% which(status))
    )
  }

  if(!is.null(chosen_door)) {
    stopifnot(checkinput::is_natural(chosen_door))
    chosen_door <- as.integer(round(chosen_door))

    stopifnot(
      "'chosen_door' should not be larger than 'length(status)' to choose an existing door" =
        chosen_door %in% seq_along(status),
      "'status[chosen_door]' should be 'TRUE' to choose a closed door" =
        chosen_door %in% which(status)
    )
  }
  invisible(NULL)
}
