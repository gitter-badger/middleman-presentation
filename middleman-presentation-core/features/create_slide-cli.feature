Feature: Add new slide

  As a presentator
  I want to add a new slide
  In order do build it

  Background:
    Given I create a new presentation with title "My Presentation"

  Scenario: Custom Slide
    When I successfully run `middleman-presentation create slide 01`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Embedded Ruby Slide
    When I successfully run `middleman-presentation create slide 01.erb`
    Then the following files should exist:
      | source/slides/01.html.erb |

  Scenario: Markdown Slide
    When I successfully run `middleman-presentation create slide 01.md`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Liquid Slide
    When I successfully run `middleman-presentation create slide 01.l`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Liquid Slide (long file extension)
    When I successfully run `middleman-presentation create slide 01.liquid`
    Then the following files should exist:
      | source/slides/01.html.liquid |

  Scenario: Markdown Slide (long file extension)
    When I successfully run `middleman-presentation create slide 01.markdown`
    Then the following files should exist:
      | source/slides/01.html.md |

  Scenario: Open slide with ENV['EDITOR'] after creation
    When I successfully run `middleman-presentation create slide 01.markdown --edit --editor-command echo`
    Then the following files should exist:
      | source/slides/01.html.md |
    And the output should contain:
    """
    01.html.md
    """

  Scenario: Create multiple slides
    When I successfully run `middleman-presentation create slide 01 02`
    Then the following files should exist:
      | source/slides/01.html.md |
      | source/slides/02.html.md |

  Scenario: Edit existing slide with ENV['EDITOR']
    And a slide named "02.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman-presentation create slide 02 --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """

  Scenario: Edit non-existing slide with ENV['EDITOR']
    When I successfully run `middleman-presentation create slide 02 --edit --editor-command echo`
    And the output should contain:
    """
    create
    """
    And the output should contain:
    """
    02.html.md
    """

  Scenario: Edit mixing existing and non-existing slides with ENV['EDITOR']
    And a slide named "02.html.md" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman-presentation create slide 02 03 --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """
    And the output should contain:
    """
    03.html.md
    """

  Scenario: Edit existing multiple slides with ENV['EDITOR']
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
    When I successfully run `middleman-presentation create slide 02 03 --edit --editor-command echo`
    And the output should contain:
    """
    02.html.md
    """
    And the output should contain:
    """
    03.html.md
    """

  Scenario: Fails on duplicate slide names
    When I run `middleman-presentation create slide 02.erb 02.md 03.erb 03.md 03.liquid`
    And the output should contain:
    """
    Your input will result in duplicate slide file names "02.html.md", "02.html.erb", "03.html.md", "03.html.liquid", "03.html.erb", "03.html.liquid", "03.html.erb", "03.html.md"
    """

  Scenario: Missing slide name
    When I run `middleman-presentation create slide`
    Then the output should contain:
    """
    No value provided for required arguments 'names'
    """

  Scenario: Using eruby in editor command
    When I successfully run `middleman-presentation create slide 02 03 --edit --editor-command "echo <%= project_id %>"`
    Then the output should contain:
    """
    my-presentation
    """

  Scenario: Using eruby in editor command and shell escape
    When I successfully run `middleman-presentation create slide 02 03 --edit --editor-command "echo <%= Shellwords.shellescape(project_id) %>"`
    Then the output should contain:
    """
    my-presentation
    """

  Scenario: Output information that a slide was created
    When I successfully run `middleman-presentation create slide 01`
    Then the output should contain:
    """
    create    slides/01.html.md
    """

  Scenario: Output information that multiple slides were created
    When I successfully run `middleman-presentation create slide 01 02 03`
    Then the output should contain:
    """
    create    slides/01.html.md
    create    slides/02.html.md
    create    slides/03.html.md
    """

  Scenario: Output information that a slide already exists
    When I successfully run `middleman-presentation create slide 01`
    When I successfully run `middleman-presentation create slide 01`
    Then the output should contain:
    """
    exist     slides/01.html.md
    """

  Scenario: Output information that multiple slides already exist
    When I successfully run `middleman-presentation create slide 01 02 03`
    When I successfully run `middleman-presentation create slide 01 02 03`
    Then the output should contain:
    """
    exist     slides/01.html.md
    """

  Scenario: Create Group of slides in subfolder
    When I successfully run `middleman-presentation create slide 01namespace:01`
    Then the following files should exist:
      | source/slides/01namespace/01.html.md |

  Scenario: Create Group with same name as slide
    When I successfully run `middleman-presentation create slide 01:01`
    Then the following files should exist:
      | source/slides/01/01.html.md |

