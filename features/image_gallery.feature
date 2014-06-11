Feature: Image Gallery

  As a creator of a presentation
  I want to create image galleries easily
  In order to spent as less time as possible on it

  Scenario: Images only
    Given a fixture app "image_gallery-app"
    And I created a new presentation with title "Title" for speaker "Meee" but kept existing files/directories
    And a directory named "images"
    And a slide named "01.html.erb" with:
    """
    <section>
    <h1>Image Gallery</h1>
    <%= image_gallery %W{images/image01.png images/image02.png}, image_gallery_id: 'test-gallery' %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <h1>Image Gallery</h1>
    <a href="images/image01.png" data-lightbox="test-gallery">
      <img src="images/image01.png" class="fd-preview-image">
    </a>
    <a href="images/image02.png" data-lightbox="test-gallery">
      <img src="images/image02.png" class="fd-preview-image">
    </a>
    </section>
    """

  @wip
  Scenario: Images with titles
    Given a fixture app "image_gallery-app"
    And I created a new presentation with title "Title" for speaker "Meee" but kept existing files/directories
    And a directory named "images"
    And a slide named "01.html.erb" with:
    """
    <section>
    <h1>Image Gallery</h1>
    <%= image_gallery({'images/image01.png' => 'Title 1', 'images/image02.png' => 'Title 2'}, image_gallery_id: 'test-gallery') %>
    </section>
    """
    And the Server is running
    And I go to "/"
    Then I should see:
    """
    <section>
    <h1>Image Gallery</h1>
    <a href="images/image01.png" data-lightbox="test-gallery">
      <img src="images/image01.png" alt="Title 1" class="fd-preview-image">
    </a>
    <a href="images/image02.png" data-lightbox="test-gallery">
      <img src="images/image02.png" alt="Title 2" class="fd-preview-image">
    </a>
    </section>
    """
