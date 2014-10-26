Feature: Rename slide

  As a presentator
  I want to rename an already existing slide
  In order to make its name fit the need

  Background:
    Given I create a new presentation with title "My Presentation"

  @future
  Scenario: Full-name
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 --base-name 02.html.md`
    Then a slide named "02.html.md" should exist

  @wip
  Scenario: Full-name for multiple files
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 02 --base-name 02.html.md`
    Then the output should contain:
    """
    Error
    """

    @future
  Scenario: File suffix
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation change slide 01 --type md`
    Then a slide named "01.html.md" should exist

    @future
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

    @future
  Scenario: Non existing slide
    Given a slide named "01.html.erb" does not exist
    When I successfully run `middleman-presentation change slide 01 --type md`
    Then the output should contain:
    """
    Error
    """
