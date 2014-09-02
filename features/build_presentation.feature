Feature: Build presentation

  As a presentator
  I want to build an already created presentation
  In order to use it

  Background:
    Given I create a new presentation with title "My Presentation"

  Scenario: Default file name
    When I successfully run `middleman-presentation build presentation`
    Then a file named "build/config.ru" should exist
    Then a directory named "build/stylesheets" should exist
    Then a directory named "build/javascripts" should exist
