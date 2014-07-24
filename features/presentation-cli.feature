Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

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
    And a file named "script/start" should exist
    And a file named "Rakefile" should exist
    And a directory named "source/images" should exist
    And a directory named "vendor/assets/components" should exist

  Scenario: Existing configuration file
    Given a mocked home directory
    And  a file named "~/.config/middleman/presentation/presentations.yaml" with:
    """
    author: TestUser
    company: MyCompany
    email_address: test_user@example.com
    homepage: http://example.com
    language: en
    speaker: TestUser
    """
    And a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation"`
