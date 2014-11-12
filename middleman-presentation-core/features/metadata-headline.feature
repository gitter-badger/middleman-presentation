Feature: Display metadata in headline

  As a presentator
  I want to display metadata in the headline of the first slide
  In order to show them to the audience

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Display only requested fields
    Given a presentation config file for middleman-presentation with:
    """
    speaker: Max Mustermann
    date: 2014-05-01
    metadata_footer: []
    metadata_headline:
      - speaker
    """
    Given the Server is running
    And I go to "/"
    Then I should see:
    """
    Max Mustermann
    """
    Then I should not see:
    """
    2014-05-01
    """
