Feature: Show footer

  As a presentator
  I want to show a footer fot the presentation
  In order to make to add some meta information

  Scenario: Print link
    Given I use presentation fixture "simple1" with title "My Presentation"
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    <footer
    """
