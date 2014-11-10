Feature: Support plugins for middleman-presentation

  As a presentator
  I want to group assets and helpers in a plugin
  In order to make them more re-usable

  Background:
    Given a user config file for middleman-presentation with:
    """
    plugins:
      - middleman-presentation-simple_plugin
    """
    And I use presentation fixture "plugins1" with title "My Presentation"

  Scenario: Use method in plugin
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    <%= test_simple_helper1 %>
    </section>
    """
    And a slide named "02.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    <%= test_simple_helper2 %>
    </section>
    """
    And the Server is running
    When I go to "/"
    Then I should see:
    """
    <section>
    <h1>Hello World</h1>
    test_simple_helper1
    </section>
    """
    And I should see:
    """
    <section>
    <h1>Hello World</h1>
    test_simple_helper2
    </section>
    """

  Scenario: Use asset in plugin
    Given I add a stylesheet asset named "test_simple" to the presentation
    And the Server is running
    When I go to "/stylesheets/application.css"
    Then I should see:
    """
    .test_simple {
      color: black; }
    """

  Scenario: Use frontend from plugin
    Given the Server is running
    When I go to "/javascripts/application.js"
    Then I should see:
    """
    angular
    """
