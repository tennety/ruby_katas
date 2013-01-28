Feature: Create the game
  In order to play the game
  I want to create a game
  So I can start it

  Scenario: Number of players required
    When I get help for "greed"
    Then the banner should document that this app's arguments are:
      |num_players|which is required|

  Scenario: Start the game
    When I run `greed 2` interactively
    Then the output should contain "Starting a game of Greed with 2 players..."
    Then the output should contain "Player 0's turn"

  # Scenario: Play a normal turn
  #   Given a new game with 2 players
  #   And it is player 1's turn
  #   Given the next roll is 5 5 5 2 3
  #   When player 1 rolls
  #   Then the output should contain "500"
  #   And the output should contain "two dice remaining"
  #   Given the next roll is 1 2
  #   When player 1 elects to roll again
  #   Then the output should contain "100"
  #   And the output should contain "one die remaining"
  #   When player 1 elects to not roll again
  #   Then the output should contain "600"

  #   Given the next roll is 1 2 3 3 4
  #   When player 2 rolls
  #   Then the output should contain "0"
  #   And the output should contain "no more rolls"



