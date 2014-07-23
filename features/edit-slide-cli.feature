Feature: Edit existing slide

  As a presentator
  I want to add a new slide
  In order do build it

  Scenario: Edit existing slide with ENV['EDITOR']
    Given a fixture app "slides-source-app"
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Headline</h1>
    </section>
    """
    When I successfully run `middleman edit_slide 02 --editor-command echo`
    And the output should contain:
    """
    02.html.erb
    """

  Scenario: Edit non-existing slide with ENV['EDITOR']
    Given a fixture app "slides-source-app"
    When I successfully run `middleman edit_slide 02 --editor-command echo`
    And the output should contain:
    """
    create
    """
    And the output should contain:
    """
    02.html.erb
    """
