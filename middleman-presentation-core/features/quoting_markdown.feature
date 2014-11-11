Feature: Change quotes

  As a presentator
  I want to use the quotes which are suitable for my mother tung
  In order to make it look good

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Default quotes
    Given a slide named "01.html.md" with:
    """
    <section>
    # "Hello World"
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    “Hello World”
    """

  Scenario: German quotes
    Given a presentation config file for middleman-presentation with:
    """
    smart_quotes:
      - lsquo # opening '
      - rsquo # closing '
      - bdquo # opening "
      - rdquo # opening "
    """
    And a slide named "01.html.md" with:
    """
    <section>
    # "Hello World"
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    „Hello World”
    """
