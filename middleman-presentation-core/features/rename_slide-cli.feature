Feature: Rename slide

  As a presentator
  I want to rename an already existing slide
  In order to make its name fit the need

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Full-name
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 --base-name 02`
    Then a slide named "02.html.erb" should exist

  Scenario: Full-name for multiple files
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I run `middleman-presentation change slide 01 02 --base-name 02.html.md`
    Then the output should contain:
    """
    You pass to many arguments. Only "1" argument(s) are allowed.
    """

  Scenario: File suffix
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 --type md`
    Then a slide named "01.html.md" should exist

  Scenario: File suffix with prefixing dot
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 --type .md`
    Then a slide named "01.html.md" should exist

  Scenario: File suffix for multiple files
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 02 --type md`
    Then a slide named "01.html.md" should exist
    And a slide named "02.html.md" should exist

  Scenario: Missing slide name = All existing slides
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide --type md`
    Then a slide named "01.html.md" should exist
    Then a slide named "02.html.md" should exist

  Scenario: Matching substring
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 0 --type md --regex`
    Then a slide named "01.html.md" should exist
    Then a slide named "02.html.md" should exist

  Scenario: Matching regular expression
    Given a slide named "00.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And a slide named "002.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide '0[0-1]' --type md --regex`
    Then a slide named "00.html.md" should exist
    Then a slide named "01.html.md" should exist

  Scenario: Change erb => md automatically
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01`
    Then a slide named "01.html.md" should exist

  Scenario: Change md => erb automatically
    Given a slide named "01.html.md" with:
    """
    <section>
    # Hello World
    </section>
    """
    When I successfully run `middleman-presentation change slide 01`
    Then a slide named "01.html.erb" should exist

  Scenario: Change other => md automatically
    Given a slide named "01.html.liquid" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01`
    Then a slide named "01.html.md" should exist

  Scenario: Non existing slide
    Given a slide named "01.html.erb" does not exist
    When I run `middleman-presentation change slide 01 --type md`
    Then the output should contain:
    """
    I cannot find a slide which matches "01"
    """

  Scenario: Edit after change
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 --type md --edit --editor-command echo`
    Then the output should contain:
    """
    01.html.erb
    """
