Feature: Show known assets

  As a presentator
  I want to show all known asset files which I can use in my presentation
  In order to have an overview

  Scenario: List available assets
    Given I use presentation fixture "simple1" with title "My Presentation"
    When I successfully run `middleman-presentation list assets`
    Then the output should contain:
    """
    Source path
    """
