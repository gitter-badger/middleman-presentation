Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  Scenario: Custom Slide
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Embedded Ruby Slide
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.erb`
    Then the following files should exist:
      | source/slides/01.html.erb |

  Scenario: Markdown Slide
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.md`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Liquid Slide
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.l`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Liquid Slide (long file extension)
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.liquid`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Markdown Slide (long file extension)
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.markdown`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Open slide with ENV['EDITOR'] after creation
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.markdown --edit --editor-command echo`
    Then the following files should exist:
      | source/slides/01.html.md |
    And the output should contain:
    """
    01.html.md
    """

  Scenario: Create multiple slides
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01 02`
    Then the following files should exist:
      | source/slides/01.html.md |
      | source/slides/02.html.md |

  Scenario: Edit existing slide with ENV['EDITOR']
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "02.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide 02 --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """

  Scenario: Edit non-existing slide with ENV['EDITOR']
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 02 --edit --editor-command echo`
    And the output should contain:
    """
    create
    """
    And the output should contain:
    """
    02.html.md
    """

  Scenario: Edit mixing existing and non-existing slides with ENV['EDITOR']
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "02.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide 02 03 --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """
    And the output should contain:
    """
    03.html.md
    """

  Scenario: Edit existing multiple slides with ENV['EDITOR']
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "02.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    And a slide named "03.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide 02 03 --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """
    And the output should contain:
    """
    03.html.md
    """

  Scenario: Fails on duplicate slide names
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I run `middleman slide 02.erb 02.md 03.erb 03.md 03.liquid`
    And the output should contain:
    """
    Your input will result in duplicate slide file names: "02.html.md", "02.html.erb", "03.html.md", "03.html.liquid", "03.html.erb", "03.html.liquid", "03.html.erb", "03.html.md"
    """

  Scenario: Missing slide name
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I run `middleman slide`
    Then the output should contain:
    """
    You need to define argument "name"
    """

  Scenario: Using eruby in editor command
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 02 03 --edit --editor-command "echo <%= project_id %>"`
    Then the output should contain:
    """
    my-title-aasdfasfd
    """

  Scenario: Using eruby in editor command and shell escape
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 02 03 --edit --editor-command "echo <%= Shellwords.shellescape(project_id) %>"`
    Then the output should contain:
    """
    my-title-aasdfasfd
    """

  Scenario: Use * expansion in shell to open slides
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "02.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman slide source/slides/* --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """

  Scenario: Project Erb Slide template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "erb.tt" with:
    """
    <section>
    <h1>New Template</h1>
    <h2><%= title %></h2>
    </section>
    """
    When I successfully run `middleman slide 01.erb --title "My Title"`
    Then a slide named "01.html.erb" exist with:
    """
    <section>
    <h1>New Template</h1>
    <h2>My Title</h2>
    </section>
    """

  Scenario: Project Markdown Slide template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "markdown.tt" with:
    """
    <section>
    # New Template
    ## <%= title %>
    </section>
    """
    When I successfully run `middleman slide 01.md --title "My Title"`
    Then a slide named "01.html.md" exist with:
    """
    <section>
    # New Template
    ## My Title
    </section>
    """

  Scenario: Project Liquid Slide template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "liquid.tt" with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2><%= title %><h2>
    </section>
    """
    When I successfully run `middleman slide 01.liquid --title "My Title"`
    Then a slide named "01.html.liquid" exist with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2>My Title<h2>
    </section>
    """

  Scenario: User template
    Given a mocked home directory
    And a user template named "liquid.tt" with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2><%= title %><h2>
    </section>
    """
    And a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.liquid --title "My Title"`
    Then a slide named "01.html.liquid" exist with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2>My Title<h2>
    </section>
    """

  Scenario: Custom default template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01 --title "My Title"`
    Then a slide named "01.html.md" exist with:
    """
    <section>
    # My Title
    </section>
    """

  Scenario: Custom user markdown template
    Given a mocked home directory
    And a user template named "custom.md.tt" with:
    """
    <section>
    # <%= title %>
    </section>
    """
    And a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01 --title "My Title"`
    Then a slide named "01.html.md" exist with:
    """
    <section>
    # My Title
    </section>
    """

  Scenario: Custom user erb template
    Given a mocked home directory
    And a user template named "custom.erb.tt" with:
    """
    <section>
    <h1><%= title %></h1>
    </section>
    """
    And a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01 --title "My Title"`
    Then a slide named "01.html.erb" exist with:
    """
    <section>
    <h1>My Title</h1>
    </section>
    """
