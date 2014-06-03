Feature: Image Gallery

  As a creator of a presentation
  I want to create image galleries easily
  In order to spent as less time as possible on it

  @wip
  Scenario: Images only
    Given a fixture app "presentation-before_init-app"
    And I created a new presentation with title "Title" for speaker "Meee"
    And the Server is running
    And a directory named "images"
    And a slide named "01.html.erb" with:
    """
    <section>
    <%= image_gallery %W{ images/image01.png images/image02.png} %>
    </section>
    """
    And I go to "/"
    Then I should see:
    """
    asdf
    """
