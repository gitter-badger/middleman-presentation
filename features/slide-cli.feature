Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  Scenario: Embbeded Ruby Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01`
    Then the following files should exist:
      | source/slides/01.html.erb |

  Scenario: Markdown Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.md`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Liquid Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.l`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Liquid Template (long file extension)
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.liquid`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Markdown Template (long file extension)
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.markdown`
    Then the following files should exist:
      | source/slides/01.html.md |
