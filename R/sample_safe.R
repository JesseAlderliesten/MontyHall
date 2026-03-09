#' Safe drop-in replacement for sample
#'
#' @inheritParams base::sample
#' @param x A vector of one or more elements from which to choose. Can be
#' zero-length to return the object.
#'
#' @details
#' The base-\R function [sample()] is *unsafe* if `x` can vary in length, as
#' as noted in the section `Details` of its documentation:
#'
#' - if `x` is a [length]-one [numeric][is.numeric()] with a
#'   [finite][is.finite()] value [equal to or larger than][Comparison] one,
#'   samples are taken from `1:x`, e.g., `sample(3)` samples from `c(1, 2, 3)`.
#' - otherwise, samples are taken from `x`, e.g., `sample(c(3, 4))` samples from
#'   `c(3, 4)`.
#'
#' In contrast, function `sample_safe()` *always* samples from `x`.
#'
#' See section `Details` of [sample()] for further details.
#'
#' @returns
#' A vector of length `size` with elements drawn from `x`.
#'
#' @section Programming notes:
#' `sample_safe()` is similar to `resample()` defined in the `Examples` of
#' [sample()] as safer alternative to [sample()], but uses named arguments when
#' passing them to [sample.int()] instead of relying on positional matching and
#' determines `size` from the length of `x` if `size` is missing.
#'
#' @seealso
#' [sample()]; package [strict](https://github.com/hadley/strict) which gives an
#' error if [sample()] is used with length-one input; [Distributions] to draw
#' random numbers from distributions.
#'
#' @examples
#' # Taken from the examples in help(sample)
#'
#' x <- 1:10
#' sample_safe(x = x) # a random permutation
#' sample_safe(x = c(0, 1), size = 5, replace = TRUE) # five Bernoulli trials
#'
#' # Comparing sample() and sample_safe()
#' sample(x = x[x > 8]) # length two: c(9, 10) or c(10, 9)
#' sample(x = x[x > 9]) # length ten (!): random permutation of 1:10
#' sample(x = x[x > 10]) # length zero: integer(0)
#'
#' sample_safe(x = x[x > 8]) # length two: c(9, 10) or c(10, 9)
#' sample_safe(x = x[x > 9]) # length one: 10
#' sample_safe(x = x[x > 10]) # length zero: integer(0)
#'
#' @export
sample_safe <- function(x, size, replace = FALSE, prob = NULL) {
  stopifnot(is.null(prob) || checkinput::all_nonnegative(prob))

  length_x <- length(x)
  if(missing(size)) {
    size <- length_x
  }
  x[sample.int(n = length_x, size = size, replace = replace, prob = prob)]
}
