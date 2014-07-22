Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I follow "New Game"
    Then I should see "Players, please enter your names."
    Then the "placeholder" field within "New Game" should contain "Enter your name here"
   	When I fill in "Jenny" for "Player 1:" within "New Game"
   	And I fill in "Jamie" for "Player 2:" within "New Game"
    Then I press "Submit" within "New Game"
    Then I am on the registration success page

@wip
	  Scenario: Player does not enter name
	  Given I am on the new game page
		Then I should see "Players, please enter your names."
    Then the "placeholder" field within "New Game" should contain "Enter your name here"
   	And I fill in "" for "Player 1:" within "New Game"
   	And I fill in "" for "Player 2:" within "New Game"
    Then I press "Play!" within "New Game"
    Then I should see an error
#to run, use $ cucumber -t wip