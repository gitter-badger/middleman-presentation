Feature: Use templates for new slides

  As a presentator
  I want to add a new slide based on a template
  In order do build it

  Scenario: Project Erb Slide template
    And a project template named "erb.tt" with:
    """
    <section>
    <h1>New Template</h1>
    <h2><%= title %></h2>
    </section>
    """
    When I successfully run `middleman-presentation create slide 01.erb --title "My Title"`
    Then a slide named "01.html.erb" should exist with:
    """
    <section>
    <h1>New Template</h1>
    <h2>My Title</h2>
    </section>
    """

  Scenario: Project Markdown Slide template
    And a project template named "markdown.tt" with:
    """
    <section>
    # New Template
    ## <%= title %>
    </section>
    """
    When I successfully run `middleman-presentation create slide 01.md --title "My Title"`
    Then a slide named "01.html.md" should exist with:
    """
    <section>
    # New Template
    ## My Title
    </section>
    """

  Scenario: Project Liquid Slide template
    And a project template named "liquid.tt" with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2><%= title %><h2>
    </section>
    """
    When I successfully run `middleman-presentation create slide 01.liquid --title "My Title"`
    Then a slide named "01.html.liquid" should exist with:
    """
    <section>
    <h1>{{ page_title }}</h1>
    <h2>My Title<h2>
    </section>
    """

  Scenario: User markdown template 
    Given a user template named "markdown.tt" with:
    """
    <section>
    # Hey ya
    </section>
    """
    When I successfully run `middleman-presentation create slide 01.md --title "My Title"`
    Then a slide named "01.html.md" should exist with:
    """
    <section>
    # Hey ya
    </section>
    """

  Scenario: Custom default template
    When I successfully run `middleman-presentation create slide 01 --title "My Title"`
    Then a slide named "01.html.md" should exist with:
    """
    <section>
    # My Title
    </section>
    """

  Scenario: Custom user markdown template
    Given a user template named "custom.md.tt" with:
    """
    <section>
    # <%= title %>
    </section>
    """
    When I successfully run `middleman-presentation create slide 01 --title "My Title"`
    Then a slide named "01.html.md" should exist with:
    """
    <section>
    # My Title
    </section>
    """

  Scenario: Custom user erb template
    Given a user template named "custom.erb.tt" with:
    """
    <section>
    <h1><%= title %></h1>
    </section>
    """
    When I successfully run `middleman-presentation create slide 01 --title "My Title"`
    Then a slide named "01.html.erb" should exist with:
    """
    <section>
    <h1>My Title</h1>
    </section>
    """

