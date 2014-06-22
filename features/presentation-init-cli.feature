Feature: Initialize middleman-presentation

  As a presentator
  I want to initialize middleman-presentation
  In order to have defaults for all presentations created with middleman-presentation

  @wip
  Scenario: Before init
    Given a fixture app "presentation-before_init-app"
    When I successfully run `middleman presentation_init`
    Then the file "~/.config/middleman-presentation/config.yaml" should contain:
    """
    # speaker: 
    # license: CC BY 4.0
    # bower-directory: vendor/assets/components
    # author: 
    # description: 
    # homepage: 
    # company: 
    # location: 
    # audience: 
    # phone_number: 
    # email_address: 
    # use_open_sans
    # use_jquery
    # use_lightbox
    # use_fedux_org_template: true
    # activate_controls: true
    # activate_progress: true
    # activate_history: true
    # activate_center: true
    # default_transition_type: linear
    # default_transition_speed: default
    # install_assets: true
    # initialize_git: true
    # clear_source: true
    # use_logo: true
    # install_contact_slide: true
    # install_question_slide: true
    # install_end_slide: true
    # language: :de
    """
