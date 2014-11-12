Feature: Display metadata in footer

  As a presentator
  I want to display metadata on the first slide and in the footer
  In order to show them to the audience

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Display only requested fields
    Given a presentation config file for middleman-presentation with:
    """
    speaker: Max Mustermann
    date: 2014-05-01
    metadata_footer:
      - speaker
    metadata_headline: []
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
