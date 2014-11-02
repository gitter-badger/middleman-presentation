Feature: Initialize middleman-presentation

  As a presentator
  I want to initialize middleman-presentation
  In order to have defaults for all presentations created with middleman-presentation

  Scenario: Before init
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    When I successfully run `middleman-presentation init application`
    Then the user config file for middleman-presentation should contain:
    """
    # activate_center: true
    """

  Scenario: Overwrite existing config file
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    And a user config file for middleman-presentation with:
    """
    # activate_center: false
    # theme:
    #   name: new_theme
    #   github: account/new_theme
    #   javascripts:
    #     - javascripts/new_theme
    #   stylesheets:
    #     - stylesheets/new_theme
    """
    When I successfully run `middleman-presentation init application --force`
    Then the user config file for middleman-presentation should contain:
    """
    # activate_center: true
    """
    And the user config file for middleman-presentation should contain:
    """
    # theme: {:name=>"middleman-presentation-theme-default", :github=>"maxmeyer/middleman-presentation-theme-default", :importable_files=>[/stylesheets\/middleman-presentation-theme-default.scss$/], :loadable_files=>[/.*\.png$/]}
    """

    @wip
  Scenario: Local for presentation
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    And I create a new presentation with title "My Presentation"
    When I successfully run `middleman-presentation init application --local`
    Then the presentation config file for middleman-presentation should contain:
    """
    title: My Presentation
    """
    And the presentation config file for middleman-presentation should contain:
    """
    version: v0.0.1
    """
    And the presentation config file for middleman-presentation should contain:
    """
    speaker: my_user
    """
