Feature: Prime Time

  Scenario: Input non-prime number, get false response

    Given 1 is not a prime number
    When I input 1
    Then I get a false response

  Scenario: Input prime number, get true response

    Given 2 is a prime number
    When I input 2
    Then I get a true response
