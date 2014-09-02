Feature: Export presentation

  As a presentator
  I want to export an already created presentation
  In order to give to the audience

  Background:
    Given I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation" --date "20140901"`
    And I cd to "presentation1"
    And I remove all bundler files

  Scenario: Default file name
    When I successfully run `middleman-presentation export presentation`
    Then a file named "20140901-my-presentation.zip" should exist

  Scenario: Different file name
    When I successfully run `middleman-presentation export presentation --output-file presentation.zip`
    Then a file named "presentation.zip" should exist

  Scenario: Wrong file name
    When I run `middleman-presentation export presentation --output-file presentation.tar.gz`
    Then the output should contain:
    """
    The provided zip filename "presentation.tar.gz" is invalid. It needs to end with ".zip".
    """
