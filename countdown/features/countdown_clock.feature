@countdown_clock
Feature: Countdown Clock

  The Countdown Clock is displayed to users during gameplay. It shows time elapsed and time remaining for the current round.

  Scenario Outline: Clock is visible and accurate at the beginning of rounds

    Given I am about to begin playing a <round>
    Then I can see the Countdown Clock
    And the Countdown Clock shows 30 seconds remaining

      @letters
      Examples:

      | round         |
      | Letters round |

      @numbers
      Examples:

      | round         |
      | Numbers round |

      @countdown_conundrum
      Examples:

      | round                 |
      | Countdown Conundrum   |

  Scenario Outline: Clock is visible and accurate during rounds

    Given I am playing a <round>
    When I have been playing for <x> seconds
    Then the Countdown Clock shows <y> seconds remaining

      @letters
      Examples:

      | round         | x     | y     |
      | Letters round | 1     | 29    |
      | Letters round | 5     | 25    |
      | Letters round | 10    | 20    |
      | Letters round | 24    | 6     |

      @numbers
      Examples:

      | round         | x     | y     |
      | Numbers round | 1     | 29    |
      | Numbers round | 5     | 25    |
      | Numbers round | 15    | 15    |
      | Numbers round | 27    | 3     |

      @countdown_conundrum
      Examples:

      | round                 | x     | y     |
      | Countdown Conundrum   | 1     | 29    |
      | Countdown Conundrum   | 5     | 25    |
      | Countdown Conundrum   | 18    | 12    |
      | Countdown Conundrum   | 29    | 1     |

  @countdown_conundrum
  Scenario: Clock is visible and accurate when paused during a Countdown Conundrum

    Given I am playing a Countdown Conundrum
    When I press my buzzer after 23 seconds
    Then the Countdown Clock shows 7 seconds remaining
    And I wait for 2 seconds
    Then the Countdown Clock shows 7 seconds remaining

  @letters
  Scenario: Clock is visible and accurate at the end of a Letters round

    Given I am playing a Letters round
    When the Countdown Clock stops
    Then the Countdown Clock shows 0 seconds remaining

  @numbers
  Scenario: Clock is visible and accurate at the end of a Numbers round

    Given I am playing a Numbers round
    When the Countdown Clock stops
    Then the Countdown Clock shows 0 seconds remaining

  @countdown_conundrum
  Scenario: Clock is visible and accurate at the end of a solved Countdown Conundrum

    Given I am playing a Countdown Conundrum
    And I press my buzzer after 14 seconds
    When I guess correctly
    Then the round ends
    And the Countdown Clock shows 16 seconds remaining

  @countdown_conundrum
  Scenario: Clock is visible and accurate at the end of an unsolved Countdown Conundrum

    Given I am playing a Countdown Conundrum
    And no guesses are made
    When the Countdown Clock stops
    Then the Countdown Clock shows 0 seconds remaining
