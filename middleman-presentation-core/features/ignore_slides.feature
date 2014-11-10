Feature: Ignore slides

  As a presentator
  I want to ignore some slides in output
  In order to make them invisible

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Ignore a slide by basename
    Given a slide named "01.html.md" with:
    """
    <section>
    # Slide 01
    </section>
    """
    And a slide named "02.html.md" with:
    """
    <section>
    # Slide 02
    </section>
    """
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
    Given a slide named "01.html.md" with:
    """
    <section>
    # Slide 01
    </section>
    """
    And a slide named "02.html.md" with:
    """
    <section>
    # Slide 02
    </section>
    """
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
