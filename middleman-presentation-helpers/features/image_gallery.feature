Feature: Image Gallery

  As a creator of a presentation
  I want to create image galleries easily
  In order to spent as less time as possible on it

  Background:
    Given I use presentation fixture "image_gallery" with title "My Presentation"
    And an image "image01.png" at "images/image01.png"
    And an image "image02.png" at "images/image02.png"

  Scenario: Images only
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Image Gallery</h1>
    <%= image_gallery %W{images/image01.png images/image02.png}, id: 'test-gallery' %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <h1>Image Gallery</h1>
    <a href="images/image01.png" data-lightbox="test-gallery">
      <img src="images/image01.png" class="mp-preview-image">
    </a>
    <a href="images/image02.png" data-lightbox="test-gallery">
      <img src="images/image02.png" class="mp-preview-image">
    </a>
    </section>
    """
    When I go to "/stylesheets/application.css"
    Then I should see:
    """
    overflow: scroll;
    """

  Scenario: Images with titles
    Given a slide named "01.html.erb" with:
    """
    <section>
    <h1>Image Gallery</h1>
    <%= image_gallery({'images/image01.png' => 'Title 1', 'images/image02.png' => 'Title 2'}, id: 'test-gallery') %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <h1>Image Gallery</h1>
    <a href="images/image01.png" data-lightbox="test-gallery">
      <img src="images/image01.png" alt="Title 1" class="mp-preview-image">
    </a>
    <a href="images/image02.png" data-lightbox="test-gallery">
      <img src="images/image02.png" alt="Title 2" class="mp-preview-image">
    </a>
    </section>
    """
