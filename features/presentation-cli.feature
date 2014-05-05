Feature: Initialize presentation

  As a presentator
  I want to create a new presentation
  In order to use it

  @wip
  Scenario: Before init
    Given a fixture app "presentation-before_init-app"
    And I initialized middleman for a new presentation
    When I successfully run `middleman presentation --title "My Presentation" --speaker "Me"`
    Then the file "config.rb" should contain:
    """
    activate :presentation
    """
