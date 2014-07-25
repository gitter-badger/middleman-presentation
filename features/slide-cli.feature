Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  Scenario: Embbeded Ruby Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01 --no-edit`
    Then the following files should exist:
      | source/slides/01.html.erb |

  Scenario: Markdown Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.md --no-edit`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Liquid Template
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.l --no-edit`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Liquid Template (long file extension)
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.liquid --no-edit`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Markdown Template (long file extension)
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.markdown --no-edit`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Open slide with ENV['EDITOR'] after creation
    And a fixture app "slides-source-app"
    When I successfully run `middleman slide 01.markdown --edit --editor-command echo`
    Then the following files should exist:
      | source/slides/01.html.md |
    And the output should contain:
    """
    01.html.md
    """

  Scenario: Create multiple slides
    And a fixture app "slides-source-app"
    When I successfully run `middleman slide 01 02 --no-edit`
    Then the following files should exist:
      | source/slides/01.html.erb |
      | source/slides/02.html.erb |

  Scenario: Edit existing slide with ENV['EDITOR']
    Given a fixture app "slides-source-app"
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide 02 --editor-command echo`
    And the output should contain:
    """
    02.html.erb
    """

  Scenario: Edit non-existing slide with ENV['EDITOR']
    Given a fixture app "slides-source-app"
    When I successfully run `middleman slide 02 --editor-command echo`
    And the output should contain:
    """
    create
    """
    And the output should contain:
    """
    02.html.erb
    """

  Scenario: Edit mixing existing and non-existing slides with ENV['EDITOR']
    Given a fixture app "slides-source-app"
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide 02 03 --editor-command echo`
    And the output should contain:
    """
    02.html.erb
    """
    And the output should contain:
    """
    03.html.erb
    """

  Scenario: Edit existing multiple slides with ENV['EDITOR']
    Given a fixture app "slides-source-app"
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    And a slide named "03.html.erb" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide 02 03 --editor-command echo`
    And the output should contain:
    """
    02.html.erb
    """
    And the output should contain:
    """
    03.html.erb
    """

  Scenario: Fails on duplicate slide names
    Given a fixture app "slides-source-app"
    When I run `middleman slide 02.erb 02.md`
    And the output should contain:
    """
    I found duplicate slide names: "02.erb", "02.md"
    """
