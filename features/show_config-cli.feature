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
    When I successfully run `middleman-presentation show config`
    Then the output should contain:
    """
    .ignore
    """

  Scenario: Show config with default values
    When I successfully run `middleman-presentation show config --defaults`
    Then the output should contain:
    """
    .slidesignore
    """
