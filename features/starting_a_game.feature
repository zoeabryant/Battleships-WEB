Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I follow "New Game"
    Then I should see "What's your name?"
    And the "placeholder" field within "input" should contain "Enter name here"
    And I fill in "Player 1" with "Jamie" within "input"
    And I fill in "Player 2" with "Jenny" within "input"
    And I press "submit" within "registration form"
    Then I am on the registration complete page


  Scenario: Failed registration
  	Given I am on the new game page
    Then I should see "What's your name?"
    And the "placeholder" field within "input" should contain "Enter name here"
    And I fill in "name" with "" within "input"
    Then I should see an error

