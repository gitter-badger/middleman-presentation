Feature: Render different kind of templates

  As a presentator
  I want to use the template engine which fits best for a given use case
  In order to reduce the amount of time to create a new presentation

  Background:
    Given I use presentation fixture "presentation1" with title "My Presentation"

  Scenario: Markdown Slide
    Given a slide named "01.html.md" with:
    """
    <section>
    # Hello world
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
      <h1 id="hello-world">Hello world</h1>
    </section>
    """

  Scenario: Erb Slide
    Given a slide named "01.html.erb" with:
    """
    <section>
    <%= 'test_string' %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    test_string
    </section>
    """

  Scenario: Liquid Slide
    Given a slide named "01.html.liquid" with:
    """
    <section>
    {{ 'test_string' }}
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    test_string
    </section>
    """

  Scenario: Markdown + Erb Slide
    Given a slide named "01.html.md.erb" with:
    """
    <section>
    # Hello world

    <%= 'test_string' %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
      <h1 id="hello-world">Hello world</h1>
    
      <p>test_string</p>
    </section>
    """
