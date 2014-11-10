Feature: Show version number

  As a presentator
  I want to add a version number to a new presentation
  In order to display it

  Scenario: Default version number
    Given I use presentation fixture "simple1" with title "My Presentation"
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    v0.0.1
    """
