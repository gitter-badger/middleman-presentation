Feature: Build presentation

  As a presentator
  I want to build an already created presentation
  In order to use it

  Background:
    Given I create a new presentation with title "My Presentation"

  Scenario: Build it
    When I successfully run `middleman-presentation build presentation`
    And I cd to "build"
    Then a file named "config.ru" should exist
    Then a file named "stylesheets/application.css" should exist
    Then a file named "javascripts/application.js" should exist
    Then a file named "index.html" should exist
    Then a file named "stylesheets/application.css" should exist
    Then a file named "javascripts/application.js" should exist
    Then a file named "stylesheets/reveal.js/css/print/pdf.css" should exist
    Then a file named "javascripts/reveal.js/plugin/highlight/highlight.js" should exist
    Then a file named "javascripts/reveal.js/plugin/zoom-js/zoom.js" should exist
    Then a file named "javascripts/reveal.js/plugin/notes/notes.js" should exist
    Then a file named "stylesheets/middleman-presentation/print/pdf.css" should exist

  Scenario: Change loadable default assets
    Given a user config file for middleman-presentation with:
    """
    loadable_assets_for_installed_components: 
      - !ruby/regex \.png$
      - !ruby/regex \.woff$
    """
    When I successfully run `middleman-presentation build presentation`
    And I cd to "build"
    Then a file named "images/middleman-presentation-theme-default/images/logo-questions.png" should exist
    And a file named "images/middleman-presentation-theme-default/images/logo-questions.svg" should not exist
    Then a file named "fonts/fontawesome/fonts/fontawesome-webfont.woff" should exist
    Then a file named "fonts/fontawesome/fonts/fontawesome-webfont.eot" should not exist
    Then a file named "fonts/fontawesome/fonts/fontawesome-webfont.ttf" should not exist

