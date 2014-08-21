Feature: Show available plugins

  As a presentator
  I want to show all available plugins
  In order to have an overview

  @wip
  Scenario: List available plugins
    Given I create a new presentation with title "My Presentation"
    When I successfully run `middleman-presentation show plugins`
    Then the output should contain:
    """
    | test-simple | middleman-presentation-test-simple | true    |
    """
