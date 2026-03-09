
![](https://img.shields.io/github/r-package/v/JesseAlderliesten/MontyHall?color=blue)

# MontyHall

With `MontyHall` you can simulate the Monty Hall game as an illustration
of simulation studies.

This package is still under development and thus *unstable*.

## Installation

You can install `MontyHall` from
[GitHub](https://github.com/JesseAlderliesten/MontyHall) with:

``` r
if(!requireNamespace("remotes", quietly = TRUE)) {
  install.packages(pkgs = "remotes", quiet = FALSE)
}
remotes::install_github(repo = "JesseAlderliesten/MontyHall", dependencies = TRUE,
                        upgrade = FALSE, force = FALSE, quiet = FALSE,
                        build_vignettes = TRUE, lib = NULL,
                        verbose = getOption("verbose"))
```

For information about installing and configuring R and RStudio, see my
repository
[checkrpkgs](https://github.com/JesseAlderliesten/checkrpkgs).

## Examples

Play a typical game a thousand times:

``` r
library(MontyHall)
set.seed(314)

many_games <- play_MontyHall_repeated(n_doors = 3L, n_prizes = 1L, n_games = 1000L)
length(which(many_games$stick)) / length(many_games$stick)
#> [1] 0.31
length(which(many_games$change)) / length(many_games$change)
#> [1] 0.69
```

Play a single game with a hundred doors and three prizes (NB. Currently
only a single door is opened before the contestant gets the choice to
stick to the originally chosen door or change to another door):

``` r
library(MontyHall)
set.seed(314)

play_MontyHall(n_doors = 10L, n_prizes = 3L)
#> $stick
#> [1] FALSE
#> 
#> $change
#> [1] FALSE

# Same as:
set.seed(314)
(setup <- setup_MontyHall(n_doors = 10L, n_prizes = 3L))
#> $status
#>  [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
#> 
#> $prize
#> [1]  3  4 10
(chosen_door <- choose_door(status = setup$status))
#> [1] 7
(new_status <- reveal_door(status = setup$status, prize = setup$prize,
                           chosen_door = chosen_door))
#>  [1]  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
(outcome(status = new_status, prize = setup$prize,
         chosen_door = chosen_door))
#> $stick
#> [1] FALSE
#> 
#> $change
#> [1] FALSE
```

# Alternatives

Many packages for Monty Hall simulations exist on
[GitHub](https://github.com/). I have not yet browsed through them.
