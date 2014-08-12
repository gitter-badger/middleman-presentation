Feature: Show available default css classes

  As a presentator
  I want to get a list of css classess which are used in default templates
  In order to know what needs to be defined

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"
    And a fixture app "presentation-after_init-app"
    And I install bundle

  Scenario: Available css classes
    Given I successfully run `middleman style`
    Then the output should contain:
    """
    Available css classes in templates used by middleman-presentation:
    """
    And the output should contain:
    """
    mp-external-url: "contact_slide.tt"
    """

