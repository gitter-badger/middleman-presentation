Feature: Use plugins to add features

  As a presentator
  I want to create my own plugins
  In order to add new features middleman-presentation

  Scenario: List available plugins
    Given I installed plugin "test-simple"
    When I successfully run `middleman-presentation list plugins`
    Then the output should contain:
    """
    test-simple
    """

