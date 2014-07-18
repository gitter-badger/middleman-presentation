Feature: Initialize middleman-presentation

  As a presentator
  I want to initialize middleman-presentation
  In order to have defaults for all presentations created with middleman-presentation

  Scenario: Before init
    Given a fixture app "presentation-before_init-app"
    And a mocked home directory
    And I set the environment variables to:
    | variable | value  |
    | USER     | my_user|
    When I successfully run `middleman presentation_init`
    Then the file "~/.config/middleman/presentation/presentations.yaml" should contain:
    """
    # activate_center: true
    # activate_controls: true
    # activate_history: true
    # activate_progress: true
    # audience: 
    # author: my_user
    # bower_directory: vendor/assets/components
    # clear_source: true
    # company: 
    # default_transition_speed: default
    # default_transition_type: linear
    # description: 
    # email_address: 
    # homepage: 
    # initialize_git: true
    # install_assets: true
    # install_contact_slide: true
    # install_end_slide: true
    # install_question_slide: true
    # language: de
    # license: CC BY 4.0
    # location: 
    # phone_number: 
    # speaker: my_user
    # use_fedux_org_template: true
    # use_jquery: false
    # use_lightbox: false
    # use_logo: true
    # use_open_sans: false
    """
