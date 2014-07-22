Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I start a new game

    Then I am asked for 2 player names
    Then I fill in 2 player names
    Then I press the "Play!" button
    Then I should be brought to the welcome page

  Scenario: Someone does not enter name
		Given I am on the registration page
		Then I am asked for 2 player names
    Then I press the "Play!" button
    Then I should not be brought to the welcome page