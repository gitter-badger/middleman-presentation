Feature: Run presentation

  As a presentator
  I want to run an already created presentation
  In order to use it

  Background:
    Given I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation" --date "20140901"`
    And I cd to "presentation1"

  Scenario: Default file name
    When I successfully run `middleman-presentation export`
    Then a file named "20140901-my_presentation.tar.gz" should exist

  Scenario: Different file name
    When I successfully run `middleman-presentation export --output-file presentation.zip`
    Then the file "presentation.tar.gz" should exist

  Scenario: Wrong file name
    When I successfully run `middleman-presentation export --output-file presentation.tar.gz`
    Then the file "presentation.tar.gz" should exist
