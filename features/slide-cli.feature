Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  @wip
  Scenario: Embbeded Ruby Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01`
    Then the following files should exist:
      | source/slides/01.html.erb |

  @wip
  Scenario: Markdown Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.md`
    Then the following files should exist:
      | source/slides/01.html.md |

  @wip
  Scenario: Markdown Template (long file name extension)
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.markdown`
    Then the following files should exist:
      | source/slides/01.html.md |
