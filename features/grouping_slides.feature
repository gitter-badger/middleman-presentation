Feature: Grouping slides

  As a presentator
  I want to group slides
  In order to use vertical slides feature

  Scenario: Create slides in subfolder
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01namespace:01`
    Then the following files should exist:
      | source/slides/01namespace/01.html.md |

  Scenario: Read slides from filesystem
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "01namespace/01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <section>
    <h1>Hello World</h1>
    </section>
    </section>
    """

  Scenario: Read multiple slides from filesystem
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "01namespace/01.html.erb" with:
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
    <section>
    <h1>Hello World #1</h1>
    </section>
    <section>
    <h1>Hello World #2</h1>
    </section>
    </section>
    """

  @wip
  Scenario: Read multiple slides within multiple groups from filesystem
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a slide named "01.html.md" with:
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
    <section>
    <h1>Hello World #1.1</h1>
    </section>
    <section>
    <h1>Hello World #1.2</h1>
    </section>
    </section>
    
    <section>
    <section>
    <h1>Hello World #2.1</h1>
    </section>
    <section>
    <h1>Hello World #2.2</h1>
    </section>
    </section>
    """
