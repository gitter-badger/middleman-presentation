Feature: Edit slide

  As a presentator
  I want to edit an already existing slide
  In order to make changes

  Background:
    Given I create a new presentation with title "My Presentation"

  Scenario: Existing slide
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    When I successfully run `middleman-presentation edit slide 01 --editor-command echo`
    Then the output should contain:
    """
    01.html.erb
    """

  Scenario: Matching regular expression
    Given a slide named "01.html.erb" with:
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
    When I successfully run `middleman-presentation edit slide '0\d\d' --editor-command echo --regex`
    Then the output should not contain:
    """
    01.html.erb
    """
    And the output should contain:
    """
    002.html.erb
    """

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
    When I successfully run `middleman-presentation edit slide 0 --type md --regex --editor-command echo`
    Then the output should not contain:
    """
    01.html.erb
    """
    And the output should not contain:
    """
    02.html.erb
    """

  Scenario: Multiple slides
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
    When I successfully run `middleman-presentation edit slide 01 02 --editor-command echo`
    Then the output should contain:
    """
    01.html.erb
    """
    And the output should contain:
    """
    02.html.erb
    """

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
    When I successfully run `middleman-presentation edit slide --editor-command echo`
    Then the output should contain:
    """
    01.html.erb
    """
    And the output should contain:
    """
    02.html.erb
    """

  Scenario: Non-Existing slide
    Given a slide named "01.html.erb" does not exist
    When I successfully run `middleman-presentation edit slide 01 --editor-command echo`
    Then the output should not contain:
    """
    01.html.erb
    """
