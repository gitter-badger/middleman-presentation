Feature: Show known assets

  As a presentator
  I want to show all known asset files which I can use in my presentation
  In order to have an overview

  @wip
  Scenario: List available assets
    Given I create a new presentation with title "My Presentation"
    When I successfully run `middleman-presentation show assets`
    Then the output should contain:
    """
    | Middleman::Presentation::Helpers::Slides       | MODULE | "yield_slides"                         |
    """
