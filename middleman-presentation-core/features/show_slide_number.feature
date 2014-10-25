Feature: Show slide number on slides

  As a presentator
  I want to show the number of the current slide on the current slide
  In order to make the audience aware what comes next

  Scenario: Slide number is activated
    Given a user config file for middleman-presentation with:
    """
    activate_slide_number: true
    """
    And I create a new presentation with title "My Presentation"
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    slideNumber: true
    """

  Scenario: Slide number is not activated
    Given a user config file for middleman-presentation with:
    """
    activate_slide_number: false
    """
    And I create a new presentation with title "My Presentation"
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    slideNumber: false
    """
