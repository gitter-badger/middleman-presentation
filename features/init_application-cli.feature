Feature: Initialize middleman-presentation

  As a presentator
  I want to initialize middleman-presentation
  In order to have defaults for all presentations created with middleman-presentation

  Scenario: Before init
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    When I successfully run `middleman-presentation init application`
    Then the file "~/.config/middleman/presentation/presentations.yaml" should contain:
    """
    # activate_center: true
    # activate_controls: true
    # activate_history: true
    # activate_progress: true
    # activate_slide_number: true
    # audience: ''
    # author: my_user
    # bower_directory: vendor/assets/components
    # check_for_bower: true
    # clear_source: true
    # cli_language: en
    # company: ''
    # components: []
    # create_images_directory: true
    # create_javascripts_directory: true
    # create_predefined_slides: true
    # create_stylesheets_directory: true
    # default_transition_speed: default
    # default_transition_type: linear
    # default_version_number: v0.0.1
    # description: ''
    # edit: false
    # editor_command: vim
    # email_address: ''
    # error_on_duplicates: true
    # github_url: ''
    # homepage: ''
    # initialize_git: true
    # install_assets: true
    # license: CC BY 4.0
    # location: ''
    # phone_number: ''
    # plugins_blacklist: []
    # plugins_enable: true
    # plugins_whitelist: []
    # presentation_language: en
    # slides_directory: slides
    # slides_ignore_file: .slidesignore
    # speaker: my_user
    # theme:
    #   name: <name>
    #   github: <github_account>/<repository>
    #   javascripts:
    #     - javascripts/<name>
    #   stylesheets:
    #     - stylesheets/<name>
    # theme_prefix: middleman-presentation-theme
    """

  Scenario: Overwrite existing config file
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    And a file named "~/.config/middleman/presentation/presentations.yaml" with:
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
    Then the file "~/.config/middleman/presentation/presentations.yaml" should contain:
    """
    # activate_center: true
    """
    And the file "~/.config/middleman/presentation/presentations.yaml" should contain:
    """
    # theme:
    #   name: <name>
    #   github: <github_account>/<repository>
    #   javascripts:
    #     - javascripts/<name>
    #   stylesheets:
    #     - stylesheets/<name>
    """
