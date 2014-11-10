Feature: Show available components

  As a presentator
  I want to show all available components which I can use in my presentation
  In order to have an overview

  Scenario: List available components
    Given I use presentation fixture "simple1" with title "My Presentation"
    When I successfully run `middleman-presentation list components`
    Then the output should contain:
    """
    Name:
    """
