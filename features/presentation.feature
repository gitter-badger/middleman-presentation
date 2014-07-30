Feature: Run presentation

  As a presentator
  I want to run an already created presentation
  In order to use it

  Scenario: Run it
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    And I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    My Presentation
    """
    When I go to "javascripts/application.js"
    Then I should see:
    """
    jQuery JavaScript Library
    """
    When I go to "stylesheets/application.css"
    Then I should see:
    """
    Hakim El Hattab
    """
    #When I go to "images/lightbox2/img/close.png"
    #Then the status code should be "200"

  Scenario: Slide number
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    And I successfully run `middleman presentation --title "Test"`
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    slideNumber: true
    """
