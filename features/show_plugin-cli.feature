Feature: Show available plugins

  As a presentator
  I want to show all available plugins
  In order to have an overview

  @wip
  Scenario: List available plugins
    Given I successfully run `middleman-presentation create presentation1 --title "My Presentation"`
    And I cd to "presentation1"
    And I add plugin "test-simple"
    And I install bundle
    When I successfully run `bundle exec middleman-presentation show plugins` in clean environment
    Then the output should contain:
    """
    | test-simple | middleman-presentation-test-simple | true    |
    """
