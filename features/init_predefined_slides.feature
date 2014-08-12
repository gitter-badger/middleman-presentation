Feature: Initialize predefined slides

  As a presentator
  I want to initialize predefined slides
  In order to have defaults for all presentations created with middleman-presentation

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"

  Scenario: Default directory
    When I successfully run `middleman-presentation init predefined_slides`
    Then a file named "~/.config/middleman/presentation/templates/predefined_slides.d/00.html.erb.tt" should exist
