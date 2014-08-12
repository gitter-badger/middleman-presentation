Feature: Configuration

  As a presentator
  I want to a list of configuration options
  In order to use it

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"
    And a user config file for middleman-presentation with:
    """
    slides_ignore_file: '.ignore'
    """

  Scenario: Show config
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman-presentation config`
    Then the output should contain:
    """
    .ignore
    """

  Scenario: Show config with default values
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman-presentation config --show-defaults`
    Then the output should contain:
    """
    .slidesignore
    """
