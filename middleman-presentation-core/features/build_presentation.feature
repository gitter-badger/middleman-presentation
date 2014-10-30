Feature: Build presentation

  As a presentator
  I want to build an already created presentation
  In order to use it

  Background:
    Given I create a new presentation with title "My Presentation"

  Scenario: Default file name
    When I successfully run `middleman-presentation build presentation`
    Then a file named "build/config.ru" should exist
    Then a file named "build/stylesheets/application.css" should exist
    Then a file named "build/javascripts/application.js" should exist
    Then a directory named "build/javascripts/reveal.js" should exist

    @wip @announce
  Scenario: Change loadable default assets
    Given a user config file for middleman-presentation with:
    """
    loadable_assets_for_installed_components: 
      - !ruby/regex /\.png$/,
      - !ruby/regex /\.woff$/,
    """
    #When I successfully run `middleman-presentation build presentation`
    When I run `middleman-presentation build presentation` in debug mode
    Then a file named "build/images/middleman-presentation-theme-default/images/logo-questions.png" should exist
    And a file named "build/images/middleman-presentation-theme-default/images/logo-questions.svg" should not exist
