Feature: Ignore slides

  As a presentator
  I want to ignore some slides in output
  In order to make them invisible

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"
    And I successfully run `middleman-presentation create presentation --title "My Presentation"`

  Scenario: Ignore a slide by basename
    When I successfully run `middleman slide 01 --title "Slide 01"`
    And I successfully run `middleman slide 02 --title "Slide 02"`
    And the Server is running
    And a file named ".slidesignore" with:
    """
    01
    """
    Then the following files should exist:
      | source/slides/01.html.md |
      | source/slides/02.html.md |
    When I go to "/"
    Then I should not see:
    """
    Slide 01
    """
    Then I should see:
    """
    Slide 02
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

  Scenario: Unignore a slide
    When I successfully run `middleman slide 01 --title "Slide 01"`
    And I successfully run `middleman slide 02 --title "Slide 02"`
    And the Server is running
    And a file named ".slidesignore" with:
    """
    \.md
    !02
    """
    Then the following files should exist:
      | source/slides/01.html.md |
      | source/slides/02.html.md |
    When I go to "/"
    Then I should not see:
    """
    Slide 01
    """
    Then I should see:
    """
    Slide 02
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

  Scenario: Warning on invalid ignore file
    Given an empty file named ".slideignore"
    When I run `middleman build`
    Then the output should contain:
    """
    Invalid ignore file
    """
