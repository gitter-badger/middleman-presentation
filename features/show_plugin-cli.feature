Feature: Show available plugins

  As a presentator
  I want to show all available plugins
  In order to have an overview

  @wip
  Scenario: List available plugins
    Given I successfully run `middleman-presentation create presentation1 --title "My Presentation"`
    And I cd to "presentation1"
    And I installed plugin "test-simple"
    When I successfully run `bundle exec middleman-presentation show plugins`
    Then the output should contain:
    """
    test-simple
    """

