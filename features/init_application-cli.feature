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
    # audience:
    # author: my_user
    # bower_directory: vendor/assets/components
    # check_for_bower: true
    # clear_source: true
    # company:
    # components: []
    # create_predefined_slides: true
    # default_transition_speed: default
    # default_transition_type: linear
    # default_version_number: v0.0.1
    # description:
    # edit: false
    # editor_command: vim
    # email_address:
    # error_on_duplicates: true
    # homepage:
    # initialize_git: true
    # install_assets: true
    # language: de
    # license: CC BY 4.0
    # location:
    # phone_number:
    # speaker: my_user
    # theme: {}
    """

  Scenario: Overwrite existing config file
    Given I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    And a file named "~/.config/middleman/presentation/presentations.yaml" with:
    """
    # activate_center: true
    """
    When I successfully run `middleman-presentation init application --force`
    Then the file "~/.config/middleman/presentation/presentations.yaml" should contain:
    """
    # activate_center: true
    # activate_controls: true
    # activate_history: true
    # activate_progress: true
    # activate_slide_number: true
    # audience:
    # author: my_user
    # bower_directory: vendor/assets/components
    # check_for_bower: true
    # clear_source: true
    # company:
    # components: []
    # create_predefined_slides: true
    # default_transition_speed: default
    # default_transition_type: linear
    # default_version_number: v0.0.1
    # description:
    # edit: false
    # editor_command: vim
    # email_address:
    # error_on_duplicates: true
    # homepage:
    # initialize_git: true
    # install_assets: true
    # language: de
    # license: CC BY 4.0
    # location:
    # phone_number:
    # speaker: my_user
    # theme: {}
    """
