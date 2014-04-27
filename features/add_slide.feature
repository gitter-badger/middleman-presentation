Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  @wip
  Scenario: Not existing slide
    Given a directory named "slides"
    When I successfully run `middleman slide 01`
    Then a file named "01.html.erb" should exist
