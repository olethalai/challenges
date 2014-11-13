Feature: Letters Round

  In the Letters round, players compete to find the longest word using a set of 9 random letters, chosen at the beginning of the round by alternating players.

  Scenario: Player picks a letter to play with

    Given I am about to begin playing a Letters round
    When I choose a consonant
    Then a consonant is shown on the letters board

  Scenario: Player picks 9 consonants to play with

    Given I am about to begin playing a Letters round
    When I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    Then 9 consonants are shown on the letters board

  Scenario: Player picks 9 vowels to play with

    Given I am about to begin playing a Letters round
    When I choose a vowel
    And I choose a vowel
    And I choose a vowel
    And I choose a vowel
    And I choose a vowel
    And I choose a vowel
    And I choose a vowel
    And I choose a vowel
    And I choose a vowel
    Then 9 vowels are shown on the letters board

  Scenario: Player picks an assortment of 9 letters

    Given I am about to begin playing a Letters round
    When I choose a consonant
    And I choose a vowel
    And I choose a consonant
    And I choose a vowel
    And I choose a consonant
    And I choose a consonant
    And I choose a consonant
    And I choose a vowel
    And I choose a vowel
    Then 4 vowels are shown on the letters board
    And 5 consonants are shown on the letters board

  @wip
  Scenario: Player guesses valid word under 9 letters
    Player is awarded the same number of points as letters in the word.

    Given I have 3 points
    And I am playing a Letters round
    When the Countdown Clock stops
    And I guess a valid 7-letter word
    Then I am awarded 7 points
    And my total score is 10

  @wip
  Scenario: Player guesses valid 9-letter word
    Player is awarded double points for using all the letters.

    Given I have 7 points
    And I am playing a Letters round
    When the Countdown Clock stops
    And I guess a valid 9-letter word
    Then I am awarded 18 points
    And my total score is 25

  @wip
  Scenario: Player guesses invalid word
    Player is awarded no points.

    Given I have 10 points
    And I am playing a Letters round
    When the Countdown Clock stops
    And I guess an invalid 9-letter word
    Then I am awarded 0 points
    And my total score is 10
