Feature: Show available helpers

  As a presentator
  I want to show all available helpers which I can use in my presentation
  In order to have an overview

  Scenario: List available helpers
    Given I use presentation fixture "simple1" with title "My Presentation"
    When I successfully run `middleman-presentation list helpers`
    Then the output should contain:
    """
    | Name
    """
