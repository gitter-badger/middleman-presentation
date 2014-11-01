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
    # activate_controls: true
    # activate_history: true
    # activate_progress: true
    # activate_slide_number: true
    # audience: ''
    # author: User
    # bower_directory: vendor/assets/components
    # check_for_bower: true
    # clear_source: true
    # cli_language: ''
    # company: ''
    # components: []
    # create_images_directory: true
    # create_javascripts_directory: true
    # create_predefined_slides: true
    # create_stylesheets_directory: true
    # debug_mode: false
    # default_transition_speed: default
    # default_transition_type: linear
    # default_version_number: v0.0.1
    # description: ''
    # edit_changed_slide: false
    # edit_created_slide: false
    # editor_command: vim
    # email: email@example.com
    # email_address: ''
    # error_on_duplicates: true
    # force_create_presentation: false
    # github_url: ''
    # homepage: ''
    # initialize_git: true
    # install_assets: true
    # license: CC BY 4.0
    # location: ''
    # phone_number: ''
    # plugin_prefix: middleman-presentation
    # plugins: []
    # presentation_language: ''
    # slides_directory: slides
    # slides_ignore_file: .slidesignore
    # speaker: my_user
    # theme: {:name=>"middleman-presentation-theme-default", :github=>"maxmeyer/middleman-presentation-theme-default", :importable_files=>[/stylesheets\/middleman-presentation-theme-default.scss$/], :loadable_files=>[/.*\.png$/]}
    # theme_prefix: middleman-presentation-theme
    # view_port: ["960", "700", "0.1"]
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

  Scenario: Local for presentation
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    When I successfully run `middleman-presentation init application --local`
    Then the presentation config file for middleman-presentation should contain:
    """
    """

