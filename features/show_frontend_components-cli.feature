Feature: Show available frontend components

  As a presentator
  I want to show all available helpers which I can use in my presentation
  In order to have an overview

  @wip
  Scenario: List available frontend components
    Given I create a new presentation with title "My Presentation"
    When I successfully run `middleman-presentation show frontend_components`
    Then the output should contain:
    """
    | reveal.js                | latest                   | latest  | reveal.js/lib/js/head... |                           |
    """
