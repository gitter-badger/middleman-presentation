Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  @wip
  Scenario: Not existing slide
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01`
    Then the following files should exist:
      | source/slides/01.html.erb |

    @wip
  Scenario: Already existing slide
    Given a fixture app "slides-source-app"
    And a file named "source/slides/01.html.erb" exist
    When I successfully run `middleman slide 01`
    Then the following files should exist:
      | source/slides/01.html.erb |
