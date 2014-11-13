Feature: Initialize predefined slides

  As a presentator
  I want to initialize predefined slides
  In order to have defaults for all presentations created with middleman-presentation

  Scenario: Default directory
    When I successfully run `middleman-presentation init predefined_slides`
    Then a file named "~/.config/middleman-presentation/predefined_slides.d/00_00.html.erb.tt" should exist
