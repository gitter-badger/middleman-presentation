Feature: Show version number

  As a presentator
  I want to add a version number to a new presentation
  In order to display it

  Scenario: Default version number
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    And I successfully run `middleman presentation --title "Test"`
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    v0.0.1
    """
