Feature: Run presentation

  As a presentator
  I want to run an already created presentation
  In order to use it

  Background:
    Given a mocked home directory

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

  Scenario: Project Group template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "group.tt" with:
    """
    <section>
    <h1>Group Title</h1>
    <%= slides %>
    </section>
    """
    And a slide named "01namespace/01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And a slide named "01namespace/02.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    <section>
    <h1>Group Title</h1>
    <!-- source/slides/01namespace/01.html.erb -->
    <section>
    <h1>Hello World</h1>
    </section>
    <!-- source/slides/01namespace/02.html.erb -->
    <section>
    <h1>Hello World</h1>
    </section>
    </section>
    """
