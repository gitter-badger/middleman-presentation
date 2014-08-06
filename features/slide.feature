Feature: Slide

  As a creator of a presentation
  I want to show slides
  In order to spent as less time as possible on it

  Background:
    Given a mocked home directory
    And a fixture app "image_gallery-app"

  Scenario: Simple Slide
    Given I created a new presentation with title "Title" for speaker "Meee" but kept existing files/directories
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

  Scenario: Malformed Slide
    Given I created a new presentation with title "Title" for speaker "Meee" but kept existing files/directories
    And a directory named "images"
    And a slide named "01.html.erb" with:
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
