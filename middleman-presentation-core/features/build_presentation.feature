Feature: Build presentation

  As a presentator
  I want to build an already created presentation
  In order to use it

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Build it
    When I successfully run `middleman-presentation build presentation`
    And I cd to "build"
    Then a file named "config.ru" should exist
    Then a file named "javascripts/application.js" should exist
    Then a file named "index.html" should exist
    Then a file named "stylesheets/application.css" should exist
    Then a file named "javascripts/application.js" should exist
    Then a file named "javascripts/reveal.js/plugin/highlight/highlight.js" should exist
    Then a file named "javascripts/reveal.js/plugin/zoom-js/zoom.js" should exist
    Then a file named "javascripts/reveal.js/plugin/notes/notes.js" should exist
    Then a file named "stylesheets/middleman-presentation-helpers/print/pdf.css" should exist

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

  Scenario: Minify assets
    Given a user config file for middleman-presentation with:
    """
    minify_assets: true
    """
    And a file named "source/stylesheets/test.scss" with:
    """
    .test1 {
      font-size: 1px;
    }

    .test2 {
      font-size: 1px;
    }

    .test3 {
      font-size: 1px;
    }

    .test4 {
      font-size: 1px;
    }
    """
    When I successfully run `middleman-presentation build presentation`
    Then the size of "build/stylesheets/test.css" should be much smaller than from  "source/stylesheets/test.scss"
