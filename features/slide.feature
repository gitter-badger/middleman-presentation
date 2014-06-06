Feature: Slide

  As a creator of a presentation
  I want to show slides
  In order to spent as less time as possible on it

  Scenario: Simple Slide
    Given a fixture app "image_gallery-app"
    And I created a new presentation with title "Title" for speaker "Meee" but kept existing files/directories
    And a directory named "images"
    And a slide named "01.html.erb" with:
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

@wip
  Scenario: Malformed Slide
    Given a fixture app "image_gallery-app"
    And I created a new presentation with title "Title" for speaker "Meee" but kept existing files/directories
    And a directory named "images"
    And a slide named "01.html.erb" with:
    """
    <section>
    <%= asdfasdf() %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    undefined method `asdfasdf' for #<Middleman::Application:
    """
