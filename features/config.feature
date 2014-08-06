Feature: Configuration

  As a presentator
  I want to a list of configuration options
  In order to use it

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"

  Scenario: Show config
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman config`
    Then the output should contain:
    """
    slides_ignore_file
    """
