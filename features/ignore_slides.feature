Feature: Ignore slides

  As a presentator
  I want to ignore some slides in output
  In order to make them invisible

  Scenario: Ignore a slide by basename
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    And I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    And a file named ".slidesignore" with:
    """
    01
    """
    And I successfully run `middleman slide 01`
    And I successfully run `middleman slide 02`
    Then the following files should exist:
      | source/slides/01.html.md |
      | source/slides/02.html.md |
    And the Server is running
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

