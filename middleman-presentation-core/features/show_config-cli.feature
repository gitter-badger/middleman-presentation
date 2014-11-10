Feature: Configuration

  As a presentator
  I want to a list of configuration options
  In order to use it

  Background:
    Given a user config file for middleman-presentation with:
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

  Scenario: Merge configuration
    Given I use presentation fixture "simple1" with title "My Presentation"
    And a presentation config file for middleman-presentation with:
    """
    bower_directory: blub/asdf
    """
    When I successfully run `middleman-presentation show config`
    Then the output should contain:
    """
    .slidesignore
    """
    Then the output should contain:
    """
    blub/asdf
    """
