warning("test_outcome not yet implemented correct tests")

#### Create objects to use in tests ####


#### Test the examples ####
# Examples are tested in the file test_play_MontyHall.R.


#### Tests ####

##### Erroneous input #####
expect_error(
  outcome(status = c(TRUE, TRUE), prize = 1, chosen_door = 1),
  pattern = "'length(status)' should be at least three", fixed = TRUE
)
