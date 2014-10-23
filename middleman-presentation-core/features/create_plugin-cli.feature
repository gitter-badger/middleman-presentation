Feature: Create a new plugin for middleman presentation

  As a presentator
  I want to create my own plugin
  In order to bundle default configurations

  Scenario: Non existing template
    Given a plugin named "middleman-presentation-new_plugin" does not exist
    When I successfully run `middleman-presentation create plugin middleman-presentation-new_plugin`
    Then a plugin named "middleman-presentation-new_plugin" should exist with default files/directories created
    And a directory named "middleman-presentation-new_plugin" is a git repository
