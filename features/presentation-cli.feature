Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

  @wip
  Scenario: Before init
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me" --email-address me@you.de --github-url http://github.com/me --phone-number 12344`
    Then the file "config.rb" should contain:
    """
    activate :presentation
    """
    And the file "Gemfile" should contain:
    """
    middleman-presentation
    """
    And a file named "bower.json" should exist
    And a file named ".bowerrc" should exist
    And a file named ".gitignore" should exist
    And a file named "source/layout.erb" should exist
    And a file named "source/slides/00.html.erb" should exist
    And a file named "source/index.html.erb" should exist
    And a file named "source/stylesheets/application.scss" should exist
    And a file named "source/javascripts/application.js" should exist
    And a file named "script/run" should exist
    And a directory named "source/images" should exist
    And a directory named "source/vendor/assets/components" should exist
