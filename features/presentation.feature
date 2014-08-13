Feature: Run presentation

  As a presentator
  I want to run an already created presentation
  In order to use it

  Background:
    Given a mocked home directory
    And git is configured with username "User" and email-address "email@example.com"
    And I successfully run `middleman-presentation create presentation presentation1 --title "My Presentation"`
    And I cd to "presentation1"

  Scenario: Simple Slide
    Given a slide named "01.html.erb" with:
    """
    <section>
    </section>
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    Hello World
    """

  Scenario: Malformed Slide
    Given a slide named "01.html.erb" with:
    """
    <section>
    <%= asdfasdf() %>
    </section>
    """
    And the Server is running
    And I go to "/" and see the following error message:
    """
    NoMethodError: undefined method `asdfasdf
    """

  Scenario: Run it
    Given the Server is running
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
    Given the Server is running
    When I go to "/"
    Then I should see:
    """
    slideNumber: true
    """

  Scenario: Project Group template
    Given a project template named "group.tt" with:
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
    <!-- slides/01namespace/01.html.erb -->
    <section>
    <h1>Hello World</h1>
    </section>
    <!-- slides/01namespace/02.html.erb -->
    <section>
    <h1>Hello World</h1>
    </section>
    </section>
    """

  Scenario: Print link
    Given the Server is running
    When I go to "/"
    Then I should see:
    """
    <footer
    """
