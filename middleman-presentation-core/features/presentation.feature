Feature: Run presentation

  As a presentator
  I want to run an already created presentation
  In order to use it

  Background:
    Given I use presentation fixture "presentation1" with title "My Presentation"

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
