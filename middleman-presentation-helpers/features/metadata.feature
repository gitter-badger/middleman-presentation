Feature: Add meta data fields

  As a creator of a presentation
  I want to use meta data from configuration
  In order to display them on the slides

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Generate meta data
    Given a presentation config file for middleman-presentation with:
    """
    author: 'Max'
    """
    And a slide named "01.html.erb" with:
    """
    <section>
    <%= metadata_markup([:author], [:author]) %>
    </section>
    """
    When the Server is running
    And I go to "/"
    Then I should see:
    """
    Max
    """

  Scenario: Unknown field
    Given a slide named "01.html.erb" with:
    """
    <section>
    <%= metadata_markup([:author], []) %>
    </section>
    """
    When the Server is running
    And I go to "/" and see the following error message:
    """
    You entered an unknown metadata field "author".
    """
