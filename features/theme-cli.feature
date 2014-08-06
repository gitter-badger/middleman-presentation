Feature: Create new presentation theme

  As a presentator
  I want to create my own presentation template
  In order to have a default theme for all presentations created with middleman-presentation

  Background:
    Given a mocked home directory
    And a fixture app "presentation-after_init-app"
    And I install bundle

  Scenario: Non existing template
    Given a presentation theme named "new_theme" does not exist
    When I successfully run `middleman theme new_theme`
    Then a presentation theme named "new_theme" should exist with default files/directories created
    And a directory named "new_theme" is a git repository

  Scenario: No javascripts
    Given a presentation theme named "new_theme" does not exist
    When I successfully run `middleman theme new_theme --no-javascripts-directory`
    Then a presentation theme named "new_theme" should exist
    And a directory named "new_theme/javascripts" should not exist

  Scenario: No stylesheets
    Given a presentation theme named "new_theme" does not exist
    When I successfully run `middleman theme new_theme --no-stylesheets-directory`
    Then a presentation theme named "new_theme" should exist
    And a directory named "new_theme/stylesheets" should not exist

  Scenario: No images
    Given a presentation theme named "new_theme" does not exist
    When I successfully run `middleman theme new_theme --no-images-directory`
    Then a presentation theme named "new_theme" should exist
    And a directory named "new_theme/images" should not exist

  Scenario: Cleaned css classes
    Given a presentation theme named "new_theme" does not exist
    When I successfully run `middleman theme new_theme --clean-css`
    Then the file "new_theme/stylesheets/_theme.scss" should contain:
    """
    // "999981.html.erb.tt"
    .mp-external-url {
    }
    """

  Scenario: Predefined css classes
    Given a presentation theme named "new_theme" does not exist
    When I successfully run `middleman theme new_theme`
    Then the file "new_theme/stylesheets/_theme.scss" should contain:
    """
    a.mp-external-url:after {
      font-family: "FontAwesome";
      content: "\f08e"; 
      margin-left: 12px;
      margin-right: 12px;
      font-size: 0.7em;
    }
    """
