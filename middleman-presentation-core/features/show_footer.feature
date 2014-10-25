Feature: Show footer

  As a presentator
  I want to show a footer fot the presentation
  In order to make to add some meta information

  Scenario: Print link
    Given I create a new presentation with title "My Presentation"
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    <footer
    """
