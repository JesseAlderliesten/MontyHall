#' Plot outcome of repeated Monty Hall games
#'
#' @inheritParams play_MontyHall_repeated
#' @param n_trials A single [natural][checkinput::all_natural()] number with
#' the number of trials, e.g., how many times to run [play_MontyHall_repeated].
#' @param sort_values `TRUE` or `FALSE`: sort values in the plot?
#' @param show_ranges `TRUE` or `FALSE`: show the ranges as dotted vertical
#' lines in the plot?
#' @param print_summary `TRUE` or `FALSE`: print a summary of the fraction of
#' games won for the different tactics?
#'
#' @details
#' The plot shows the fraction of games won for each trial. Solid vertical lines
#' indicate the median value of all trials and, if `show_ranges` is `TRUE`,
#' dotted vertical lines show the ranges. The colours indicate the used tactic.
#'
#' It is easier to compare the overall chances of winning for the different
#' tactics if `sort_values` is `TRUE`, but then the linkage between the tactics
#' is broken. In contrast, if `sort_values` is `FALSE`, the
#'
#' @returns
#' A list of length two, returned [invisibly][invisible]. Each element contains
#' a numeric vector with a length equal to `n_trials`, containing the fraction
#' of games the contestant won by choosing a door with a prize behind it:
#'
#' - element `frac_won_stick`: the contestant sticks to the initial choice made
#'   before the host revealed what was behind one of the closed doors
#' - element `frac_won_change`: the contestant changes to another door after the
#'   host revealed what was behind one of the closed doors
#'
#' @section Side effects:
#' A summary of the outcomes is plotted.
#'
#' @examples
#' plot_MontyHall_repeated(n_doors = 3, n_prizes = 1, n_games = 100, n_trials = 50,
#'                         sort_values = TRUE, show_ranges = TRUE, print_summary = TRUE)
#' plot_MontyHall_repeated(n_doors = 10, n_prizes = 3, n_games = 100, n_trials = 50,
#'                         sort_values = FALSE, show_ranges = FALSE, print_summary = FALSE)
#'
#' @export
plot_MontyHall_repeated <- function(n_doors = 3, n_prizes = 1, n_games = 100,
                                    n_trials = 100, sort_values = TRUE,
                                    show_ranges = TRUE, print_summary = TRUE) {
  stopifnot(checkinput::is_natural(n_trials), checkinput::is_logical(sort_values),
            checkinput::is_logical(sort_values),
            checkinput::is_logical(print_summary))
  n_trials <- as.integer(round(n_trials))

  frac_won_stick <- vector(mode = "numeric", length = n_trials)
  frac_won_change <- frac_won_stick
  for(i in seq_len(n_trials)) {
    out <- play_MontyHall_repeated(n_doors = n_doors, n_prizes = n_prizes,
                                   n_games = n_games)
    frac_won_stick[i] <- sum(out$stick) / n_games
    frac_won_change[i] <- sum(out$change) / n_games
  }

  subtitle <- paste0(n_doors, " doors and ", n_prizes, " prizes per game, ",
                     n_games, " games per trial, ", n_trials, " trials")
  if(sort_values) {
    subtitle <- paste0(
      subtitle, "\nPoints above each other not necessarily come from the same trial")
    plot(main = "Simulating the Monty Hall game", sub = subtitle,
         x = "", y = "", xlab = "",
         ylab = "Fraction of games won",
         xaxt = "n", xlim = c(1, n_trials),
         ylim = c(0, 1.05 * max(frac_won_stick, frac_won_change)),
         cex.axis = 1.3, cex.lab = 1.3)
  } else {
    subtitle <- paste0(
      subtitle, "\nPoints above each other come from the same trial")
    plot(main = "Simulating the Monty Hall game", sub = subtitle,
         x = "", y = "", xlab = "Trial", ylab = "Fraction of games won",
         xlim = c(1, n_trials),
         ylim = c(0, 1.05 * max(frac_won_stick, frac_won_change)),
         cex.axis = 1.3, cex.lab = 1.3)
  }
  grid()
  legend("bottomright", title = "Tactic", legend = c("Stick", "Change"),
         pch = 20, col = c(1, 2), cex = 1.3)

  if(sort_values) {
    points(x = seq_len(n_trials), y = sort(frac_won_stick), type = 'p', pch = 20, col = 1)
    points(x = seq_len(n_trials), y = sort(frac_won_change), type = 'p', pch = 20, col = 2)
  } else {
    points(x = seq_len(n_trials), y = frac_won_stick, type = 'p', pch = 20, col = 1)
    points(x = seq_len(n_trials), y = frac_won_change, type = 'p', pch = 20, col = 2)
  }
  abline(h = median(frac_won_stick), col = 1)
  abline(h = median(frac_won_change), col = 2)

  if(show_ranges) {
    abline(h = min(frac_won_stick), col = 1, lty = 2)
    abline(h = max(frac_won_stick), col = 1, lty = 2)
    abline(h = min(frac_won_change), col = 2, lty = 2)
    abline(h = max(frac_won_change), col = 2, lty = 2)
  }

  if(print_summary) {
    print(rbind(stick = summary(frac_won_stick),
                change = summary(frac_won_change)))
  }

  invisible(list(frac_won_stick = frac_won_stick,
                 frac_won_change = frac_won_change))
}
