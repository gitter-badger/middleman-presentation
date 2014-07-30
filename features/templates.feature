Feature: Using different templates for slides and groups

  As a presentator
  I want to use different templates for slides
  In order to make them suitable for me/the audience

  Scenario: Erb Slide template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "erb.tt" with:
    """
    <section>
    <h1>New Template</h1>
    <h2><%= title %></h2>
    </section>
    """
    When I successfully run `middleman slide 01.erb --title "My Title"`
    Then a slide named "01.html.erb" exist with:
    """
    <section>
    <h1>New Template</h1>
    <h2>My Title</h2>
    </section>
    """

  Scenario: Markdown Slide template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "markdown.tt" with:
    """
    <section>
    # New Template
    ## <%= title %>
    </section>
    """
    When I successfully run `middleman slide 01.md --title "My Title"`
    Then a slide named "01.html.md" exist with:
    """
    <section>
    # New Template
    ## My Title
    </section>
    """

  Scenario: Liquid Slide template
    Given a fixture app "presentation-after_init-app"
    And I install bundle
    And a project template named "liquid.tt" with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2><%= title %><h2>
    </section>
    """
    When I successfully run `middleman slide 01.liquid --title "My Title"`
    Then a slide named "01.html.liquid" exist with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2>My Title<h2>
    </section>
    """

@wip
  Scenario: Group template
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
    <section>
    <h1>Hello World</h1>
    </section>
    <section>
    <h1>Hello World</h1>
    </section>
    </section>
    """

  Scenario: User template
    Given a mocked home directory
    And a user template named "liquid.tt" with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2><%= title %><h2>
    </section>
    """
    And a fixture app "presentation-after_init-app"
    And I install bundle
    When I successfully run `middleman slide 01.liquid --title "My Title"`
    Then a slide named "01.html.liquid" exist with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2>My Title<h2>
    </section>
    """
