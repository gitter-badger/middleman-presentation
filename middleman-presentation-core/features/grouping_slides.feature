Feature: Grouping slides

  As a presentator
  I want to group slides
  In order to use vertical slides feature

  Background:
    Given I use presentation fixture "presentation1" with title "My Presentation"

  Scenario: Read slides from filesystem
    Given a slide named "01namespace/01.html.erb" with:
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
    <!-- slides/01namespace/01.html.erb -->
    <section>
    <h1>Hello World</h1>
    </section>
    </section>
    """

  Scenario: Read multiple slides from filesystem
    Given a slide named "01namespace/01.html.erb" with:
    """
    <section>
    <h1>Hello World #1</h1>
    </section>
    """
    And a slide named "01namespace/02.html.erb" with:
    """
    <section>
    <h1>Hello World #2</h1>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <!-- slides/01namespace/01.html.erb -->
    <section>
    <h1>Hello World #1</h1>
    </section>
    <!-- slides/01namespace/02.html.erb -->
    <section>
    <h1>Hello World #2</h1>
    </section>
    </section>
    """

  Scenario: Read multiple slides within multiple groups from filesystem
    Given a slide named "01.html.md" with:
    """
    <section>
    # Test
    </section>
    """
    And a slide named "01namespace/01.html.erb" with:
    """
    <section>
    <h1>Hello World #1.1</h1>
    </section>
    """
    And a slide named "01namespace/02.html.md" with:
    """
    <section>
    # Hello World #1.2
    </section>
    """
    And a slide named "02namespace/01.html.erb" with:
    """
    <section>
    <h1>Hello World #2.1</h1>
    </section>
    """
    And a slide named "02namespace/02.html.erb" with:
    """
    <section>
    <h1>Hello World #2.2</h1>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <!-- slides/01namespace/01.html.erb -->
    <section>
    <h1>Hello World #1.1</h1>
    </section>
    <!-- slides/01namespace/02.html.md -->
    <section>
      <h1 id="hello-world-12">Hello World #1.2</h1>
    </section>
    </section>
    <section>
    <!-- slides/02namespace/01.html.erb -->
    <section>
    <h1>Hello World #2.1</h1>
    </section>
    <!-- slides/02namespace/02.html.erb -->
    <section>
    <h1>Hello World #2.2</h1>
    </section>
    </section>
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
