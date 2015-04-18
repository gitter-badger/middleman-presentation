Feature: Run presentation

  As a presentator
  I want to run an already created presentation
  In order to use it

  Background:
    Given I use presentation fixture "simple1" with title "My Presentation"

  Scenario: Simple Slide
    Given a slide named "01.html.erb" with:
    """
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

    @wip
  Scenario: Erb with mermaid diagram
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Hello World</h1>
    </section>
    <pre>
    <code class="mermaid">
    graph LR;
    A[Hard edge]-->B(Round edge);
    B-->C{Decision};
    C-->D[Result one];
    C-->E[Result two];
    style A fill:#FF0000;
    style B fill:#00FF00;
    style C fill:#0000FF;
    style D fill:#FFF000;
    style E fill:#0FFFF0;
    </code>
    </pre>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <svg>
    """

    @wip
  Scenario: Markdown with mermaid diagram
    Given a slide named "01.html.md" with:
    """
    <section>
    # Hello World

    ~~~mermaid
    graph LR;
    A[Hard edge]-->B(Round edge);
    B-->C{Decision};
    C-->D[Result one];
    C-->E[Result two];
    style A fill:#FF0000;
    style B fill:#00FF00;
    style C fill:#0000FF;
    style D fill:#FFF000;
    style E fill:#0FFFF0;
    ~~~
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <svg>
    """
